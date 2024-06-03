import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:help_me/model/exercise.dart';
import 'package:help_me/pages/exercise/splashScreenExercise.dart';
import 'package:help_me/providerClass/exerciseProvider.dart';

// Assuming calorieMeterProvider is already defined in another class

class addedExercise extends ConsumerStatefulWidget {
  Exercise exerciseToBeAdded;

  addedExercise({Key? key, required this.exerciseToBeAdded}) : super(key: key);

  @override
  _addedExerciseState createState() => _addedExerciseState();
}

class _addedExerciseState extends ConsumerState<addedExercise> {
  int itemCount = 0; // State for the item count

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Container(
      width: width * 0.84,
      height: 50,
      decoration: BoxDecoration(color: Colors.white),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ElevatedButton(
            onPressed: () {
              ref
                  .read(savedExercisesProvider.notifier)
                  .addExercise(widget.exerciseToBeAdded);

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => SplashScreenExercise()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: Text(
              'ADD TO WORKOUT',
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
    );
  }
}
