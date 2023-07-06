import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileScreen extends StatefulWidget {
  final String userId;

  const ProfileScreen({Key? key, required this.userId}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
    _userStream = FirebaseFirestore.instance
        .collection('users')
        .doc(widget.userId)
        .snapshots();
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            height: 200,
            decoration: const BoxDecoration(
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
          const SizedBox(height: 16),
          Text(
            _name,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _email,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Bio: $_bio',
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
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
          const SizedBox(height: 16),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: const Icon(Icons.person),
                    title: const Text('Personal Information'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      // TODO: Navigate to personal information page
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.settings),
                    title: const Text('Settings'),
                    trailing: const Icon(Icons.arrow_forward_ios),
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
        backgroundColor: Colors.blue,
        child: Text(
          sport.substring(0, 2),
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
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
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
              ),
            ),
            const SizedBox(width: 8),
            Text('$percentage%'),
          ],
        ),
      ),
    );
  }
}
