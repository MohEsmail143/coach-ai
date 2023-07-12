import 'package:coach_ai/screens/exercise_selection_screen.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'nutrition_screen.dart';
import 'profile_screen.dart';
import 'bmi/calculate_bmi.dart';
import '../utils/exercise.dart';

class HomeViewScreen extends StatefulWidget {
  const HomeViewScreen({super.key});

  @override
  State<HomeViewScreen> createState() => _HomeViewScreenState();
}

class _HomeViewScreenState extends State<HomeViewScreen> {
  int _currentIndex = 0;
  late PageController _pageController;
  late List<Widget> _screens;

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void initState() {
    _screens = [
      const HomeViewBody(),
      const BMI(),
      NutritionScreen(),
    ];
    _pageController = PageController(initialPage: _currentIndex);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: const Color(0xFF40D876),
          buttonBackgroundColor: const Color(0xFF40D876),
          color: const Color(0xFF212121),
          onTap: _onItemTapped,
          items: const [
            Icon(
              Icons.home,
              color: Color(0xFFFAFAFA),
            ),
            Icon(
              Icons.calculate,
              color: Color(0xFFFAFAFA),
            ),
            Icon(
              Icons.local_dining,
              color: Color(0xFFFAFAFA),
            ),
          ]),
      body: PageView(
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: _screens,
      ),
    );
  }
}

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.black,
        image: DecorationImage(
          opacity: 0.5,
          image: AssetImage(
            "assets/images/image3.jpg",
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 30.0, left: 10, right: 10),
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
                        "Welcome to ",
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
                            builder: (context) => const ProfileScreen(
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
              padding: const EdgeInsets.only(top: 20.0),
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
            /*
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
            ),*/
            /*
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
            */
            /*
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
                              builder: (context) => NutritionScreen()));
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
            */
            Text(
              "Popular Workouts",
              style: GoogleFonts.lato(
                fontSize: 30,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            ListView.builder(
                shrinkWrap: true,
                itemCount: availableExercises.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (BuildContext context, index) {
                  return InkWell(
                    onTap: () {},
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ExerciseSelectionScreen(
                              exercise: availableExercises[index],
                            ),
                          ),
                        );
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        color: Colors.black54,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 12, right: 8, top: 8, bottom: 8),
                          child: CustomListTile(
                            exercise: availableExercises[index],
                          ),
                        ),
                      ),
                    ),
                  );
                  /*
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
                  */
                })
          ],
        ),
      ),
    );
  }
}

class CustomListTile extends StatelessWidget {
  final Exercise exercise;

  const CustomListTile({
    required this.exercise,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      // padding: const EdgeInsets.all(4),
      child: Row(children: [
        Expanded(
          flex: 9,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(exercise.image),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        const Spacer(
          flex: 1,
        ),
        Expanded(
          flex: 14,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text(
                exercise.name,
                style: const TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: exercise.targetedMuscles.length,
                itemBuilder: (BuildContext context, int i) {
                  return Text(
                    "- ${exercise.targetedMuscles[i]}",
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ]),
    );
  }
}


// ListTile(
//   // contentPadding: EdgeInsets.zero,
//   leading: Container(
//     height: 172,
//     width: 141,
//     decoration: BoxDecoration(
//       image: DecorationImage(
//         image: AssetImage(catego[index].imageUrl),
//         fit: BoxFit.cover,
//       ),
//     ),
//   ),
//   title: Text(
//     catego[index].name,
//     style: const TextStyle(
//       fontWeight: FontWeight.bold,
//       fontSize: 24,
//       color: Colors.white,
//     ),
//   ),
//   subtitle: ListView.builder(
//     shrinkWrap: true,
//     physics: const NeverScrollableScrollPhysics(),
//     itemCount:
//         catego[index].exercise.targetedMuscles.length,
//     itemBuilder: (BuildContext context, int i) {
//       return Text(
//         "- ${catego[index].exercise.targetedMuscles[i]}",
//         style: const TextStyle(
//           fontSize: 16,
//           color: Colors.white70,
//         ),
//       );
//     },
//   ),
// )