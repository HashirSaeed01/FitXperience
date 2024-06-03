import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:help_me/api/exercisesFetch.dart';
import 'package:help_me/model/exercise.dart';
import 'package:help_me/pages/exercise/workoutForToday.dart';

final fetchByName =
    FutureProvider.family<List<Exercise>, String>((ref, NAME) async {
  final exerciseService = ref.read(exerciseServiceProvider);
  return exerciseService.fetchExerciseByName(NAME);
});

final exerciseServiceProvider = Provider<ExerciseService>((ref) {
  return ExerciseService();
});

class BuildSearchBarExercise extends ConsumerWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextField(
      controller: _controller,
      onSubmitted: (value) async {
        try {
          // Show a loading dialog or a spinner
          // showDialog(
          //   context: context,
          //   barrierDismissible: false,
          //   builder: (context) => Center(child: CircularProgressIndicator()),
          // );

          // Trigger the search and wait for results
          List<Exercise> exercises = await ref.read(fetchByName(value).future);

          // Dismiss the loading dialogAA
          // Navigator.of(context).pop();

          // Push the results to a new screen
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  ExercisesListScreen(listOfExercises: exercises),
            ),
          );
        } catch (e) {
          Navigator.of(context)
              .pop(); // dismiss the loading dialog if an error occurs
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Error'),
              content: Text('Failed to fetch exercises.'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('OK'),
                ),
              ],
            ),
          );
        }
      },
      decoration: InputDecoration(
        hintText: 'Search',
        hintStyle: GoogleFonts.montserrat(
            textStyle: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold)),
        prefixIcon: Icon(Icons.search),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.only(),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Theme.of(context).primaryColor),
        ),
      ),
    );
  }
}
