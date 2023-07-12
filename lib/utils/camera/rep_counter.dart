import 'dart:math';
import 'coach_tts.dart';

class RepCounter {
  int maxRepCount;

  late int minAltitude;
  late int maxAltitude;
  late double midpoint;
  late double quartile;
  CoachTTS tts = CoachTTS();

  late int currentRepCount = 0;
  bool upPosition = false;

  RepCounter({required this.maxRepCount});

  // RepCounter({required this.maxRepCount});

  /// Running MoveNet to find the max and min altitude
  /// of the workout performed, appearing to the user in the
  /// form of "Warmup Mode"
  void warmup(List<int> warmupInferences) {
    // Extracting min and max altitudes from list of inferences
    warmupInferences = warmupInferences.sublist(30);
    minAltitude = warmupInferences.reduce(min);
    maxAltitude = warmupInferences.reduce(max);

    // Calculating threshold from found values of min and max altitude
    // using the following equations:
    midpoint = ((maxAltitude - minAltitude) / 2) + minAltitude;
    quartile = (maxAltitude - minAltitude) / 4;
  }

  /// Running MoveNet to find the max and min altitude
  /// of the workout performed, appearing to the user in the
  /// form of "Warmup Mode"
  void startCounting(int trackedKeypointLocation, bool fullRepPosition) {
    if (!fullRepPosition) {
      if (trackedKeypointLocation > (midpoint + quartile) &&
          upPosition == false) {
        currentRepCount += 1;
        tts.speak(currentRepCount.toString());
        upPosition = true;
      } else if (trackedKeypointLocation < midpoint) {
        upPosition = false;
      }
    } else {
      if (trackedKeypointLocation < (midpoint - quartile) &&
          upPosition == false) {
        currentRepCount += 1;
        tts.speak(currentRepCount.toString());
        upPosition = true;
      } else if (trackedKeypointLocation > midpoint) {
        upPosition = false;
      }
    }
  }

  void resetRepCount() {
    currentRepCount = 0;
  }
}
