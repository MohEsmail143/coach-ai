import 'package:coach_ai/screens/exercise_selection_screen.dart';
import 'package:coach_ai/screens/nutrition.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'mode.dart';
import 'profile.dart';
import 'utils/exercise.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final List<Category> catego = [
    Category(
      imagUrl: pushUps.image,
      name: pushUps.name,
      page: ExerciseSelectionScreen(exercise: pushUps),
    ),
    Category(
      imagUrl: pullUps.image,
      name: pullUps.name,
      page: ExerciseSelectionScreen(exercise: pullUps),
    ),
    Category(
      imagUrl: squats.image,
      name: squats.name,
      page: ExerciseSelectionScreen(exercise: squats),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: const Color(0xFF40D876),
          color: const Color(0xFF212121),
          onTap: (index) {},
          items: const [
            Icon(
              Icons.home,
              color: Color(0xFFFAFAFA),
            ),
            Icon(
              Icons.accessibility,
              color: Color(0xFFFAFAFA),
            ),
            Icon(
              Icons.logout,
              color: Color(0xFFFAFAFA),
            ),
          ]),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/image3.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 30.0, left: 20),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          "COUCOU,",
                          style: GoogleFonts.bebasNeue(
                            fontSize: 22,
                            color: Colors.white,
                            letterSpacing: 1.8,
                          ),
                        ),
                        Text(
                          "Coach.AI",
                          style: GoogleFonts.bebasNeue(
                            fontSize: 32,
                            color: const Color(0xFF68B984),
                            letterSpacing: 1.8,
                          ),
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ProfilePage(
                                  userId: 'your_user_id_here')),
                        );
                      },
                      child: Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40.0),
                          border: Border.all(
                            width: 3,
                            color: const Color(0xFF40D876),
                          ),
                          image: const DecorationImage(
                            image: AssetImage("assets/images/emely.jpg"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(.1),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Center(
                    child: Container(
                      height: 50,
                      width: 70,
                      decoration: BoxDecoration(
                        color: const Color(0xFF40D876),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.play_arrow,
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20.0, top: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Find ",
                          style: GoogleFonts.lato(
                            fontSize: 26,
                            color: const Color(0xFF68B984),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "your Workout",
                          style: GoogleFonts.lato(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const Icon(
                      Icons.sports,
                      size: 40,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Container(
                  width: 353,
                  height: 36,
                  decoration: BoxDecoration(
                    color: const Color(0xFF232441),
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        hintText: "SEARCH WORKOUT",
                        hintStyle: TextStyle(
                          color: Colors.white54,
                        ),
                        border: InputBorder.none,
                        icon: Icon(
                          Icons.search,
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Popular",
                      style: GoogleFonts.lato(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Nutrition()));
                      },
                      child: Text(
                        "Nutrition",
                        style: GoogleFonts.lato(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    /*
                    Text(
                      "Hard workout",
                      style: GoogleFonts.lato(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),*/
                    Text(
                      "Full body",
                      style: GoogleFonts.lato(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Crossfit",
                      style: GoogleFonts.lato(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    Text(
                      "Popular Workouts",
                      style: GoogleFonts.lato(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                // child: Container(
                child: SizedBox(
                  width: double.infinity,
                  height: 200,
                  child: ListView.builder(
                      itemCount: catego.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              catego[index].page));
                                },
                                child: Container(
                                  height: 172,
                                  width: 141,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(catego[index].imagUrl),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                catego[index].name,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
