import 'dart:isolate';

import 'package:camera/camera.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

import 'pose_detector.dart';

class PoseDetectorIsolate {
  static const String debugName = "InferenceIsolate";

  // ignore: unused_field
  late Isolate _isolate;
  final ReceivePort _receivePort = ReceivePort();
  late SendPort _sendPort;

  SendPort get sendPort => _sendPort;

  Future<void> start() async {
    _isolate = await Isolate.spawn<SendPort>(
      entryPoint,
      _receivePort.sendPort,
      debugName: debugName,
    );
    _sendPort = await _receivePort.first;
  }

  static void entryPoint(SendPort sendPort) async {
    final port = ReceivePort();
    sendPort.send(port.sendPort);

    await for (final IsolateData isolateData in port) {
      PoseDetector classifier = PoseDetector(
          interpreter: Interpreter.fromAddress(isolateData.interpreterAddress));
      classifier.performOperations(isolateData.cameraImage);
      classifier.runModel();

      // Send results as actual pixel coordinates
      Map<String, List<dynamic>> results = classifier.parseData();
      isolateData.responsePort.send(results);
    }
  }

  void stop() async {
    // debugPrint('[ISOLATE] stopped');
    _isolate.kill(priority: Isolate.immediate);
  }
}

/// Bundles data to pass between Isolate
class IsolateData {
  CameraImage cameraImage;
  int interpreterAddress;
  late SendPort responsePort;

  IsolateData(this.cameraImage, this.interpreterAddress);
}
