import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:help_me/api/foodFetch.dart';
import 'package:help_me/components/incrementMeal.dart';
import 'package:help_me/model/food.dart';
import 'package:help_me/pages/food/foodDisplayWidget.dart';

final foodServiceProvider = Provider<FoodFetchService>((ref) {
  return FoodFetchService();
});

final foodProvider =
    FutureProvider.family<Map<String, dynamic>, int>((ref, foodID) async {
  final foodService = ref.read(foodServiceProvider);
  return foodService.fetchNutritionWidget(foodID);
});

class FoodDisplayWidgetTwo extends ConsumerWidget {
  final Food food;

  const FoodDisplayWidgetTwo({super.key, required this.food});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;

    final height = MediaQuery.sizeOf(context).height;

    final nutritionDataAsyncValue = ref.watch(foodProvider(food.id));

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_rounded,
            color: Color(0xFF14181B),
            size: 30,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('DETAILS', // Use title from Food object
            style: GoogleFonts.montserrat(
                textStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold))),
        centerTitle: false,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: CachedNetworkImage(
                      imageUrl: food.image,
                      width: width * 0.9,
                      height: 250,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16, 12, 0, 0),
              child: Text(food.title,
                  style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.bold))),
            ),
            SizedBox(
              height: 10,
            ),
            nutritionDataAsyncValue.when(
              loading: () => Center(child: CircularProgressIndicator()),
              error: (error, stackTrace) =>
                  Center(child: Text('Error: $error')),
              data: (nutritionData) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildNutrientCard(
                      'Protein',
                      'public/assets/images/protein.jpg',
                      nutritionData['protein'] ?? 'N/A',
                    ),
                    _buildNutrientCard(
                      'Carbs',
                      'public/assets/images/carbs.jpg',
                      nutritionData['carbs'] ?? 'N/A',
                    ),
                    _buildNutrientCard(
                      'Fats',
                      'public/assets/images/fat.jpg',
                      nutritionData['fat'] ?? 'N/A',
                    ),
                    _buildNutrientCard(
                      'Fiber',
                      'public/assets/images/fiber.jpg',
                      nutritionData['Sugar'] ?? 'N/A',
                    )
                  ],
                );
              },
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IncrementMeal(
                    calories: food.calories == null ? 120 : food.calories!,
                    foodName: food.title,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNutrientCard(
      String nutrientName, String imagePath, String amount) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 120,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(width: 1, color: Colors.black),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 80,
                height: 70,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(imagePath),
                ),
              ),
              Expanded(
                child: Text(
                  nutrientName,
                  style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  amount,
                  style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
