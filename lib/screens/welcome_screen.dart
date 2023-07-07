import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'home_view_screen.dart';

class WelcomeScreen extends StatelessWidget {
  final List levels = [
    "inactive",
    "Beginner",
  ];

  WelcomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/image2.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 70.0),
                  child: Text(
                    "COACH",
                    style: GoogleFonts.bebasNeue(
                      fontSize: 56,
                      color: Colors.white,
                      letterSpacing: 1.8,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 70.0),
                  child: Text(
                    ".AI ",
                    style: GoogleFonts.bebasNeue(
                      fontSize: 56,
                      color: const Color(0xFF68B984),
                      letterSpacing: 1.8,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 40.0,
                right: 25,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Exercise, ",
                        style: GoogleFonts.lato(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Made Fun",
                        style: GoogleFonts.lato(
                          fontSize: 24,
                          color: const Color(0xFF68B984),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  /*
                  Text(
                    "Exercise, Made Fun",
                    style: GoogleFonts.lato(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),*/
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "We will help you reach your potential.\nFollow the next steps, to complete your information",
                    style: GoogleFonts.lato(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                  /*
                  Padding(
                    padding: const EdgeInsets.only(top: 40.0),
                    child: GestureDetector(
                      child: SizedBox(
                        height: 150,
                        width: 220,
                        // width: MediaQuery.of(context).size.width,
                        //child: ListView.builder(
                        // scrollDirection: Axis.horizontal,
                        //itemCount: levels.length,
                        // itemBuilder: (BuildContext context, index) {
                        //Padding(
                        // padding: const EdgeInsets.only(right: 10),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const BMI()));
                          },
                          child: Container(
                            height: 226,
                            width: 10,
                            decoration: BoxDecoration(
                              color: const Color(0xFF68B984),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.only(left: 20.0, top: 30.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  // Text(
                                  //   "Use our BMI \n   calculor ",
                                  //   style: GoogleFonts.lato(
                                  //     fontSize: 28,
                                  //     color: Color(0xFF251749),
                                  //     fontWeight: FontWeight.bold,
                                  //   ),
                                  // ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  /* Text(
                                          levels[index],
                                          style: GoogleFonts.lato(
                                            fontSize: 30,
                                            color: Color(0xFF251749),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),*/
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        //   );
                        // },
                      ),
                    ),
                  ),
                  */
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 40.0, top: 40, bottom: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Skip Intro",
                          style: GoogleFonts.lato(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.white30,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const HomeViewScreen()));
                          },
                          child: Container(
                            width: 139,
                            height: 39,
                            decoration: BoxDecoration(
                              color: const Color(0xFF68B984).withOpacity(0.7),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Center(
                              child: Text(
                                "Next",
                                style: GoogleFonts.lato(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
