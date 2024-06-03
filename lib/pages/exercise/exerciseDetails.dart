import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:help_me/components/addExerciseButton.dart';
import 'package:help_me/model/exercise.dart'; // Make sure your path to the model is correct

class ExerciseDetailsWidget extends StatefulWidget {
  final Exercise exercise; // Exercise object passed to the widget

  const ExerciseDetailsWidget({super.key, required this.exercise});

  @override
  State<ExerciseDetailsWidget> createState() => _ExerciseDetailsWidgetState();
}

class _ExerciseDetailsWidgetState extends State<ExerciseDetailsWidget> {
  String capitalizeFirstLetterOfEachWord(String input) {
    return input.split(' ').map((word) {
      if (word.isEmpty) return word;
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).join(' ');
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xFFF1F4F8),
      body: SafeArea(
        child: Expanded(
          child: Container(
            width: width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            height: 350,
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(50)),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: CachedNetworkImage(
                                imageUrl: widget.exercise
                                    .gifUrl, // Assuming there is an imageUrl field in Exercise
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          child: Container(
                            // width: 300,
                            child: Text(
                              capitalizeFirstLetterOfEachWord(
                                  widget.exercise.name),
                              // Name of the exercise
                              style: GoogleFonts.montserrat(
                                textStyle: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        // Container(
                        //   width: width,
                        //   height: 2,
                        //   color: Colors.black,
                        // ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            children: [
                              Text(
                                'Targeted muscle : ', // Body part worked by the exercise
                                style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Text(
                                capitalizeFirstLetterOfEachWord(
                                    widget.exercise.bodyPart),
                                // Name of the exercise
                                style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Container(
                            width: 400,
                            child: Wrap(
                              children: [
                                Text(
                                  'Secondary muscles : ', // Body part worked by the exercise
                                  style: GoogleFonts.montserrat(
                                    textStyle: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Text(
                                  capitalizeFirstLetterOfEachWord(
                                    widget.exercise.secondaryMuscles
                                        .toString()
                                        .replaceAll('[', '') // Remove '['
                                        .replaceAll(']', '') // Remove ']'
                                        .trim(), // Trim any leading/trailing whitespace
                                  ),
                                  // Name of the exercise
                                  style: GoogleFonts.montserrat(
                                    textStyle: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 15),
                        Container(
                          // width: 300,
                          // height: 200,
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: OverflowBar(
                            children: [
                              Text(
                                'Instructions : ', // Body part worked by the exercise
                                style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Text(
                                capitalizeFirstLetterOfEachWord(
                                  widget.exercise.instructions
                                      .toString()
                                      .replaceAll('[', '') // Remove '['
                                      .replaceAll(']', '') // Remove ']'
                                      .trim(),
                                ),
                                // Name of the exercise
                                style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                Center(
                    child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: addedExercise(exerciseToBeAdded: widget.exercise),
                ))
                // ...Other UI components
              ],
            ),
          ),
        ),
      ),
    );
  }
}
