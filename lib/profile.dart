import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
class ProfilePage extends StatefulWidget {
  final String userId;

  const ProfilePage({Key? key, required this.userId}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Stream<DocumentSnapshot> _userStream;
  String _name = '';
  String _email = '';
  String _bio = '';
  String _profilePhotoUrl = '';
  List<Map<String, dynamic>> _progressData = [];

  @override
  void initState() {
    super.initState();

    // Fetch user data from Firebase
    _userStream =
        FirebaseFirestore.instance.collection('users').doc(widget.userId).snapshots();
    _userStream.listen((snapshot) {
      setState(() {
        _name = snapshot.get('name');
        _email = snapshot.get('email');
        _bio = snapshot.get('bio');
        _profilePhotoUrl = snapshot.get('profile_photo_url');
      });
    });

    // Fetch progress data from Firebase
    FirebaseFirestore.instance
        .collection('users')
        .doc(widget.userId)
        .collection('progress')
        .snapshots()
        .listen((snapshot) {
      setState(() {
        _progressData = snapshot.docs.map((doc) => doc.data()).toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            height: 200,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/profile_background.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(_profilePhotoUrl),
              ),
            ),
          ),
          SizedBox(height: 16),
          Text(
            _name,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            _email,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 16),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Bio: $_bio',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Progress',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _progressData.length,
              itemBuilder: (context, index) {
                final progressData = _progressData[index];
                return _buildSportProgress(
                  progressData['sport'],
                  progressData['distance'],
                  progressData['percentage'],
                );
              },
            ),
          ),
          SizedBox(height: 16),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.person),
                    title: Text('Personal Information'),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      // TODO: Navigate to personal information page
                    },
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.settings),
                    title: Text('Settings'),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      // TODO: Navigate to settings page
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSportProgress(String sport, String distance, int percentage) {
    return ListTile(
      leading: CircleAvatar(
        child: Text(
          sport.substring(0, 2),
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      title: Text(sport),
      subtitle: Text(distance),
      trailing: SizedBox(
        width: 100,
        child: Row(
          children: <Widget>[
            Expanded(
              child: LinearProgressIndicator(
                value: percentage / 100,
                backgroundColor: Colors.grey[200],
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              ),
            ),
            SizedBox(width: 8),
            Text('$percentage%'),
          ],
        ),
      ),
    );
  }
}