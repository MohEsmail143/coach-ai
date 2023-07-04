import 'dart:ui';

import 'package:flutter/material.dart';

import 'constants.dart';
import 'sample_input_pose.dart';

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
