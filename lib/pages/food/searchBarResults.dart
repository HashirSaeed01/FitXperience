import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:help_me/api/foodFetch.dart';
import 'package:help_me/model/food.dart';
import 'package:help_me/pages/food/foodDisplayWidget.dart';
import 'package:help_me/pages/food/foodDisplayWidgetTwo.dart';

// searchBarFood widget using FutureBuilder
class searchBarFood extends StatelessWidget {
  final String searchPrompt;
  final TextEditingController _controller = TextEditingController();

  searchBarFood({Key? key, required this.searchPrompt}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: FutureBuilder<List<Food>>(
        future: FoodFetchService().fetchFoodsByName(searchPrompt),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final foods = snapshot.data!;
            return Container(
              width: width,
              height: height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 50),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(30, 20, 16, 0),
                        child: Container(
                          width: width * 0.8,
                          child: Text(
                              foods.length == 1
                                  ? '${foods.length} search available for \'$searchPrompt\''
                                  : '${foods.length} searches available for \'$searchPrompt\'',
                              style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30))),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
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
                              3 / 3.7, // Aspect ratio of each grid cell
                        ),
                        itemBuilder: (context, index) {
                          final food = foods[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
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
                                    border: Border.all(
                                        width: 0.7, color: Colors.black),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                                  color: food.healthScore! < 20
                                                      ? Colors.red
                                                      : Colors.green,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 12),
                                                child: Center(
                                                  child: Text(
                                                      food.healthScore! < 20
                                                          ? 'UNHEALTHY'
                                                          : 'HEALTHY',
                                                      style: GoogleFonts.montserrat(
                                                          textStyle: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 10,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold))),
                                                ),
                                              ),
                                            ),
                                          ),
                                          // Container(
                                          //   width: 35,
                                          //   height: 35,
                                          //   child: Image.asset(
                                          //     'public/assets/images/${nameOfNutrient.toLowerCase()}.jpg',
                                          //   ),
                                          // )
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
          } else {
            return Center(child: Text('No data found'));
          }
        },
      ),
    );
  }
}
