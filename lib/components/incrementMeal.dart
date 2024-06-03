import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:help_me/pages/food/splashScreenFood.dart';
import 'package:help_me/providerClass/calorieProvider.dart';
import 'package:help_me/providerClass/foodTracker.dart';

// Assuming calorieMeterProvider is already defined in another class

class IncrementMeal extends ConsumerStatefulWidget {
  final int calories;

  final String foodName;

  const IncrementMeal(
      {Key? key, required this.calories, required this.foodName})
      : super(key: key);

  @override
  _IncrementMealState createState() => _IncrementMealState();
}

class _IncrementMealState extends ConsumerState<IncrementMeal> {
  int itemCount = 0; // State for the item count

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    int currentCalories = itemCount * widget.calories;

    return Container(
      width: width * 0.84,
      height: itemCount == 0 ? 50 : 120,
      decoration: BoxDecoration(color: Colors.white),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          itemCount != 0
              ? Padding(
                  padding:
                      const EdgeInsets.only(left: 8.0, right: 8, bottom: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Current Calories: $currentCalories',
                        style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          ref
                              .read(calorieMeterProvider.notifier)
                              .increment(currentCalories);

                          ref
                              .read(foodTrackerProvider.notifier)
                              .addToFoodList(widget.foodName);

                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SplashScreen()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                        child: Text(
                          'Submit',
                          style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : Container(),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () {
                    setState(() {
                      if (itemCount > 0) itemCount--;
                    });
                  },
                  color: Colors.white,
                ),
                Text(
                  itemCount > 0 ? itemCount.toString() : 'ADD TO DAILY INTAKE',
                  style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Flexible(
                  child: IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      setState(() {
                        itemCount++;
                      });
                    },
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
