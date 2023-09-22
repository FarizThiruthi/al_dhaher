import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../Config/constants.dart';
import '../../../Model/restaurant/food/addFoodModel.dart';


Future<FoodCreateModel> createFood({
  required String restaurantId,
  required String foodName,
  required String quantity,
  required String price,
  required String category,
}) async {
  try {
    final Map<String, dynamic> foodData = {
      "restaurant_id": restaurantId,
      "food_name": foodName,
      "quantity": quantity,
      "price": price,
      "category": category,
    };

    final response = await http.post(
      Uri.parse('${ApiConstants.baseUrl}${ApiConstants.foodCreate}'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(foodData),
    );

    if (response.statusCode == 201) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      print('Food created successfully');
      return FoodCreateModel.fromJson(responseData);
    } else if (response.statusCode == 200) {
      // You can also treat 200 as success if needed
      final Map<String, dynamic> responseData = json.decode(response.body);
      print('Food created successfully');
      return FoodCreateModel.fromJson(responseData);
    } else {
      print('Error creating food. Status code: ${response.statusCode}');
      print('Error response body: ${response.body}');
      throw Exception('Failed to create food');
    }
  } catch (e) {
    print('Error creating food: $e');
    throw Exception('Failed to create food');
  }
}




// Future<FoodCreateModel> createFood({
//   required String restaurantId,
//   required String foodName,
//   required String quantity,
//   required String price,
//   required String category,
// }) async {
//   try {
//     final Map<String, dynamic> foodData = {
//       "restaurant_id": restaurantId,
//       "food_name": foodName,
//       "quantity": quantity,
//       "price": price,
//       "category": category,
//     };
//
//     final response = await http.post(
//       Uri.parse('${ApiConstants.baseUrl}${ApiConstants.foodCreate}'),
//       headers: {
//         'Content-Type': 'application/json',
//       },
//       body: jsonEncode(foodData),
//     );
//
//     if (response.statusCode == 200) {
//       final Map<String, dynamic> responseData = json.decode(response.body);
//       print('Food created successfully');
//       return FoodCreateModel.fromJson(responseData);
//     } else {
//       print('Error creating food. Status code: ${response.statusCode}');
//       print('Error response body: ${response.body}');
//       throw Exception('Failed to create food');
//     }
//   } catch (e) {
//     print('Error creating food: $e');
//     throw Exception('Failed to create food');
//   }
// }
