import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../Config/constants.dart';
import '../../Model/restaurant/viewAllRestoModel.dart';

Future<ViewAllRestoModel?> getAllRestaurants(String baseUrl) async {
  try {
    final response = await http.get(Uri.parse(baseUrl + ApiConstants.allResto));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      return ViewAllRestoModel.fromJson(jsonResponse);
    } else {
      print('API Error: ${response.statusCode}');
      print('Response Body: ${response.body}');
      throw Exception('Failed to load restaurants');
    }
  } catch (e) {
    print('Error: $e');
    throw Exception('Failed to load restaurants');
  }
}
