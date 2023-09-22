import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../Config/constants.dart';

Future<Map<String, dynamic>> updateRestaurantData(String restaurantId, Map<String, dynamic> restaurantData) async {
  try {
    final response = await http.put(
      Uri.parse('${ApiConstants.baseUrl}${ApiConstants.updateResto}/$restaurantId'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(restaurantData),
    );

    print('Request URL: ${response.request?.url}');
    print('Request Headers: ${response.request?.headers}');
    print('Response Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');

    if (response.statusCode == 200) {
      final Map<String, dynamic> updatedRestaurantData = json.decode(response.body);
      print('Restaurant updated successfully');
      return updatedRestaurantData;
    } else if (response.statusCode == 404) {
      final errorMessage = 'Error updating restaurant: Restaurant ID $restaurantId not found';
      print(errorMessage);
      throw Exception(errorMessage);
    } else {
      print('Error updating restaurant. Status code: ${response.statusCode}');
      print('Error response body: ${response.body}');
      throw Exception('Failed to update restaurant');
    }
  } catch (e) {
    print('Error updating restaurant: $e');
    throw Exception('Failed to update restaurant');
  }
}
