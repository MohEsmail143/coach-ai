class Exercise {
  final String name;
  final List<String> instructions;
  final String image;
  final String gif;
  final int trackedKeypoint;
  final int trackingDirection;
  final String formCorrectnessModel;

  Exercise({
    required this.name,
    required this.instructions,
    required this.image,
    required this.gif,
    required this.trackedKeypoint,
    required this.trackingDirection,
    required this.formCorrectnessModel,
  });
}

final Exercise pushUps = Exercise(
  name: 'Push Ups',
  instructions: [
    'Start in a plank position with your arms straight and your hands shoulder-width apart.',
    'Lower your body until your chest touches the floor.',
    'Push your body back up to the starting position.',
    'Repeat for the desired number of reps.'
  ],
  image: "assets/images/push_up.png",
  gif: 'assets/images/push_up.gif',
  trackedKeypoint: kKeypointDict['right_shoulder'] as int,
  trackingDirection: 0,
  formCorrectnessModel: 'models/pushUp_version2.tflite',
);

final Exercise pullUps = Exercise(
  name: 'Pull Ups',
  instructions: [
    'Start by grabbing the pull-up bar with your palms facing away from you and your hands shoulder-width apart.',
    'Hang from the bar with your arms extended and your feet off the ground.',
    'Pull your body up towards the bar until your chin is above the bar.',
    'Lower your body back down to the starting position.',
    'Repeat for the desired number of reps.'
  ],
  image: "assets/images/pull_up.png",
  gif: 'assets/images/pull_up.gif',
  trackedKeypoint: kKeypointDict['nose'] as int,
  trackingDirection: 1,
  formCorrectnessModel: 'models/pullUp.tflite',
);

final Exercise squats = Exercise(
  name: 'Squats',
  instructions: [
    'Stand with your feet shoulder-width apart and your toes pointing slightly outward.',
    'Lower your body by bending your knees and pushing your hips back as if you are sitting on a chair.',
    'Keep your chest up and your back straight as you descend until your thighs are parallel to the ground.',
    'Push through your heels to return to the starting position.',
    'Repeat for the desired number of reps.'
  ],
  image: "assets/images/squat.jpg",
  gif: 'assets/images/squat.gif',
  trackedKeypoint: kKeypointDict['nose'] as int,
  trackingDirection: 1,
  formCorrectnessModel: 'models/squat.tflite',
);

/// MoveNet Keypoints constants
const Map<String, int> kKeypointDict = {
  'nose': 0,
  'left_eye': 1,
  'right_eye': 2,
  'left_ear': 3,
  'right_ear': 4,
  'left_shoulder': 5,
  'right_shoulder': 6,
  'left_elbow': 7,
  'right_elbow': 8,
  'left_wrist': 9,
  'right_wrist': 10,
  'left_hip': 11,
  'right_hip': 12,
  'left_knee': 13,
  'right_knee': 14,
  'left_ankle': 15,
  'right_ankle': 16,
};
