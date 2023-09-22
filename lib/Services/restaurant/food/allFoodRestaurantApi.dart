import 'dart:convert';
import 'package:al_dhaher/Config/constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Model/restaurant/food/allFoodRestaurantModel.dart';


Future<AllFoodRestaurantModel?> getAllRestaurantFoods(String baseUrl) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int restoId = prefs.getInt('userId')?? 0;
  print('restaurant int : $restoId');

  try {

//     final String restaurantId = '1'; // Use an integer instead of a string
//
//     final apiUrl = '$baseUrl${ApiConstants.foodAllRestaurant}/$restaurantId/';
//
// // Now, make the HTTP GET request using apiUrl
//     final response = await http.get(Uri.parse(apiUrl));
    //print('uid = ${body['data']['userid']}');
    final response = await http.get(Uri.parse('$baseUrl${ApiConstants.foodAllRestaurant}/${restoId.toString()}/'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      return AllFoodRestaurantModel.fromJson(jsonResponse);
    } else {
      print('API Error: ${response.statusCode}');
      print('Response Body: ${response.body}');
      throw Exception('Failed to load restaurant foods: HTTP ${response.statusCode}');
    }
  } catch (e) {
    print('Error: $e');
    throw Exception('Failed to load restaurant foods: $e');
  }
}



// Future<AllFoodRestaurantModel?> getAllRestaurantFoods(String baseUrl, String restaurantId) async {
//   try {
//     final response = await http.get(Uri.parse('$baseUrl${ApiConstants.foodAllRestaurant}/$restaurantId/'));
//
//     if (response.statusCode == 200) {
//       final Map<String, dynamic> jsonResponse = json.decode(response.body);
//       return AllFoodRestaurantModel.fromJson(jsonResponse);
//     } else {
//       print('API Error: ${response.statusCode}');
//       print('Response Body: ${response.body}');
//       throw Exception('Failed to load restaurant foods');
//     }
//   } catch (e) {
//     print('Error: $e');
//     throw Exception('Failed to load restaurant foods');
//   }
// }
