// Define providers
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:help_me/api/foodFetch.dart';
import 'package:help_me/model/food.dart';
import 'package:help_me/pages/food/foodDisplayWidget.dart';
import 'package:help_me/pages/food/foodDisplayWidgetTwo.dart';

final nutrientProvider = Provider<FoodFetchService>((ref) {
  return FoodFetchService();
});

final nutrientProviderList =
    FutureProvider.family<List<Food>, String>((ref, nutrientName) async {
  final foodService = ref.read(nutrientProvider);
  return foodService.fetchFoodByVitamins(nutrientName);
});

// NutrientGrid widget
class NutrientGrid extends ConsumerWidget {
  final Map<String, String> nutrientParagraphs = {
    'Protein':
        "Protein is your body's building blocks, essential for muscles, skin, and even hair. Dive into a protein-packed meal today and feel the power!",
    'Carbs':
        "Carbs are your body's fuel for fun! From whole grains to tasty fruits, carbs keep you energized. Choose your favorite carb-rich treat and get ready to conquer the day!",
    'Fiber':
        "Fiber is your body's broomstick, keeping things moving smoothly in your gut. Load up on fiber-filled veggies and grains for a happy tummy!",
    'Fat':
        "Fat may sound scary, but the good kind keeps your brain sharp and your body strong. Grab some nuts or avocado and fuel up for adventure!",
    'Calcium':
        "Calcium is the hero of healthy bones and teeth! Sip on some milk or snack on cheese for a calcium boost that'll keep you smiling!",
    'Magnesium':
        "Magnesium is like a magical mineral, helping your muscles relax and your heart beat strong. Add some nuts or leafy greens to your plate and feel the zen!",
    'Iron':
        "Iron is your body's oxygen carrier, fueling your energy levels and keeping you feeling alive! Treat yourself to some lean meat or beans and power through your day!",
    'Vitamins':
        "Vitamins are the superheroes of your immune system, keeping you healthy and happy. Grab a rainbow of fruits and veggies and let the vitamins do their magic!",
    'Zinc':
        "Zinc is your immune system's best friend, fighting off germs and keeping you feeling fabulous. Load up on seafood or nuts and let your inner superhero shine!"
  };

  int parseStringToInt(String input) {
    // Remove non-numeric characters using a regular expression
    String cleanedString = input.replaceAll(RegExp(r'[^0-9]'), '');

    // Check if the cleaned string is empty
    if (cleanedString.isEmpty) {
      throw FormatException('No numeric value found in the string');
    }

    // Parse the cleaned string to an integer
    return int.parse(cleanedString);
  }

  final String nameOfNutrient;

  NutrientGrid({Key? key, required this.nameOfNutrient}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;

    AsyncValue<List<Food>> foodListAsyncValue =
        ref.watch(nutrientProviderList(nameOfNutrient));

    return Scaffold(
      body: foodListAsyncValue.when(
        loading: () => Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('Error: $error')),
        data: (foods) {
          return Container(
            width: width,
            height: height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 50,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(30, 20, 16, 0),
                      child: Text(nameOfNutrient,
                          style: GoogleFonts.montserrat(
                              textStyle: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30))),
                    ),
                    Container(
                      width: 50,
                      height: 50,
                      child: Image.asset(
                        'public/assets/images/${nameOfNutrient.toLowerCase()}.jpg',
                      ),
                    )
                  ],
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(30, 10, 16, 0),
                    child: Text(nutrientParagraphs[nameOfNutrient].toString(),
                        style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.w600))),
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
                Expanded(
                  child: Container(
                    width: width,
                    child: GridView.builder(
                      itemCount: foods.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 0,
                        mainAxisSpacing: 16,
                        childAspectRatio:
                            3 / 4.1, // Aspect ratio of each grid cell
                      ),
                      itemBuilder: (context, index) {
                        final food = foods[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FoodDisplayWidgetTwo(
                                        key: UniqueKey(),
                                        food: food,
                                      )),
                            ),
                            child: Card(
                              elevation: 4,
                              child: Container(
                                width: 145,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      width: 0.7, color: Colors.black),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20)),
                                      child: food.image != null
                                          ? Image.network(
                                              food.image!,
                                              fit: BoxFit.cover,
                                            )
                                          : Placeholder(), // Placeholder widget when food.image is null
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          8.0, 8, 8, 2),
                                      child: Text(
                                          food.title.split(" ").length > 4
                                              ?
                                              // overflow: TextOverflow.ellipsis,
                                              // Get the first two words of the title
                                              '${food.title.split(" ").take(4).join(" ")}...'
                                              : '${food.title.split(" ").take(4).join(" ")}',
                                          // food.title.toString(),
                                          style: GoogleFonts.montserrat(
                                              textStyle: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight:
                                                      FontWeight.bold))),
                                    ),
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              8.0, 0, 0, 0),
                                          child: Text('Health Rating : ',
                                              // overflow: TextOverflow.ellipsis,
                                              // Get the first two words of the title
                                              // food.title.toString(),
                                              style: GoogleFonts.montserrat(
                                                  textStyle: TextStyle(
                                                      fontSize: 11,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: Colors.red))),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 0, 0, 0),
                                          child: Text(
                                              // food.healthScore.toString(),
                                              (Random().nextInt(20) + 1)
                                                  .toString(),
                                              // overflow: TextOverflow.ellipsis,
                                              // Get the first two words of the title
                                              // food.title.toString(),
                                              style: GoogleFonts.montserrat(
                                                  textStyle: TextStyle(
                                                      fontSize: 11,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: Colors.red))),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              8.0, 0, 0, 0),
                                          child: Text('Calories : ',
                                              // overflow: TextOverflow.ellipsis,
                                              // Get the first two words of the title
                                              // food.title.toString(),
                                              style: GoogleFonts.montserrat(
                                                  textStyle: TextStyle(
                                                      fontSize: 11,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: Colors.red))),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 0, 0, 0),
                                          child: Text(
                                              food.calories.toString()
                                              //     .endsWith('.com')
                                              // ? food.sourceName
                                              //     .toString()
                                              //     .substring(
                                              //         0,
                                              //         food.sourceName
                                              //                 .toString()
                                              //                 .length -
                                              //             4)
                                              //     .trim()
                                              // : food.sourceName
                                              //     .toString()
                                              //     .split(' ')
                                              //     .take(2)
                                              //     .join(' ')
                                              ,

                                              // overflow: TextOverflow.ellipsis,
                                              // Get the first two words of the title
                                              // food.title.toString(),
                                              style: GoogleFonts.montserrat(
                                                  textStyle: TextStyle(
                                                      fontSize: 11,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: Colors.red))),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              8, 12, 2, 8),
                                          child: Container(
                                            // width: 70,
                                            height: 24,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black),
                                                color: nameOfNutrient == 'Fiber'
                                                    ? Colors.green
                                                    : parseStringToInt(
                                                                food.fat!) >
                                                            30
                                                        ? Colors.red
                                                        : Colors.green,
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 12),
                                              child: Center(
                                                child: Text(
                                                    nameOfNutrient == 'Fiber'
                                                        ? 'Healthy'
                                                        : parseStringToInt(
                                                                    food.fat!) >
                                                                30
                                                            ? 'UNHEALTHY'
                                                            : 'HEALTHY',
                                                    style: GoogleFonts.montserrat(
                                                        textStyle: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 10,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold))),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: 35,
                                          height: 35,
                                          child: Image.asset(
                                            'public/assets/images/${nameOfNutrient.toLowerCase()}.jpg',
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
