import 'package:flutter/material.dart';

class NutritionScreen extends StatelessWidget {
  NutritionScreen({super.key});

  final List<Tab> tabs = const [
    Tab(
      child: Text("SATURDAY"),
    ),
    Tab(
      child: Text("SUNDAY"),
    ),
    Tab(
      child: Text("MONDAY"),
    ),
    Tab(
      child: Text("TUESDAY"),
    ),
    Tab(
      child: Text("WEDNESDAY"),
    ),
    Tab(
      child: Text("THURSDAY"),
    ),
    Tab(
      child: Text("FRIDAY"),
    ),
  ];

  final List<Widget> tabsContent = [
    //SATURDAYYYYYYYYYYYYYYYYYYYY
    Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/nutrition2.jpg"),
          fit: BoxFit.fill,
        ),
      ),
      child: const SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Breakfast (369 calories)",
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Text(
              '''
          ·1 cup all-bran cereal
          ·3/4 cup skim milk
          ·1/2 cup blueberries
          ·2 Tbsp.unsalted dry-roasted almonds
           ''',
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
            Text(
              "Morning Snack (176 calories)",
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Text(
              '''
          ·4 Tbsp Avocado-Yogurt Dip
          ·3 medium carrots
           ''',
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
            Text(
              "Lunch (440 calories)",
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Text(
              '''
                  Leftover Chicken Tikka Masala
                  ·1 1/2 cups Quick Chicken Tikka Masala
                  ·2 cups spinach
                  ·1/2 cup brown rice
                  Reheat the chicken on top of spinach 
                  in the microwave.
          ''',
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
            Text(
              "Afternoon Snack(210 calories)",
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Text(
              '''
         ·1medium banana
         ·8 walnut halves
           ''',
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
            Text(
              "Dinner (604 calories)",
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Text(
              '''
                         ·2 cups Korean Beef Stir-Fry
                         ·1 cup cooked buckwheat soba noodles
                             (about2 ounces dry noodles)
               Plan: Cook a chicken breast for tomorrow's lunch
                or substitute precooked chicken or sliced chicken 
                or turkey breast from the grocery store. 
                When choosing deli items, go for low-sodium, 
                preservative-free options.
           ''',
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
          ],
        ),
      ),
    ),

    //SUNDAYYYYYYYYYYYYYYYYYYYYYY
    Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/nutrition2.jpg"),
          fit: BoxFit.fill,
        ),
      ),
      child: const SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Breakfast (362 calories)",
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Text(
              '''
          ·1 cup all-bran cereal
          ·3/4 cup skim milk
          ·1/2 cup blueberries
          ·2 Tbsp.chopped walnuts
          ''',
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
            Text(
              "Morning Snack (291 calories)",
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Text(
              '''
          ·4 Tbsp.Avocado-Yogurt Dip
          ·3 medium carrots
          ''',
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
            Text(
              "Lunch (434 calories)",
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Text(
              '''
          ·2 cups mixed greens
          ·4 oz. cooked chicken breast
          ·1/2 medium red bell pepper, sliced
          ·1/4 cup grated carrots
          ·1 Tbsp. unsalted dry-roasted almonds
          ·2 Tbsp. Carrot-Ginger Vinaigrette
          ·1 clementine, peeled and sectioned
          Combine ingredients and top the salad 
          with the vinaigrette.
          ''',
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
            Text(
              "Afternoon Snack (142 calories)",
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Text(
              '''
          ·1 hard-boiled egg
          ·2 diagonal slices baguette (1/4 inch thick),
          preferably whole-wheat
          ·1 tsp.hot sauce (if desired)
          Toast baguette slices and top
           with sliced egg and hot sauce.
          ''',
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
            Text(
              "Dinner (494 calories)",
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Text(
              '''
          ·1 serving Wild Mushroom Pizza with Arugula
          and Pecorino
          ''',
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
            Text(
              "Evening Snack (76 calories)",
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Text(
              '''
         ·1 1/2 Tbsp. chocolate chips, 
         preferably dark chocolate
          ''',
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
          ],
        ),
      ),
    ),

    //MONDAYYYYYYYYYYYYYYYYYYYYYYYY
    Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/nutrition2.jpg"),
          fit: BoxFit.fill,
        ),
      ),
      child: const SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Breakfast(382 calories)",
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Text(
              '''
          Avocado-Egg Toast
          ·1 slice whole-grain bread
          ·1/2 medium avocado
          ·1 large egg, cooked in 1/4 tsp. olive oil or 
          coat pan with a thin layer of cooking spray
          (1-secondspray)
          Season egg with a pinch of salt and pepper.
          ·2 clementines
           ''',
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
            Text(
              "Morning Snack (305 calories)",
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Text(
              '''
          ·1 medium apple
          .2 Tbsp.peanut butter
           ''',
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
            Text(
              "Lunch(407 calories)",
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Text(
              '''
          ·2 cups Ravioli and Vegetable Soup
          ·2 diagonal slices baguette (1/4 inch thick), 
          preferably whole-wheat
          ·3 Tbsp. shredded Cheddar cheese
          Top baguette slices with 1 1/2 Tbsp. 
          cheese each and a pinch of pepper.
           Toast until cheese is melted.
           ''',
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
            Text(
              "Afternoon Snack(169 calories)",
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Text(
              '''
          ·4 Tbsp.hummus
          ·1 cup sliced cucumber
          ·2 medium carrots
           ''',
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
            Text(
              "Dinner (560 calories)",
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Text(
              '''
          Salmon and Vegetables
          ·4 oz.baked salmon
          ·1 cup roasted Brussels sprouts
          ·1 cup brown rice
          ·1/8 tsp.salt
          ·1/8 tsp.pepper
          ·1 Tbsp.walnuts
          Vinaigrette
           ''',
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
          ],
        ),
      ),
    ),

    //TUESDAYYYYYYYYYYYYYYYYYYYY
    Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/nutrition2.jpg"),
          fit: BoxFit.fill,
        ),
      ),
      child: const SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Breakfast (382 calories)",
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Text(
              '''
          Avocado-Egg Toast
      ·1 slice whole-grain bread
      ·1/2 medium avocado
      ·1 large egg, cooked in 1/4 tsp. 
      olive oil or coat pan with a thin layer 
      of cooking spray (1-secondspray)
      Season egg with a pinch of salt and pepper.
      ·2 clementines
           ''',
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
            Text(
              "Morning Snack (172 calories)",
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Text(
              '''·8 dried apricots
      ·8 walnut halves
           ''',
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
            Text(
              "Lunch(441 calories)",
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Text(
              '''
          Leftover soup
      ·2 cups Ravioli and Vegetable Soup
      ·2 diagonal slices baguette (1/4 inch thick),
      preferably whole-wheat
      ·3 Tbsp. shredded Cheddar cheeseTop each 
      baguette slice with 1 1/2 Tbsp.
      cheese and a pinch of pepper. Toast until
      cheese is melted.
      ·1 clementine
           ''',
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
            Text(
              "Afternoon Snack(154 calories)",
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Text(
              '''·4 Tbsp.hummus
      ·2 medium carrots
           ''',
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
            Text(
              "Dinner (533 calories)",
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Text(
              '''·11/2 cups Delicata Squash and Tofu Curry
      ·Serve curry over 1 cup brown rice.
           ''',
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
            Text(
              "Evening Snack (133 calories)",
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Text(
              '''·2 Medjool dates
           ''',
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
          ],
        ),
      ),
    ),

    //WEDNESDAYYYYYYYYYYYYYYYYYYY
    Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/nutrition2.jpg"),
          fit: BoxFit.fill,
        ),
      ),
      child: const SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Breakfast (405 calories)",
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Text(
              '''
      • 1/2 cup Maple-Nut Granola
      • 1 cup nonfat plain Greek yogurt
      • 1/4 cup blueberries
           ''',
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
            Text(
              "Morning Snack (128 calories)",
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Text(
              '''
      • 3 Tbsp, hummus
      • 2 medium carrots
           ''',
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
            Text(
              "Lunch (443 calories)",
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Text(
              '''
      Apple and Cheddar Pita Pocket
      • 1 whole-wheat pita round (6-1/2-inch)
      • 1 Tbsp, mustard
      • 1/2 medium apple, sliced
      •1 1/2 oz. Cheddar cheese
      • 1 cup mixed greens
           ''',
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
            Text(
              "Afternoon Snack (278 calories)",
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Text(
              '''
      • 1/2 medium apple, sliced
      • 1 Tbsp, peanut butter
      • 1/4 cup Maple-Nut Granola
      Dip apple slices into peanut butter and granola. 
           ''',
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
            Text(
              "Dinner (507 calories)",
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Text(
              '''
      • 1 Moroccan-Style Stuffed Pepper
      • 2 cups spinach
      Saute spinach in 1 tsp. olive oil with
       a pinch of salt and pepper.
      • 1 cup sliced carrots, steamed
           ''',
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
            Text(
              "Evening Snack (50 calories)",
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Text(
              '''
      • 1 Tbsp, chocolate chips, preferably dark chocolate
           ''',
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
          ],
        ),
      ),
    ),

    //THURSDAYYYYYYYYYYYYYYYYYYY
    Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/nutrition2.jpg"),
          fit: BoxFit.fill,
        ),
      ),
      child: const SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Breakfast (369 calories)",
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Text(
              '''• 1 cup all-bran cereal
      • 3/4 cup skim milk
      • 1/2 cup blueberries
      • 2 Tbsp, unsalted dry-roasted almonds
           ''',
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
            Text(
              " Morning Snack (117 calories)",
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Text(
              '''• 1 cup sliced cucumber
      • 4 Tbsp. Avocado-Yogurt Dip 
           ''',
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
            Text(
              "Lunch (449 calories)",
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Text(
              '''• 2 Tomato-Cheddar Cheese Toasts
      • 2 cups mixed greens
      • 1/4 cup grated carrot
      • 1/2 cup cucumber, sliced
      • 1 hard-boiled egg
      • 2 Tbsp, unsalted dry-roasted almonds 
      •11/2 tsp. each olive oil and balsamic vinegar 
      Top greens with carrot, cucumber, hard-boiled 
      egg, and almonds. Toss with balsamic vinaigrette.
           ''',
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
            Text(
              " Afternoon Snack (210 calories)",
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Text(
              '''• 1 medium banana
      • 8 walnut halves
           ''',
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
            Text(
              " Dinner (535 calories)",
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Text(
              '''•11/2 cups Quick Chicken Tikka Masala
      • 1 cup brown rice Evening Snack (133 calories)
      • 2 Medjool dates
           ''',
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
          ],
        ),
      ),
    ),

    //FRIDAYYYYYYYYYYYYYYYY
    Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/nutrition2.jpg"),
          fit: BoxFit.fill,
        ),
      ),
      child: const SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Breakfast (405 calories)",
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Text(
              '''• 1/2 cup Maple-Nut Granola
      • 1 cup nonfat plain Greek yogurt
      • 1/4 cup blueberries 
           ''',
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
            Text(
              "Morning Snack (305 calories)",
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Text(
              '''• 1 medium apple
      • 2 Tbsp, peanut butter 
           ''',
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
            Text(
              "Lunch (417 calories)",
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Text(
              '''• 2 cups mixed greens
      • 4 oz. cooked chicken breast
      • 1/2 medium red bell pepper, sliced
      • 1/4 cup grated carrots
      • 1 clementine, peeled and sectioned
      • 2 Tbsp. Carrot-Ginger Vinaigrette
      Combine ingredients and top 
      the salad with the vinaigrette.
           ''',
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
            Text(
              "Afternoon Snack (172 calories)",
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Text(
              '''• 8 dried apricots
      • 8 walnut halves 
           ''',
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
            Text(
              "Dinner (508 calories)",
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Text(
              '''• 2 1/4 cups Warm Lentil Salad
             with Sausage and Apple
      • 1/2 cup Quick Pickled Beets
      • 1 diagonal slice baguette 
      (1/4 inch thick), preferably whole-wheat
      • Top baguette with 1 tsp. butter
      Plan: Make Avocado-Yogurt Dip 
      for tomorrow. You can substitute 
      store-bought hummus for the dip, if desired.
           ''',
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
          ],
        ),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Diet Plan'),
          backgroundColor: Colors.black54,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(40),
            child: TabBar(
              indicatorColor: Colors.green,
              isScrollable: true,
              tabs: tabs,
            ),
          ),
        ),
        body: TabBarView(
          children: tabsContent,
        ),
      ),
    );
  }
}
