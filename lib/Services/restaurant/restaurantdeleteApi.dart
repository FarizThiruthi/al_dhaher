import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../Config/constants.dart';

Future<void> deleteRestaurant(String restaurantId) async {
  try {
    final response = await http.delete(
      Uri.parse('${ApiConstants.baseUrl}${ApiConstants.deleteResto}/$restaurantId'),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    print('Request URL: ${response.request?.url}');
    print('Request Headers: ${response.request?.headers}');
    print('Response Status Code: ${response.statusCode}');

    if (response.statusCode == 200) {
      print('Restaurant deleted successfully');
      // Optionally, you can return a success message or perform other actions
    } else if (response.statusCode == 404) {
      final errorMessage = 'Error deleting restaurant: Restaurant ID $restaurantId not found';
      print(errorMessage);
      throw Exception(errorMessage);
    } else {
      print('Error deleting restaurant. Status code: ${response.statusCode}');
      print('Error response body: ${response.body}');
      throw Exception('Failed to delete restaurant');
    }
  } catch (e) {
    print('Error deleting restaurant: $e');
    throw Exception('Failed to delete restaurant');
  }
}
