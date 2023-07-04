import 'dart:async';
import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../utils/exercise.dart';
import '../utils/rep_counter.dart';
import '../utils/constants.dart';
import '../utils/form_classifier.dart';
import '../utils/pose_detector.dart';
import '../utils/isolate_util.dart';
import '../utils/sample_input_pose.dart';
import '../utils/workout_session.dart';

class CameraScreen extends StatefulWidget {
  late final List<CameraDescription> cameras;
  final Exercise exercise;
  final WorkoutSession session;

  CameraScreen({
    required this.exercise,
    required this.session,
    super.key,
  });

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen>
    with WidgetsBindingObserver {
  late CameraController cameraController;
  CameraImage? cameraImage;

  // Initializing isolate and classifier objects
  late PoseDetector classifier;
  late IsolateUtils isolate;

  // Boolean flags for prediction and camera initialization
  bool predicting = false;
  bool initialized = false;

  late List<dynamic> inferences;
  double paddingX = 0;
  double paddingY = 0;

  // RepCounter-related fields
  bool warmupMode = false;
  bool warmedUpAtLeastOnce = false;
  bool allowRestMode = false;
  bool currentlyRestingMode = false;
  int _warmupSecondsRemaining = 15;
  late int _restSecondsRemaining;
  List<int> warmupInferences = [];
  bool countingRepsMode = false;
  List<int> countingRepsInferences = [];
  late RepCounter repCounter;
  int currentSetCount = 0;

  // FormClassifier-related fields
  double formCorrectness = 0.0;
  late FormClassifier formClassifier;

  @override
  void initState() {
    repCounter = RepCounter(maxRepCount: widget.session.reps);
    formClassifier =
        FormClassifier(confidenceModel: widget.exercise.formCorrectnessModel);
    _restSecondsRemaining = widget.session.restTime;
    super.initState();
    initAsync();
  }

  void initAsync() async {
    widget.cameras = await availableCameras();

    setState(() {
      cameraController = CameraController(
        widget.cameras[1],
        ResolutionPreset.ultraHigh,
        enableAudio: false,
        imageFormatGroup: ImageFormatGroup.bgra8888,
      );
    });

    isolate = IsolateUtils();
    await isolate.start();

    classifier = PoseDetector();
    classifier.loadModel();

    startCamera();
  }

  void startCamera() {
    cameraController.initialize().then((_) {
      if (!mounted) {
        return;
      } else {
        cameraController.startImageStream((imageStream) {
          createIsolate(imageStream);
        });
      }
    }).catchError((e) {
      print(e);
    });
  }

  void createIsolate(CameraImage imageStream) async {
    if (predicting == true) {
      return;
    }

    setState(() {
      predicting = true;
    });

    var isolateData = IsolateData(imageStream, classifier.interpreter.address);

    Map<String, List<dynamic>> inferenceResultsMap =
        await inference(isolateData);

    List<dynamic> inferenceResultsNormalised =
        inferenceResultsMap['resultsNormalised'] as List<dynamic>;
    // print(inferenceResultsNormalised);
    formClassifier.runModel(inferenceResultsNormalised);
    // print(formClassifier.outputConfidence.getDoubleList()[0]);
    formCorrectness = formClassifier.outputConfidence.getDoubleList()[0];

    List<dynamic> inferenceResults =
        inferenceResultsMap['resultsCoordinates'] as List<dynamic>;

    if (warmupMode == true) {
      warmupInferences.add(inferenceResults[widget.exercise.trackedKeypoint]
          [widget.exercise.trackingDirection]);
    }

    if (countingRepsMode == true &&
        inferenceResults[widget.exercise.trackedKeypoint][2] >= 0.2) {
      repCounter.startCounting(inferenceResults[widget.exercise.trackedKeypoint]
          [widget.exercise.trackingDirection]);
      if (repCounter.currentRepCount >= repCounter.maxRepCount) {
        countingRepsMode = false;
      }
    }

    setState(() {
      inferences = inferenceResults;
      predicting = false;
      initialized = true;
    });

    // print(inferenceResults[widget.exercise.trackedKeypoint][widget.exercise.trackingDirection]);
  }

  Future<Map<String, List<dynamic>>> inference(IsolateData isolateData) async {
    ReceivePort responsePort = ReceivePort();
    isolate.sendPort.send(isolateData..responsePort = responsePort.sendPort);
    var results = await responsePort.first;
    return results;
  }

  void startWarmupTimer() {
    _warmupSecondsRemaining = 15;
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_warmupSecondsRemaining > 0) {
          _warmupSecondsRemaining--;
        } else {
          timer.cancel();
        }
      });
    });
  }

  void startRestTimer() {
    _restSecondsRemaining = widget.session.restTime;
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_restSecondsRemaining > 0) {
          _restSecondsRemaining--;
        } else {
          timer.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Stack(
            children: [
              ///
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: paddingX,
                  vertical: paddingY,
                ),
                child: initialized
                    ? SizedBox(
                        // height: MediaQuery.of(context).size.height,
                        // width: MediaQuery.of(context).size.width,
                        child: CustomPaint(
                          foregroundPainter: RenderLandmarks(inferences),
                          child: !cameraController.value.isInitialized
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : CameraPreview(cameraController),
                        ),
                      )
                    : SizedBox(
                        width: cameraController.value.previewSize?.width,
                        height: cameraController.value.previewSize?.height,
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
              ),
              Positioned(
                bottom: 60,
                right: 24,
                child: Text(
                  "$currentSetCount / ${widget.session.sets} sets",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Positioned(
                bottom: 24,
                right: 24,
                child: Text(
                  "${repCounter.currentRepCount} / ${widget.session.reps} reps",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Visibility(
                visible: countingRepsMode || warmupMode,
                child: Positioned(
                  bottom: 24,
                  left: 24,
                  child: Text(
                    // "${(formCorrectness * 100).toStringAsFixed(2)}%",
                    formCorrectness > 0.5 ? "Correct" : "Incorrect",
                    style: TextStyle(
                      color: formCorrectness > 0.5 ? Colors.green : Colors.red,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          // Text(warmupInferences.toString()),

          /// Row containing buttons for user interaction
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /// ElevatedButton for Warmup Mode
              ElevatedButton(
                onPressed: () {
                  /// When this button is clicked, the app should:
                  /// 1- Track a set of frames for a given period of time
                  /// 2- Across all these frames, track the nose
                  /// (you should now have an array of y values for the nose)
                  /// 3- Get the min and max altitude
                  warmupInferences.clear();
                  warmupMode = true;
                  startWarmupTimer();
                  Timer(const Duration(seconds: 15), () {
                    warmupMode = false;
                    repCounter.warmup(warmupInferences);
                    warmedUpAtLeastOnce = true;
                  });
                  // print(warmupInferences);
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.grey[900],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  minimumSize: const Size(150.0, 60.0),
                  textStyle: const TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                child:
                    Text(warmupMode ? "$_warmupSecondsRemaining s" : 'Warmup'),
              ),

              /// SizedBox for button seperation
              const SizedBox(width: 16.0),

              /// ElevatedButton for Counting Reps Mode
              ElevatedButton(
                onPressed: () {
                  if (warmedUpAtLeastOnce) {
                    if (allowRestMode) {
                      currentSetCount++;
                      if (currentSetCount < widget.session.sets) {
                        currentlyRestingMode = true;
                        startRestTimer();
                        Timer(Duration(seconds: widget.session.restTime), () {
                          allowRestMode = false;
                          currentlyRestingMode = false;
                          repCounter.resetRepCount();
                        });
                      } else {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              backgroundColor: Colors.grey[900],
                              title: const Text(
                                'Congratulations!',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              content: const Text(
                                'You have finished your workout.',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text(
                                    'OK',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }
                    }
                    // repCounter.resetRepCount();
                    countingRepsMode = true;
                    allowRestMode = true;
                  } else {
                    Fluttertoast.showToast(
                        msg: "You should warm up first",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  }
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  minimumSize: const Size(150.0, 60.0),
                  textStyle: const TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                child: Text(allowRestMode
                    ? currentlyRestingMode
                        ? "$_restSecondsRemaining s"
                        : 'Rest'
                    : 'Start'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // App state changed before we got the chance to initialize.
    if (!cameraController.value.isInitialized) {
      return;
    }
    if (state == AppLifecycleState.inactive) {
      // Free up memory when camera not active
      cameraController.dispose();
    }
  }

  @override
  void dispose() {
    cameraController.dispose();
    isolate.stop();
    super.dispose();
  }
}

class RenderLandmarks extends CustomPainter {
  late List<dynamic> inferenceList;
  late PointMode pointMode;
  final double showPointConfidence = 0.2;
  final double correctPointConfidence = 0.4;
  double paddingX = 0;
  double paddingY = 10;

  final refImageW = pose['image_width'];
  final refImageH = pose['image_height'];
  List<Offset> pointsReference = [];

  RenderLandmarks(List<dynamic> inferences) {
    inferenceList = inferences;
  }

  var pointBlue = Paint()
    ..color = Colors.blue.shade900
    ..strokeCap = StrokeCap.round
    ..strokeWidth = 12;

  var edgeWhite = Paint()
    ..color = Colors.white
    ..strokeWidth = 6;

  var pointGreen = Paint()
    ..color = Colors.green
    ..strokeCap = StrokeCap.round
    ..strokeWidth = 12;

  var edgeGreen = Paint()
    ..color = Colors.lightGreen
    ..strokeWidth = 6;

  // INCORRECT POSTURE COLOR PROFILE
  var pointRed = Paint()
    ..color = Colors.red.shade900
    ..strokeCap = StrokeCap.round
    ..strokeWidth = 12;

  var edgeRed = Paint()
    ..color = Colors.red.shade300
    ..strokeWidth = 6;

  List<Offset> pointsGreen = [];
  List<Offset> pointsRed = [];

  List<dynamic> edges = [
    [0, 1], // nose to left_eye
    [0, 2], // nose to right_eye
    [1, 3], // left_eye to left_ear
    [2, 4], // right_eye to right_ear
    [0, 5], // nose to left_shoulder
    [0, 6], // nose to right_shoulder
    [5, 7], // left_shoulder to left_elbow
    [7, 9], // left_elbow to left_wrist
    [6, 8], // right_shoulder to right_elbow
    [8, 10], // right_elbow to right_wrist
    [5, 6], // left_shoulder to right_shoulder
    [5, 11], // left_shoulder to left_hip
    [6, 12], // right_shoulder to right_hip
    [11, 12], // left_hip to right_hip
    [11, 13], // left_hip to left_knee
    [13, 15], // left_knee to left_ankle
    [12, 14], // right_hip to right_knee
    [14, 16] // right_knee to right_ankle
  ];

  @override
  void paint(Canvas canvas, Size size) {
    renderEdge(canvas, size);
    canvas.drawPoints(PointMode.points, pointsGreen, pointGreen);
    canvas.drawPoints(PointMode.points, pointsRed, pointRed);
    // renderEdgeReference(canvas, size);
    // canvas.drawPoints(PointMode.points, pointsReference, pointBlue);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

  void renderEdgeReference(Canvas canvas, Size size) {
    if (pose['keypoints'] != null) {
      for (var point in pose['keypoints']!) {
        pointsReference.add(
          Offset(
            point['x'].toDouble() * size.width,
            point['y'].toDouble() * size.height,
          ),
        );
      }
    }

    for (List<int> edge in edges) {
      double vertex1X = pose['keypoints'][edge[0]]['x'].toDouble() * size.width;
      double vertex1Y =
          pose['keypoints'][edge[0]]['y'].toDouble() * size.height;
      double vertex2X = pose['keypoints'][edge[1]]['x'].toDouble() * size.width;
      double vertex2Y =
          pose['keypoints'][edge[1]]['y'].toDouble() * size.height;
      canvas.drawLine(
        Offset(vertex1X, vertex1Y),
        Offset(vertex2X, vertex2Y),
        edgeWhite,
      );
    }
  }

  void renderEdge(Canvas canvas, Size size) {
    if (pose['keypoints'] != null) {
      for (var point in pose['keypoints']!) {
        pointsReference.add(
          Offset(
            point['x'].toDouble() * size.width,
            point['y'].toDouble() * size.height,
          ),
        );
      }
    }

    for (List<dynamic> point in inferenceList) {
      if (point[2] > showPointConfidence) {
        if (point[2] < correctPointConfidence) {
          pointsRed.add(
            Offset(
              point[0].toDouble() * size.width / kWidthMultiplier,
              point[1].toDouble() * size.height / kHeightMultiplier,
            ),
          );
        } else {
          pointsGreen.add(
            Offset(
              point[0].toDouble() * size.width / kWidthMultiplier,
              point[1].toDouble() * size.height / kHeightMultiplier,
            ),
          );
        }
      }
    }

    for (List<int> edge in edges) {
      if (inferenceList[edge[0]][2] > showPointConfidence &&
          inferenceList[edge[1]][2] > showPointConfidence) {
        double vertex1X = inferenceList[edge[0]][0].toDouble() *
            size.width /
            kWidthMultiplier;
        double vertex1Y = inferenceList[edge[0]][1].toDouble() *
            size.height /
            kHeightMultiplier;
        double vertex2X = inferenceList[edge[1]][0].toDouble() *
            size.width /
            kWidthMultiplier;
        double vertex2Y = inferenceList[edge[1]][1].toDouble() *
            size.height /
            kHeightMultiplier;
        final point1Confidence = inferenceList[edge[0]][2];
        final point2Confidence = inferenceList[edge[1]][2];
        // debugPrint("p1: $point1Confidence, p2: $point2Confidence");
        if (point1Confidence > correctPointConfidence &&
            point2Confidence > correctPointConfidence) {
          canvas.drawLine(
            Offset(vertex1X, vertex1Y),
            Offset(vertex2X, vertex2Y),
            edgeGreen,
          );
        } else {
          canvas.drawLine(
            Offset(vertex1X, vertex1Y),
            Offset(vertex2X, vertex2Y),
            edgeRed,
          );
        }
      }
    }
  }
}
