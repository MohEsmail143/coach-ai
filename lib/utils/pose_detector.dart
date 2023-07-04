import 'dart:io';
import 'dart:math';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as image_lib;
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';
import 'constants.dart';

class PoseDetector {
  late Interpreter _interpreter;
  late ImageProcessor imageProcessor;
  late TensorImage inputImage;
  late List<Object> inputs;
  Map<int, Object> outputs = {};
  TensorBuffer outputLocations = TensorBufferFloat([]);

  int frameNo = 0;

  PoseDetector({Interpreter? interpreter}) {
    loadModel(interpreter: interpreter);
  }

  loadModel({Interpreter? interpreter}) async {
    try {
      InterpreterOptions? interpreterOptions;
      /* GPU delegate code
      if (Platform.isAndroid) {
        final gpuDelegateV2 = GpuDelegateV2(
          options: GpuDelegateOptionsV2(
            isPrecisionLossAllowed: false,
            inferencePreference: TfLiteGpuInferenceUsage.fastSingleAnswer,
            inferencePriority1: TfLiteGpuInferencePriority.minLatency,
            inferencePriority2: TfLiteGpuInferencePriority.auto,
            inferencePriority3: TfLiteGpuInferencePriority.auto,
          ),
        );

        interpreterOptions = InterpreterOptions()
          ..addDelegate(gpuDelegateV2)
          ..threads = 4;
      } else if (Platform.isIOS) {
        final gpuDelegateMetal = GpuDelegate(
          options: GpuDelegateOptions(
            allowPrecisionLoss: true,
            waitType: TFLGpuDelegateWaitType.active,
          ),
        );
        interpreterOptions = InterpreterOptions()
          ..addDelegate(gpuDelegateMetal)
          ..threads = 4;
      }
      */

      _interpreter = interpreter ??
          await Interpreter.fromAsset(
            "models/movenet.tflite",
            // "movenet_singlepose_thunder.tflite",
            options: interpreterOptions ?? InterpreterOptions()
              ..threads = 4,
          );
    } catch (e) {
      debugPrint("Error while creating interpreter: $e");
    }
    /* Testing code
    var outputTensors = interpreter.getOutputTensors();
    var inputTensors = interpreter.getInputTensors();
    List<List<int>> _outputShapes = [];

    outputTensors.forEach((tensor) {
      print("Output Tensor: " + tensor.toString());
      _outputShapes.add(tensor.shape);
    });
    inputTensors.forEach((tensor) {
      print("Input Tensor: " + tensor.toString());
    });

    print("------------------[A}========================\n" +
        _outputShapes.toString());
    */

    outputLocations = TensorBufferFloat([1, 1, 17, 3]);

    // print(outputLocations);
  }

  runModel() async {
    Map<int, Object> outputs = {0: outputLocations.buffer};
    interpreter.runForMultipleInputs(inputs, outputs);
    // print(outputLocations.getDoubleList());
  }

  parseLandmarkData() {
    List<double> data = outputLocations.getDoubleList();
    List result = [];
    int x, y;
    double c;

    for (var i = 0; i < 51; i += 3) {
      y = (data[0 + i] * kHeightMultiplier).toInt();
      x = (data[1 + i] * kWidthMultiplier).toInt();
      c = (data[2 + i]);
      result.add([x, y, c]);
    }

    return result;
  }

  parseData() {
    List<double> data = outputLocations.getDoubleList();
    List result = [];
    List resultNormalised = [];
    int x, y;
    double c;

    for (var i = 0; i < 51; i += 3) {
      // Normalised coordinates
      resultNormalised.add([data[i], data[i + 1], data[i + 2]]);

      // Actual Coordinates
      y = (data[0 + i] * kHeightMultiplier).toInt();
      x = (data[1 + i] * kWidthMultiplier).toInt();
      c = (data[2 + i]);
      result.add([x, y, c]);
    }

    Map<String, List<dynamic>> resultMap = {
      'resultsNormalised': resultNormalised,
      'resultsCoordinates': result,
    };

    return resultMap;
  }

