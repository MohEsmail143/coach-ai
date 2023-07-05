import 'dart:async';
import 'dart:isolate';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sensors_plus/sensors_plus.dart';

import '../utils/camera/coach_tts.dart';
import '../utils/exercise.dart';
import '../utils/camera/rep_counter.dart';
import '../utils/camera/form_classifier.dart';
import '../utils/camera/pose_detector.dart';
import '../utils/camera/pose_detector_isolate.dart';

import '../utils/workout_session.dart';
import '../utils/camera/render_landmarks.dart';

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

  /// Initializing isolate and classifier objects
  late PoseDetector classifier;
  late PoseDetectorIsolate isolate;

  /// Boolean flags for prediction and camera initialization
  bool predicting = false;
  bool initialized = false;

  late List<dynamic> inferences;
  double paddingX = 0;
  double paddingY = 0;

  /// WARM UP MODE-RELATED FIELDS
  bool warmupMode = false;
  bool warmedUpAtLeastOnce = false;
  int _warmupSecondsRemaining = 15;
  List<int> warmupInferences = [];

  /// ******************************

  /// REST MODE-RELATED FIELDS
  bool allowRestMode = false;
  bool currentlyRestingMode = false;
  late int _restSecondsRemaining;

  /// ******************************

  /// COUNTING REPS MODE-RELATED FIELDS
  late RepCounter repCounter;
  bool countingRepsMode = false;
  List<int> countingRepsInferences = [];
  int currentSetCount = 0;

  /// ******************************

  /// SENSOR-RELATED FIELDS
  late StreamSubscription<AccelerometerEvent> _accelerometerSubscription;
  double _accelerationMagnitude = 0.0;
  late bool isNotMoving;

  /// ******************************

  /// FormClassifier-related fields
  double formCorrectness = 0.0;
  late FormClassifier formClassifier;

  /// ******************************

  /// FlutterTTS-related field
  CoachTTS tts = CoachTTS();

  /// ******************************

  void showInstructions() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.grey[900],
          title: const Text(
            'Instructions',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: widget.exercise.cameraInstructions.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    "- ${widget.exercise.cameraInstructions[index]}",
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                );
              },
            ),
          ),
          actions: [
            TextButton(
              child: const Text(
                'OK',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    repCounter = RepCounter(maxRepCount: widget.session.reps);
    formClassifier =
        FormClassifier(confidenceModel: widget.exercise.formCorrectnessModel);
    _restSecondsRemaining = widget.session.restTime;

    /****** SENSOR-RELATED CODE ******/
    _accelerometerSubscription =
        accelerometerEvents.listen((AccelerometerEvent event) {
      // Calculate the magnitude of the acceleration vector
      _accelerationMagnitude =
          event.x * event.x + event.y * event.y + event.z * event.z;
    });
    isNotMoving = _accelerationMagnitude == 0.0;
    /*********************************/

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

    isolate = PoseDetectorIsolate();
    await isolate.start();

    classifier = PoseDetector();
    classifier.loadModel();

    tts.speak(
        "Welcome to Coach.ai! Please read the following instructions carefully.");
    showInstructions();

    startCameraStream();
  }

  void startCameraStream() {
    cameraController.initialize().then((_) {
      if (!mounted) {
        return;
      } else {
        cameraController.startImageStream((imageStream) {
          communicateWithIsolate(imageStream);
        });
      }
    }).catchError((e) {
      if (kDebugMode) {
        print(e);
      }
    });
  }

  void communicateWithIsolate(CameraImage imageStream) async {
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

    if (warmupMode) {
      warmupInferences.add(inferenceResults[widget.exercise.trackedKeypoint]
          [widget.exercise.trackingDirection]);
    }

    if (isNotMoving &&
        countingRepsMode &&
        inferenceResults[widget.exercise.trackedKeypoint][2] >= 0.3) {
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
          tts.speak("Time's up! Let's get back to work.");
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
                visible: warmupMode ||
                    countingRepsMode && !currentlyRestingMode && allowRestMode,
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
                    tts.speak(
                        "You have now finished your warmup. You can start exercising now! Don't worry, I will tell you each time you perform a rep, and when you complete a set.");
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
                  if (warmedUpAtLeastOnce && !currentlyRestingMode) {
                    if (allowRestMode &&
                        (currentSetCount < widget.session.sets)) {
                      currentSetCount++;
                      tts.speak(
                          "You have finished your set! Take a ${widget.session.restTime} second break and come back.");
                      if (currentSetCount < widget.session.sets) {
                        currentlyRestingMode = true;
                        startRestTimer();
                        Timer(
                          Duration(seconds: widget.session.restTime),
                          () {
                            allowRestMode = false;
                            currentlyRestingMode = false;
                            repCounter.resetRepCount();
                          },
                        );
                      } else {
                        tts.speak(
                            "Well done! You have completed your workout! Great Job!");
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
                  } else if (!warmedUpAtLeastOnce) {
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
    tts.tts.stop();
    cameraController.dispose();
    _accelerometerSubscription.cancel();
    isolate.stop();
    super.dispose();
  }
}
