import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../Config/constants.dart';


Future<Map<String, dynamic>> updateFood(String foodId, Map<String, dynamic> foodData) async {
  try {
    final response = await http.put(
      Uri.parse('${ApiConstants.baseUrl}${ApiConstants.foodUpdate}/$foodId/'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(foodData),
    );

    print('Request URL: ${response.request?.url}');
    print('Request Headers: ${response.request?.headers}');
    print('Response Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');

    if (response.statusCode == 200) {

      final Map<String, dynamic> updatedFoodData = json.decode(response.body);
      print('Food updated successfully');
      return updatedFoodData;
    } else if (response.statusCode == 404) {
      final errorMessage = 'Error updating food: Food ID $foodId not found';
      print(errorMessage);
      throw Exception(errorMessage);
    } else if (response.statusCode == 400) {
      final errorResponse = json.decode(response.body);
      final errorMessage = 'Error updating food: ${errorResponse['data']}';
      print(errorMessage);
      throw Exception(errorMessage);
    } else {
      final errorMessage = 'Error updating food. Status code: ${response.statusCode}';
      print(errorMessage);
      throw Exception(errorMessage);
    }
  } catch (e) {
    print('Error updating food: $e');
    throw Exception('Failed to update food');
  }
}