  void performOperations(CameraImage cameraImage) {
    image_lib.Image convertedImage;
    if (Platform.isAndroid) {
      convertedImage = convertCameraImageAndroid(cameraImage);
      convertedImage = image_lib.copyRotate(convertedImage, 270);
      convertedImage = image_lib.flipHorizontal(convertedImage);
    } else {
      convertedImage = convertCameraImage(cameraImage);
    }
    inputImage = TensorImage(TfLiteType.float32);
    inputImage.loadImage(convertedImage);
    inputImage = getProcessedImage();

    inputs = [inputImage.buffer];

    frameNo += 1;
  }

  static image_lib.Image convertCameraImageAndroid(CameraImage cameraImage) {
    final int width = cameraImage.width;
    final int height = cameraImage.height;

    final int uvRowStride = cameraImage.planes[1].bytesPerRow;
    final int? uvPixelStride = cameraImage.planes[1].bytesPerPixel;

    final image = image_lib.Image(width, height);

    for (int w = 0; w < width; w++) {
      for (int h = 0; h < height; h++) {
        final int uvIndex =
            uvPixelStride! * (w / 2).floor() + uvRowStride * (h / 2).floor();
        final int index = h * width + w;

        final y = cameraImage.planes[0].bytes[index];
        final u = cameraImage.planes[1].bytes[uvIndex];
        final v = cameraImage.planes[2].bytes[uvIndex];

        image.data[index] = yuv2rgb(y, u, v);
      }
    }
    return image;
  }

  static image_lib.Image convertCameraImage(CameraImage cameraImage) {
    return image_lib.Image.fromBytes(
      cameraImage.width,
      cameraImage.height,
      cameraImage.planes[0].bytes,
      format: image_lib.Format.bgra,
    );
  }

  static int yuv2rgb(int y, int u, int v) {
    // Convert yuv pixel to rgb
    int r = (y + v * 1436 / 1024 - 179).round();
    int g = (y - u * 46549 / 131072 + 44 - v * 93604 / 131072 + 91).round();
    int b = (y + u * 1814 / 1024 - 227).round();

    // Clipping RGB values to be inside boundaries [ 0 , 255 ]
    r = r.clamp(0, 255);
    g = g.clamp(0, 255);
    b = b.clamp(0, 255);

    return 0xff000000 |
        ((b << 16) & 0xff0000) |
        ((g << 8) & 0xff00) |
        (r & 0xff);
  }

  TensorImage getProcessedImage() {
    int padSize = max(inputImage.height, inputImage.width);
    imageProcessor = ImageProcessorBuilder()
        .add(ResizeWithCropOrPadOp(padSize, padSize))
        .add(ResizeOp(256, 256, ResizeMethod.BILINEAR))
        .build();

    inputImage = imageProcessor.process(inputImage);
    return inputImage;
  }

  Interpreter get interpreter => _interpreter;
}

double getAngle(List<int> pointA, List<int> pointB, List<int> pointC) {
  double radians = atan2(pointC[1] - pointB[1], pointC[0] - pointB[0]) -
      atan2(pointA[1] - pointB[1], pointA[0] - pointB[0]);
  double angle = (radians * 180 / pi).abs();

  if (angle > 180) {
    angle = 360 - angle;
  }

  return angle;
}

double getSlope(List<double> pointA, List<double> pointB) {
  return (pointB[1] - pointA[1]) / (pointB[0] - pointA[0]);
}

double getAngleTwoPoints(List<double> line1A, List<double> line1B,
    List<double> line2A, List<double> line2B) {
  final slope1 = getSlope(line1A, line1B);
  final slope2 = getSlope(line1A, line1B);
  if (slope1 * slope2 == -1) {
    return 90.00;
  }
  double radians = atan((slope1 - slope2) / (1 + slope1 * slope2));
  double angle = (radians * 180 / pi).abs();
  if (angle > 180) {
    angle = 360 - angle;
  }
  return angle;
}
