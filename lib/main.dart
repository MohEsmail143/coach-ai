import 'package:firebase_auth/firebase_auth.dart';
// import 'package:coach_ai/screens/welcome_screen.dart';
// import 'firebase_options.dart';

// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:coach_ai/screens/IntroPage.dart';

import 'package:coach_ai/screens/home_screen.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Coach.ai',
      theme: ThemeData(
        // brightness: Brightness.dark,
        textTheme: GoogleFonts.urbanistTextTheme(),
        primarySwatch: Colors.blue,
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const HomeScreen();
          } else {
            //return WelcomeScreen();
             return IntroPage();
          }
        },
      ),
    );
  }
}
