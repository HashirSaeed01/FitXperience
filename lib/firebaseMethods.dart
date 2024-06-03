import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Function to add or update meal data
  Future<void> saveMeal(String name, int calories) async {
    try {
      await _db.collection('foods').doc('meal').set({
        'name': name,
        'calories': calories,
      });
    } catch (e) {
      print("Error saving meal to Firestore: $e");
      throw Exception('Failed to save meal');
    }
  }

  // Function to get meal data
  Future<Map<String, dynamic>?> fetchMeal() async {
    try {
      DocumentSnapshot snapshot =
          await _db.collection('foods').doc('meal').get();
      return snapshot.data() as Map<String, dynamic>?;
    } catch (e) {
      print("Error fetching meal from Firestore: $e");
      throw Exception('Failed to fetch meal');
    }
  }
}
