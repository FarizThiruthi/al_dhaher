import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../Config/constants.dart';
import '../../../Model/restaurant/food/foodDeleteModel.dart';

Future<FoodDeleteModel> deleteFood(String foodId) async {
  try {
    final response = await http.delete(
      Uri.parse('${ApiConstants.baseUrl}${ApiConstants.foodDelete}/$foodId/'),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      print('Food deleted successfully');
      return FoodDeleteModel.fromJson(jsonDecode(response.body));
    } else {
      print('Error deleting food. Status code: ${response.statusCode}');
      print('Error response body: ${response.body}');
      throw Exception('Failed to delete food');
    }
  } catch (e) {
    print('Error deleting food: $e');
    throw Exception('Failed to delete food');
  }
}
