import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../Config/constants.dart';
import '../../../Model/restaurant/food/allFoodModel.dart'; // Import your food model here

Future<AllFoodViewModel?> getAllFoods(String baseUrl) async {
  int retryCount = 3; // Number of retry attempts
  int retryDelay = 1000; // Delay in milliseconds between retries

  for (int i = 0; i < retryCount; i++) {
    try {
      final response = await http.get(Uri.parse(baseUrl + ApiConstants.foodViewAll));

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        return AllFoodViewModel.fromJson(jsonResponse);
      } else {
        print('API Error: ${response.statusCode}');
        print('Response Body: ${response.body}');
        // Throw an exception to retry or handle the error as needed
        throw Exception('Failed to load foods');
      }
    } catch (e) {
      print('Error: $e');
      // If this is not the last attempt, wait before retrying
      if (i < retryCount - 1) {
        await Future.delayed(Duration(milliseconds: retryDelay));
      }
    }
  }

  // Handle the case when all retry attempts fail
  print('All retry attempts failed.');
  throw Exception('Failed to load foods');
}
