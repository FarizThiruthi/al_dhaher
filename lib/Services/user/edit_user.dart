import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../Config/constants.dart';

Future<Map<String, dynamic>> updateUser(String userId, Map<String, dynamic> userData) async {
  try {
    final response = await http.put(
      Uri.parse('${ApiConstants.baseUrl}${ApiConstants.updateUser}/$userId'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(userData),
    );

    print('Request URL: ${response.request?.url}');
    print('Request Headers: ${response.request?.headers}');
    print('Response Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');

    if (response.statusCode == 200) {
      final Map<String, dynamic> updatedUserData = json.decode(response.body);
      print('User updated successfully');
      return updatedUserData;
    } else if (response.statusCode == 404) {
      final errorMessage = 'Error updating user: User ID $userId not found';
      print(errorMessage);
      throw Exception(errorMessage);
    } else {
      print('Error updating user. Status code: ${response.statusCode}');
      print('Error response body: ${response.body}');
      throw Exception('Failed to update user');
    }
  } catch (e) {
    print('Error updating user: $e');
    throw Exception('Failed to update user');
  }
}
