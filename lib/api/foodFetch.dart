import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:help_me/model/food.dart';

class FoodFetchService {
  static const String apiKey = 'c4cfe834d41b4bfc89da435988b753a0';
  static const String apiUrlRandom =
      'https://api.spoonacular.com/recipes/random';
  static const int defaultNumber = 5;

  Future<List<Food>> fetchRandomFood() async {
    final Map<String, String> params = {
      'apiKey': apiKey,
      'number': defaultNumber.toString(),
    };

    final Uri uri = Uri.parse(apiUrlRandom).replace(queryParameters: params);

    final http.Response response = await http.get(uri);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['recipes'];
      return data.map((json) => Food.fromJson(json)).toList();
    } else {
      throw Exception(
          'Failed to load recipes: ${response.statusCode} ${response.reasonPhrase}');
    }
  }

  Future<List<Food>> fetchFoodByVitamins(String vitaminName) async {
    final Map<String, String> params = {
      'apiKey': 'c4cfe834d41b4bfc89da435988b753a0',
      'number': '4',
    };

    String url;

    if (vitaminName.toString() == 'Protein') {
      url =
          'https://api.spoonacular.com/recipes/findByNutrients?minProtein=40&maxProtein=100';
    } else if (vitaminName.toString() == 'Carbs') {
      url =
          'https://api.spoonacular.com/recipes/findByNutrients?minCarbs=10&maxCarbs=50';
    } else if (vitaminName.toString() == 'Fat') {
      url = 'https://api.spoonacular.com/recipes/findByNutrients?minFat=50&';
    } else if (vitaminName.toString() == 'Fiber') {
      url = 'https://api.spoonacular.com/recipes/findByNutrients?minFiber=20';
    } else if (vitaminName.toString() == 'Calcium') {
      url = 'https://api.spoonacular.com/recipes/findByNutrients?minCalcium=20';
    } else if (vitaminName.toString() == 'Magnesium') {
      url =
          'https://api.spoonacular.com/recipes/findByNutrients?minMagnesium=20';
    } else if (vitaminName.toString() == 'Iron') {
      url = 'https://api.spoonacular.com/recipes/findByNutrients?minIron=20';
    } else if (vitaminName.toString() == 'Vitamins') {
      url =
          'https://api.spoonacular.com/recipes/findByNutrients?minVitaminB12=20';
    } else if (vitaminName.toString() == 'Zinc') {
      url = 'https://api.spoonacular.com/recipes/findByNutrients?minZinc=20';
    } else {
      //    'Calcium',
      // 'Magnesium',
      // 'Iron',
      // 'Vitamins',
      // 'Zinc'
      // Handle other cases or throw an error
      throw ArgumentError('Invalid vitamin name: $vitaminName');
    }

    final Uri uri = Uri.parse(url + '&apiKey=$apiKey'); // Append API key to URL

    final http.Response response = await http.get(uri);

    print(response.body.toString());
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Food.fromJson(json)).toList();
    } else {
      throw Exception(
          'Failed to load recipes: ${response.statusCode} ${response.reasonPhrase}');
    }
  }

  Future<Map<String, dynamic>> fetchNutritionWidget(int recipeId) async {
    final String apiKey = 'c4cfe834d41b4bfc89da435988b753a0';

    final String url =
        'https://api.spoonacular.com/recipes/$recipeId/nutritionWidget.json?apiKey=$apiKey';

    final Uri uri = Uri.parse(url);

    final http.Response response = await http.get(uri);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return data;
    } else {
      throw Exception(
          'Failed to load nutrition data: ${response.statusCode} ${response.reasonPhrase}');
    }
  }

  // Fetches basic search results by name
  Future<List<Food>> fetchFoodsByName(String query) async {
    final String baseUrl = 'https://api.spoonacular.com';

    final Uri searchUri =
        Uri.parse('$baseUrl/recipes/autocomplete').replace(queryParameters: {
      'apiKey': apiKey,
      'query': query.toLowerCase(),
      'number': '1' // Adjust number as needed
    });

    final http.Response searchResponse = await http.get(searchUri);

    print(searchResponse.body.toString());
    if (searchResponse.statusCode == 200) {
      List<dynamic> searchResults = json.decode(searchResponse.body);
      List<Future<Food>> detailsFutures = [];

      // Fetch details for each search result
      for (var result in searchResults) {
        int id = result['id'];
        detailsFutures.add(fetchRecipeById(id));
      }

      // Wait for all fetch operations to complete
      List<Food> foods = await Future.wait(detailsFutures);
      return foods;
    } else {
      throw Exception(
          'Failed to fetch foods: ${searchResponse.statusCode} ${searchResponse.reasonPhrase}');
    }
  }

  // Fetches detailed information about a recipe by ID
  Future<Food> fetchRecipeById(int recipeId) async {
    final String baseUrl = 'https://api.spoonacular.com';

    final Uri detailsUri = Uri.parse('$baseUrl/recipes/$recipeId/information')
        .replace(queryParameters: {'apiKey': apiKey});

    final http.Response detailsResponse = await http.get(detailsUri);
    if (detailsResponse.statusCode == 200) {
      return Food.fromJson(
          json.decode(detailsResponse.body) as Map<String, dynamic>);
    } else {
      throw Exception(
          'Failed to fetch recipe details: ${detailsResponse.statusCode} ${detailsResponse.reasonPhrase}');
    }
  }
}
