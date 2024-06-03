import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:help_me/providerClass/calorieProvider.dart';
import 'package:provider/provider.dart'; // Make sure to add google_fonts to your pubspec.yaml

class MyPieChartTwo extends ConsumerWidget {
  final int value; // Integer value to determine the red segment's percentage

  MyPieChartTwo({Key? key, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final caloriesValue = ref.read(calorieMeterProvider.notifier).totalCalories;
    print(caloriesValue);
    double redPercentage = (caloriesValue / 1800) *
        100; // Calculate percentage based on 1800 calorie limit
    double otherPercentage = 100 - redPercentage; // Rest of the chart

    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          PieChart(
            PieChartData(
              sectionsSpace: 0, // No space between sections
              centerSpaceRadius: 45,
              startDegreeOffset: -90, // Start from top
              sections: [
                PieChartSectionData(
                  color: Color.fromARGB(255, 255, 24, 8),
                  value: redPercentage,
                  radius: 10,
                  titleStyle: TextStyle(
                      fontSize: 0,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xffffffff)),
                ),
                PieChartSectionData(
                  color: const Color.fromARGB(255, 239, 172, 167),
                  value: otherPercentage,
                  title: '',
                  radius: 10,
                ),
              ],
            ),
          ),
          Container(
            height: 90,
            width: 90,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border: Border.all(
                    color: const Color.fromARGB(255, 0, 0, 0), width: 2)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '$caloriesValue',
                  style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  color: Colors.black,
                  width: 50,
                  height: 2,
                ),
                Text(
                  '1800',
                  style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
