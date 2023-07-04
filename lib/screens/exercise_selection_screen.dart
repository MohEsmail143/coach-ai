import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/exercise.dart';
import '../screens/camera_screen.dart';
import '../utils/workout_session.dart';

class ExerciseSelectionScreen extends StatefulWidget {
  final Exercise exercise;
  const ExerciseSelectionScreen({required this.exercise, super.key});

  @override
  State<ExerciseSelectionScreen> createState() =>
      _ExerciseSelectionScreenState();
}

class _ExerciseSelectionScreenState extends State<ExerciseSelectionScreen> {
  // final List<String> _instructions = [
  //   'Start in a plank position with your arms straight and your hands shoulder-width apart.',
  //   'Lower your body until your chest touches the floor.',
  //   'Push your body back up to the starting position.',
  //   'Repeat for the desired number of reps.'
  // ];

  final TextEditingController setsController = TextEditingController();
  final TextEditingController repsController = TextEditingController();
  final TextEditingController restTimeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.exercise.name} Instructions'),
        backgroundColor: Colors.black,
      ),
      body: Container(
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              flex: 1,
              child: Image.asset(
                widget.exercise.gif,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  ExerciseSelectionTextField(
                    hintText: 'Sets',
                    controller: setsController,
                  ),
                  const SizedBox(height: 16),
                  ExerciseSelectionTextField(
                    hintText: 'Reps',
                    controller: repsController,
                  ),
                  const SizedBox(height: 16),
                  ExerciseSelectionTextField(
                    hintText: 'Rest',
                    controller: restTimeController,
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(20.0),
                  ),
                ),
                child: ListView.builder(
                  itemCount: widget.exercise.instructions.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Step ${index + 1}',
                            style: const TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            widget.exercise.instructions[index],
                            style: const TextStyle(
                              fontSize: 18.0,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            backgroundColor: Colors.grey[900],
                            title: const Text(
                              'Targeted Muscles',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            content: SizedBox(
                              width: double.maxFinite,
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount:
                                    widget.exercise.targetedMuscles.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    title: Text(
                                      "- ${widget.exercise.targetedMuscles[index]}",
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
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.grey[900],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      minimumSize: const Size(150.0, 60.0),
                      textStyle: const TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    child: const Text('Targeted Muscles'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      //CameraScreen;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CameraScreen(
                            exercise: widget.exercise,
                            session: WorkoutSession(
                              reps: int.parse(repsController.text),
                              sets: int.parse(setsController.text),
                              restTime: int.parse(restTimeController.text),
                            ),
                          ),
                        ),
                      );
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
                    child: const Text("Let's Workout!"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ExerciseSelectionTextField extends StatelessWidget {
  const ExerciseSelectionTextField({
    super.key,
    required this.controller,
    required this.hintText,
  });

  final TextEditingController controller;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Colors.white54,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(
              width: 3,
              color: Colors.green,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(
              width: 1,
              color: Colors.grey,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 15.0,
            vertical: 10.0,
          ),
        ),
        style: const TextStyle(
          color: Colors.white, // Set the text color to blue
        ),
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly,
        ]);
  }
}
