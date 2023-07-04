import 'package:flutter/material.dart';

class PushUpInstructionsPage extends StatelessWidget {
  final List<String> _instructions = [
    'Start in a plank position with your arms straight and your hands shoulder-width apart.',
    'Lower your body until your chest touches the floor.',
    'Push your body back up to the starting position.',
    'Repeat for the desired number of reps.'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Push-Up Instructions'),
        backgroundColor: Colors.black,
      ),
      body: Container(
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              flex: 3,
              child: Image.asset(
                'assets/images/push_up.gif',
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20.0),
                  ),
                ),
                child: ListView.builder(
                  itemCount: _instructions.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Step ${index + 1}',
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            _instructions[index],
                            style: TextStyle(
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
                    onPressed: () {},
                    child: Text('Warm Up'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.grey[900],
                      onPrimary: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      minimumSize: Size(150.0, 60.0),
                      textStyle: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      //CameraScreen;
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => CameraScreen()),
                      // );
                    },
                    child: Text('Start'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                      onPrimary: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      minimumSize: Size(150.0, 60.0),
                      textStyle: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
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
