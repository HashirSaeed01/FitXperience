import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:help_me/components/buildSearchBar.dart';
import 'package:help_me/components/confirmationScreen.dart';
import 'package:help_me/model/exercise.dart';
import 'package:help_me/pages/exercise/exerciseDetails.dart';
import 'package:help_me/providerClass/exerciseProvider.dart';

class ExercisesListScreen extends ConsumerWidget {
  String capitalizeFirstLetterOfEachWord(String input) {
    return input.split(' ').map((word) {
      if (word.isEmpty) return word;
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).join(' ');
  }

  final List<Exercise>? listOfExercises;

  ExercisesListScreen({this.listOfExercises});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listOfExercisesOne = listOfExercises == null ? [] : listOfExercises!;

    final List<Exercise> exercises = listOfExercisesOne.isEmpty
        ? ref.watch(savedExercisesProvider)
        : listOfExercises!;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        automaticallyImplyLeading: false,
        title: Text('Today\'s workout',
            style: GoogleFonts.montserrat(
                textStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold))),
      ),
      body: exercises.isEmpty
          ? Center(
              child: Text(
                'No exercises added yet',
                style: GoogleFonts.montserrat(fontSize: 20),
              ),
            )
          : Padding(
              padding: const EdgeInsets.only(top: 40.0),
              child: ListView.builder(
                itemCount: exercises.length,
                itemBuilder: (BuildContext context, int index) {
                  final exercise = exercises[index];
                  return Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 24, right: 24, bottom: 25),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ExerciseDetailsWidget(
                                        key: UniqueKey(),
                                        exercise: exercise,
                                      )), // Make sure you have a DisplayScreen widget
                            );
                          },
                          child: Card(
                            color: Color.fromARGB(255, 255, 255, 255),
                            child: Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border:
                                      Border.all(color: Colors.black, width: 1),
                                ),
                                // height: 150,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: 200,
                                            child: Text(
                                                capitalizeFirstLetterOfEachWord(
                                                    exercise.name),
                                                // exercise.name,
                                                style: GoogleFonts.montserrat(
                                                    textStyle: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black))),
                                          ),
                                          Row(
                                            children: [
                                              Text('Target: ',
                                                  style: GoogleFonts.montserrat(
                                                      textStyle: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.red))),
                                              Text(
                                                  capitalizeFirstLetterOfEachWord(
                                                      exercise.bodyPart),
                                                  style: GoogleFonts.montserrat(
                                                      textStyle: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color:
                                                              Colors.black))),
                                            ],
                                          ),
                                          Container(
                                            width:
                                                200, // Fixed width to trigger wrapping
                                            child: Wrap(
                                              spacing:
                                                  4.0, // Horizontal space between children
                                              runSpacing:
                                                  4.0, // Vertical space between lines
                                              alignment: WrapAlignment
                                                  .start, // Align items to the start of the wrap
                                              children: [
                                                Text(
                                                  'Equipment: ',
                                                  style: GoogleFonts.montserrat(
                                                    textStyle: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  capitalizeFirstLetterOfEachWord(
                                                      exercise
                                                          .equipment), // Assumes this function exists to capitalize words
                                                  style: GoogleFonts.montserrat(
                                                    textStyle: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Stack(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          child: Image.network(
                                            exercise.gifUrl,
                                            height: 100.0,
                                            width: 100.0,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      listOfExercisesOne.length == 0
                          ? Positioned(
                              top: 4,
                              right: 28,
                              child: Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(10),
                                        topRight: Radius.circular(10)),
                                    border: Border.all(
                                        color: Colors.black, width: 1)),
                                child: IconButton(
                                  onPressed: () async {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text(
                                            "Are you sure?",
                                            style: GoogleFonts.montserrat(
                                                textStyle: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 24)),
                                          ),
                                          content: Text(
                                              "Do you want to perform this action?",
                                              style: GoogleFonts.montserrat(
                                                  textStyle: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontSize: 16))),
                                          actions: <Widget>[
                                            TextButton(
                                              child: Text("Cancel",
                                                  style: GoogleFonts.montserrat(
                                                      textStyle: TextStyle(
                                                          color: Colors.red,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          fontSize: 16))),
                                              onPressed: () {
                                                Navigator.of(context)
                                                    .pop(); // Close the dialog
                                              },
                                            ),
                                            TextButton(
                                              child: Text("Confirm",
                                                  style: GoogleFonts.montserrat(
                                                      textStyle: TextStyle(
                                                          color: Colors.red,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          fontSize: 16))),
                                              onPressed: () {
                                                ref
                                                    .read(savedExercisesProvider
                                                        .notifier)
                                                    .removeExercise(exercise);

                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  icon: Icon(
                                    Icons.remove,
                                    size: 14,
                                    color: Colors.white,
                                    weight: 20,
                                  ),
                                ),
                              ),
                            )
                          : Container()
                    ],
                  );
                },
              ),
            ),
    );
  }
}
