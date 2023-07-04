import 'package:flutter/material.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';

class FormClassifier {
  late Interpreter _interpreter;
  String confidenceModel;

  late List<Object> inputs;
  Map<int, Object> outputs = {};

  TensorBuffer outputConfidence = TensorBufferFloat([]);

  FormClassifier({required this.confidenceModel}) {
    loadModel();
  }

  loadModel() async {
    try {
      _interpreter = await Interpreter.fromAsset(
        confidenceModel,
        options: InterpreterOptions()..threads = 4,
      );
      print("$confidenceModel successfully loaded.");
    } catch (e) {
      debugPrint("Error while creating interpreter: $e");
    }
    outputConfidence = TensorBufferFloat([1, 1]);
  }

  runModel(List<dynamic> inferenceResultsNormalised) async {
    inputs = [inferenceResultsNormalised];
    Map<int, Object> outputs = {0: outputConfidence.buffer};
    interpreter.runForMultipleInputs(inputs, outputs);
    // print(outputConfidence);
  }

  Interpreter get interpreter => _interpreter;
}
