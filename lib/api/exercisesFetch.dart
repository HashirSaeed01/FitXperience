import 'dart:convert';
import 'package:help_me/model/exercise.dart';
import 'package:http/http.dart' as http;

class ExerciseService {
  static const String apiUrl =
      'https://exercisedb.p.rapidapi.com/exercises/bodyPart/back';
  static const Map<String, String> headers = {
    'X-RapidAPI-Key': 'a86e7be3f4mshda44b5b3ca1c56fp115d39jsn80bcbc5ab92f',
    'X-RapidAPI-Host': 'exercisedb.p.rapidapi.com',
  };

  Future<List<Exercise>> fetchExercises() async {
    final Uri url = Uri.parse(apiUrl).replace(queryParameters: {'limit': '10'});
    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final List<dynamic> jsonList =
          json.decode(response.body) as List<dynamic>;

      print(jsonList
          .map((json) => Exercise.fromJson(json as Map<String, dynamic>))
          .toList());

      return jsonList
          .map((json) => Exercise.fromJson(json as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception('Failed to load exercises');
    }
  }

  Future<List<Exercise>> fetchExercisesByBodypart(String bodyPart) async {
    String bodyPartUrl =
        'https://exercisedb.p.rapidapi.com/exercises/bodyPart/${bodyPart.toLowerCase()}';

    final Uri url =
        Uri.parse(bodyPartUrl).replace(queryParameters: {'limit': '10'});
    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final List<dynamic> jsonList =
          json.decode(response.body) as List<dynamic>;

      print(jsonList
          .map((json) => Exercise.fromJson(json as Map<String, dynamic>))
          .toList());

      return jsonList
          .map((json) => Exercise.fromJson(json as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception('Failed to load exercises');
    }
  }

  Future<List<Exercise>> fetchExercisesForDumbells(String bodyPart) async {
    // Ensure bodyPart modifications are appropriate for API endpoints
    String modifiedBodyPart = bodyPart.toLowerCase();
    if (bodyPart == 'arms') {
      modifiedBodyPart = 'lower arms';
    } else if (bodyPart == 'legs') {
      modifiedBodyPart = 'lower legs';
    }

    // Correctly construct the URL to fetch exercises for a specific body part and equipment
    String sortedByEquipment =
        'https://exercisedb.p.rapidapi.com/exercises/equipment/dumbbell';

    // Filtering by bodyPart needs to happen after fetching the data since the API URL does not include bodyPart as a filter
    final Uri url = Uri.parse(sortedByEquipment);

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final List<dynamic> jsonList =
          json.decode(response.body) as List<dynamic>;

      // Filter exercises after fetching based on body part since the API does not support direct body part filtering with equipment
      final List<Exercise> exercises = jsonList
          .map((json) => Exercise.fromJson(json as Map<String, dynamic>))
          .where((exercise) =>
              exercise.equipment.toLowerCase().contains('dumbbell') &&
              exercise.bodyPart.toLowerCase().contains(modifiedBodyPart))
          .toList();

      return exercises; // Return the filtered list directly without limiting in the method
    } else {
      throw Exception('Failed to load exercises using dumbbells');
    }
  }

  Future<List<Exercise>> fetchExercisesForBodyweight(String bodyPart) async {
    // Convert bodyPart to lowercase and adjust as needed for API compatibility
    String modifiedBodyPart = bodyPart.toLowerCase();
    if (bodyPart == 'arms') {
      modifiedBodyPart = 'lower arms';
    } else if (bodyPart == 'legs') {
      modifiedBodyPart = 'lower legs';
    }

    // Construct the URL to filter by equipment 'body weight'
    String sortedByEquipment =
        'https://exercisedb.p.rapidapi.com/exercises/equipment/body weight';

    final Uri url = Uri.parse(sortedByEquipment);

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final List<dynamic> jsonList =
          json.decode(response.body) as List<dynamic>;

      // Filter the exercises to only include those using 'body weight' and match the specified body part
      final List<Exercise> exercises = jsonList
          .map((json) => Exercise.fromJson(json as Map<String, dynamic>))
          .where((exercise) =>
              exercise.equipment.toLowerCase().contains('body weight') &&
              exercise.bodyPart.toLowerCase().contains(modifiedBodyPart))
          .toList();

      return exercises; // Return the full list of filtered exercises
    } else {
      throw Exception('Failed to load bodyweight exercises');
    }
  }

  Future<List<Exercise>> fetchExerciseByName(String name) async {
    name = name.toString().toLowerCase();
    // Encode the exercise name to handle spaces and special characters
    final String encodedName = Uri.encodeComponent(name);

    // Construct the URL to filter by exercise name
    String filteredByNameUrl =
        'https://exercisedb.p.rapidapi.com/exercises/name/$encodedName';

    final Uri url = Uri.parse(filteredByNameUrl);

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final List<dynamic> jsonList =
          json.decode(response.body) as List<dynamic>;

      // Convert the JSON response to a list of Exercise objects
      return jsonList
          .map((json) => Exercise.fromJson(json as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception('Failed to load exercises by name');
    }
  }
}
