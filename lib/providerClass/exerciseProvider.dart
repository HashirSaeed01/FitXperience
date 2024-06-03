import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:help_me/model/exercise.dart';

class savedExercises extends StateNotifier<List<Exercise>> {
  savedExercises() : super([]);

  void addExercise(Exercise exercise) {
    state = [...state, exercise]; // Add the new exercise to the list
  }

  void removeExercise(Exercise exercise) {
    state = state
        .where((e) => e != exercise)
        .toList(); // Remove the specified exercise
  }

  void reset() {
    state = []; // Clear the list of exercises
  }
}

final savedExercisesProvider =
    StateNotifierProvider<savedExercises, List<Exercise>>((ref) {
  return savedExercises(); // Create an instance of SavedExercises
});
