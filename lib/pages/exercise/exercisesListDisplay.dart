import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:help_me/api/exercisesFetch.dart';
import 'package:help_me/components/buildSearchBar.dart';
import 'package:help_me/model/exercise.dart';
import 'package:help_me/pages/exercise/exerciseDetails.dart';

final exercisesProvider =
    FutureProvider.family<List<Exercise>, String>((ref, bodyPart) async {
  final exerciseService = ref.read(exerciseServiceProvider);
  return exerciseService.fetchExercisesByBodypart(bodyPart);
});

final exercisesProviderTwo =
    FutureProvider.family<List<Exercise>, String>((ref, bodypart) async {
  final exerciseService = ref.read(exerciseServiceProvider);

  final hello = bodypart.toString().split(' ');

  String bodyPartOne = hello[0];

  String equipment = hello[1];

  print(bodyPartOne);
  print(equipment);

  if (equipment == '1') {
    return exerciseService.fetchExercisesForDumbells(bodyPartOne);
  } else if (equipment == '2') {
    return exerciseService.fetchExercisesForBodyweight(bodyPartOne);
  }
  return exerciseService.fetchExercisesByBodypart(equipment);
});
final exerciseServiceProvider = Provider<ExerciseService>((ref) {
  return ExerciseService();
});

final selectedIndexProvider = StateProvider<int>((ref) => -1);

class AddExerciseScreen extends ConsumerWidget {
  final String bodyPart;

  AddExerciseScreen({super.key, required this.bodyPart});

  final List<String> imagePaths = [
    'public/assets/images/gym.jpg',
    'public/assets/images/dumbell.jpg',
    'public/assets/images/fullBody.jpg',
  ];
  final List<String> equipmentNames = ['Gym', 'Dumbells', 'Full-body'];

  // final List<List<String>> dumbellAndFullBody =

// assisted,band,barbell,body weight,bosu ball,cable,dumbbell,elliptical machine,ez barbell,hammer,kettlebell,leverage machine,medicine ball,olympic barbell,resistance band,roller,rope,skierg machine,sled machine,smith machine,stability ball,stationary bike,stepmill machine,tire,trap bar,upper body ergometer,weighted,wheel roller

  int selectedIndex = 1;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(selectedIndexProvider);

    // Widget _buildSearchBar() {
    //   return TextField(
    //     onChanged: (value) {
    //       ref.watch(fetchByName(value));
    //     },
    //     decoration: InputDecoration(
    //       hintText: 'Search',
    //       hintStyle: GoogleFonts.montserrat(
    //           textStyle: TextStyle(
    //               color: Colors.black,
    //               fontSize: 18,
    //               fontWeight: FontWeight.bold)),
    //       prefixIcon: Icon(Icons.search),
    //       filled: true,
    //       fillColor: Colors.white,
    //       contentPadding: EdgeInsets.only(),
    //       border: OutlineInputBorder(
    //         borderRadius: BorderRadius.circular(30),
    //         borderSide: BorderSide.none,
    //       ),
    //       focusedBorder: OutlineInputBorder(
    //         borderRadius: BorderRadius.circular(30),
    //         borderSide: BorderSide(color: Theme.of(context).primaryColor),
    //       ),
    //     ),
    //   );
    // }

    String capitalizeFirstLetterOfEachWord(String input) {
      return input.split(' ').map((word) {
        if (word.isEmpty) return word;
        return word[0].toUpperCase() + word.substring(1).toLowerCase();
      }).join(' ');
    }

    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        automaticallyImplyLeading: false,
        title: Text('Exercise List Display',
            style: GoogleFonts.montserrat(
                textStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold))),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
                width: width * 0.9,
                height: 50,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.circular(20)),
                child: BuildSearchBarExercise()),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment(-0.8, 0),
              child: Text(
                'Find Your Equipment',
                style: GoogleFonts.montserrat(
                  textStyle:
                      TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: GestureDetector(
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //       builder: (context) => ExerciseDetailsWidget()),
                // );
              },
              child: Container(
                height: 150,
                width: width,
                child: ListView.builder(
                    itemCount: 3, // This could be dynamic based on the content
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            ref.read(selectedIndexProvider.notifier).state =
                                index;
                          },
                          child: Container(
                            width: 100,
                            // height: 150,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 255, 255, 255),
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 7,
                                    offset: Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                                border: Border.all(
                                    width: selectedIndex != index ? 1 : 3,
                                    color: selectedIndex != index
                                        ? Colors.red
                                        : Colors.green)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                    width: 100,
                                    height: 100,
                                    child: Image.asset(imagePaths[index])),
                                Text(equipmentNames[index],
                                    style: GoogleFonts.montserrat(
                                        textStyle: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black))),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: Container(
              width: width * 0.9,
              child: Consumer(
                builder: (context, ref, _) {
                  final exerciseAsyncValue = selectedIndex < 1
                      ? ref.watch(exercisesProvider(bodyPart))
                      : ref.watch(exercisesProviderTwo(
                          '${bodyPart.toString().toLowerCase() + " " + selectedIndex.toString()}'));

                  return exerciseAsyncValue.when(
                    data: (exercises) {
                      return ListView.builder(
                        itemCount: exercises.length,
                        itemBuilder: (context, index) {
                          final exercise = exercises[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ExerciseDetailsWidget(
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
                                      border: Border.all(
                                          color: Colors.black, width: 1),
                                    ),
                                    // height: 150,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
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
                                                    style:
                                                        GoogleFonts.montserrat(
                                                            textStyle: TextStyle(
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .black))),
                                              ),
                                              Row(
                                                children: [
                                                  Text('Target: ',
                                                      style: GoogleFonts
                                                          .montserrat(
                                                              textStyle: TextStyle(
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .red))),
                                                  Text(
                                                      capitalizeFirstLetterOfEachWord(
                                                          exercise.bodyPart),
                                                      style: GoogleFonts
                                                          .montserrat(
                                                              textStyle: TextStyle(
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .black))),
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
                                                      style: GoogleFonts
                                                          .montserrat(
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
                                                      style: GoogleFonts
                                                          .montserrat(
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
                          );
                        },
                      );
                    },
                    loading: () => Center(child: CircularProgressIndicator()),
                    error: (e, _) => Text('Error: $e'),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
