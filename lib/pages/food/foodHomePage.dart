import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:help_me/api/foodFetch.dart';
import 'package:help_me/model/food.dart';
import 'package:help_me/pages/food/foodDisplayWidget.dart';
import 'package:help_me/pages/food/foodPreferences.dart';
import 'package:help_me/pages/food/nutrientDisplayGrid.dart';
import 'package:help_me/pages/food/searchBarResults.dart';

final foodServiceProvider = Provider<FoodFetchService>((ref) {
  return FoodFetchService();
});

final foodProvider = FutureProvider<List<Food>>((ref) async {
  final foodService = ref.read(foodServiceProvider);
  return foodService.fetchRandomFood(); // Corrected method call
});

final foodProviderTwo = FutureProvider<List<Food>>((ref) async {
  final foodService = ref.read(foodServiceProvider);
  return foodService.fetchRandomFood(); // Corrected method call
});

// final favourites = FutureProvider<List<Food>>((ref) async {
//   final foodService = ref.read(foodServiceProvider);
//   return foodServiceProvider
//       .fetchFavourites(); // Assuming fetchFavourites exists
// });
// final microNutrients = FutureProvider<List<Food>>((ref) async {
//   final foodService = ref.read(foodServiceProvider);
//   return foodServiceProvider
//       .fetchMicroNutrients(); // Assuming fetchMicroNutrients exists
// });

class FoodHomePage extends ConsumerWidget {
  final List<String> macroNutrients = [
    'public/assets/images/protein.jpg',
    'public/assets/images/carbs.jpg',
    'public/assets/images/fiber.jpg',
    'public/assets/images/fat.jpg',
  ];

  final List<String> microNutrients = [
    'public/assets/images/calcium.jpg',
    'public/assets/images/magnesium.jpg',
    'public/assets/images/iron.jpg',
    'public/assets/images/vitamins.jpg',
    'public/assets/images/zinc.jpg',
  ];

  final List<String> macroNutrientNames = [
    'Protein',
    'Carbs',
    'Fiber',
    'Fat',
  ];

  final List<String> microNutrientNames = [
    'Calcium',
    'Magnesium',
    'Iron',
    'Vitamins',
    'Zinc'
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final double width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.red,
        title: Text(
          'Meal plan',
          style: GoogleFonts.montserrat(
              textStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold)),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: redTextField(width, context)),
            sectionBuilder(context, ref, "DISCOVER", foodProvider),
            sectionBuilder(context, ref, "FAVOURITES", foodProviderTwo),
            smallerSectionBuilder(context, ref, "MACRO-NUTRIENTS", foodProvider,
                4, macroNutrients, macroNutrientNames),
            smallerSectionBuilder(context, ref, "MICRO-NUTRIENTS", foodProvider,
                5, microNutrients, microNutrientNames),
            SizedBox(
              height: 30,
            ),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.6,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    border: Border.all(color: Colors.black, width: 1.5)),
                child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.red)),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => foodPreferences()));
                    },
                    child: Text('MORE FILTERS',
                        style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20)))),
              ),
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }

  Widget sectionBuilder(BuildContext context, WidgetRef ref, String title,
      FutureProvider<List<Food>> provider) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 12, 12, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 16, 16, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
          SizedBox(height: 14),
          Container(
            height: 245,
            child: ref.watch(provider).when(
                  data: (foods) => ListView.builder(
                      itemCount: foods.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final food = foods[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FoodDisplayWidget(
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
                                  border:
                                      Border.all(width: 1, color: Colors.black),
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
                                              food.healthScore.toString(),

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
                                          child: Text('Source : ',
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
                                              food.sourceName
                                                      .toString()
                                                      .endsWith('.com')
                                                  ? food.sourceName
                                                      .toString()
                                                      .substring(
                                                          0,
                                                          food.sourceName
                                                                  .toString()
                                                                  .length -
                                                              4)
                                                      .trim()
                                                  : food.sourceName
                                                      .toString()
                                                      .split(' ')
                                                      .take(2)
                                                      .join(' '),

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
                                                color: int.parse(food
                                                            .healthScore
                                                            .toString()) <
                                                        20
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
                                                    int.parse(food.healthScore
                                                                .toString()) <
                                                            20
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
                                          child: Image.asset(macroNutrients[
                                              Random().nextInt(3)]),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                  loading: () => Center(child: CircularProgressIndicator()),
                  error: (e, st) => Text('Error: $e'),
                ),
          ),
        ],
      ),
    );
  }

  Widget smallerSectionBuilder(
      BuildContext context,
      WidgetRef ref,
      String title,
      FutureProvider<List<Food>> provider,
      int itemCount,
      List<String> nutrients,
      List<String> nutrientsNames) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12.0, 12, 12, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 16, 16, 0),
            child: Text(
              title,
              style: GoogleFonts.montserrat(
                  textStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold)),
            ),
          ),
          SizedBox(height: 14),
          Container(
            height: 110,
            child: ref.watch(provider).when(
                  data: (foods) => ListView.builder(
                    itemCount: itemCount,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => NutrientGrid(
                                nameOfNutrient:
                                    nutrientsNames[index].toString())));
                      },
                      child: Card(
                        elevation: 4,
                        child: Container(
                            width: 110,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(width: 1, color: Colors.black),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 70,
                                    height: 70,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.asset(nutrients[index]),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      nutrientsNames[index],
                                      style: GoogleFonts.montserrat(
                                          textStyle: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  )
                                ])),
                      ),
                    ),
                  ),
                  loading: () => Center(child: CircularProgressIndicator()),
                  error: (e, st) => Text('Error: $e'),
                ),
          ),
        ],
      ),
    );
  }

  Widget redTextField(double width, BuildContext context) {
    String search = '';
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 40, 16, 0),
      child: Container(
        width: width * 0.8,
        height: 50,
        child: TextField(
          onChanged: (value) {
            search = value;
          },
          decoration: InputDecoration(
            suffixIcon: Padding(
              padding: const EdgeInsets.all(1.0),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    color: Colors.red,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10))),
                width: 50,
                height: double.infinity,
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => searchBarFood(
                              searchPrompt: search,
                            )));
                  },
                  icon: Icon(Icons.search),
                  color: Colors.black,
                ),
              ),
            ),
            labelText: 'Dish name',
            labelStyle: GoogleFonts.montserrat(
                textStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 2),
              borderRadius: BorderRadius.circular(14),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 2.0),
              borderRadius: BorderRadius.circular(14),
            ),
          ),
          style: TextStyle(color: Colors.red),
          cursorColor: Colors.red,
        ),
      ),
    );
  }
}
