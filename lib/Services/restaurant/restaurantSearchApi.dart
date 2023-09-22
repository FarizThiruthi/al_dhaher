import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../Config/constants.dart';
import '../../Model/restaurant/searchRestoModel.dart';

Future<List<Data>> searchRestaurants(String query) async {
  try {
    final response = await http.post(
      Uri.parse('${ApiConstants.baseUrl}${ApiConstants.searchResto}'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'query': query}),
    );

    print('Request URL: ${response.request?.url}');
    print('Request Headers: ${response.request?.headers}');
    print('Response Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final List<Data> restaurantList = (responseData['data'] as List)
          .map((item) => Data.fromJson(item))
          .toList();
      return restaurantList;
    } else {
      print('Error searching restaurants. Status code: ${response.statusCode}');
      print('Error response body: ${response.body}');
      throw Exception('Failed to search restaurants');
    }
  } catch (e) {
    print('Error searching restaurants: $e');
    throw Exception('Failed to search restaurants');
  }
}
