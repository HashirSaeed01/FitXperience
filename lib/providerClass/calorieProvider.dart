// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class CalorieMeter extends StateNotifier<int> {
//   CalorieMeter() : super(0) {
//     loadInitialData();
//   }

//   List<int> calorieIncrements = [];

//   // Method to load initial data from SharedPreferences
//   Future<void> loadInitialData() async {
//     final prefs = await SharedPreferences.getInstance();
//     state = prefs.getInt('calories') ?? 0;
//     calorieIncrements =
//         prefs.getStringList('calorieIncrements')?.map(int.parse).toList() ?? [];
//   }

//   // Method to increment the calorie count
//   void increment(int value) async {
//     state += value;
//     calorieIncrements.add(value);
//     await _saveData();
//   }

//   // Method to reset the calorie count and clear the list of increments
//   void reset() async {
//     state = 0;
//     calorieIncrements.clear();
//     await _saveData();
//   }

//   // Method to save data to SharedPreferences
//   Future<void> _saveData() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setInt('calories', state);
//     await prefs.setStringList('calorieIncrements',
//         calorieIncrements.map((i) => i.toString()).toList());
//   }

//   int get totalCalories => state;
// }

// final calorieMeterProvider = StateNotifierProvider<CalorieMeter, int>((ref) {
//   return CalorieMeter();
// });

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CalorieMeter extends StateNotifier<int> {
  final FirebaseFirestore firestore;

  CalorieMeter(this.firestore) : super(0) {
    loadInitialData();
  }

  List<int> calorieIncrements = [];

  // Method to load initial data from Firestore
  Future<void> loadInitialData() async {
    try {
      var doc = await firestore.collection('foods').doc('meal').get();
      if (doc.exists) {
        state = doc.data()?['calories'] ?? 0;
        var increments = doc.data()?['calorieIncrements'] as List<dynamic>?;
        calorieIncrements = increments?.map((e) => e as int).toList() ?? [];
      }
    } catch (e) {
      // Handle errors or set default state
      state = 0;
      calorieIncrements = [];
    }
  }

  // Method to increment the calorie count and update Firestore
  void increment(int value) {
    state += value;
    calorieIncrements.add(value);
    _saveData();
  }

  // Method to save data to Firestore
  Future<void> _saveData() async {
    await firestore.collection('foods').doc('meal').set({
      'calories': state,
      'calorieIncrements': calorieIncrements,
    });
  }

  // Method to reset the calorie count and clear data in Firestore
  void reset() async {
    state = 0;
    calorieIncrements.clear();
    await _saveData();
  }

  int get totalCalories => state;
}

final calorieMeterProvider = StateNotifierProvider<CalorieMeter, int>((ref) {
  return CalorieMeter(FirebaseFirestore.instance);
});
