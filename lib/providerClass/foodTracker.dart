import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FoodTracker extends StateNotifier<List<String>> {
  FoodTracker() : super([]) {
    loadInitialData();
  }

  // Load initial data from SharedPreferences
  Future<void> loadInitialData() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> loadedFoodList = prefs.getStringList('foodList') ?? [];
    state = loadedFoodList;
    // prefs.clear();
  }

  // Method to add a food item to the list
  void addToFoodList(String foodName) async {
    state = [...state, foodName];
    await _saveData();
  }

  // Getter method to return the list of food items
  List<String> get foodList => state;

  // Method to reset the list of food items
  void reset() async {
    state.clear();
    await _saveData();
  }

  // Save data to SharedPreferences
  Future<void> _saveData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('foodList', state);
  }
}

// Define a provider for the FoodTracker, globally accessible
final foodTrackerProvider =
    StateNotifierProvider<FoodTracker, List<String>>((ref) {
  return FoodTracker();
});
