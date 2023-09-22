import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../Config/constants.dart';

Future<void> deleteUser(String userId) async {
  try {
    final response = await http.delete(
      Uri.parse('${ApiConstants.baseUrl}${ApiConstants.deleteUser}/$userId'),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    print('Request URL: ${response.request?.url}');
    print('Request Headers: ${response.request?.headers}');
    print('Response Status Code: ${response.statusCode}');

    if (response.statusCode == 200) {
      print('User deleted successfully');
      // Optionally, you can return a success message or perform other actions
    } else if (response.statusCode == 404) {
      final errorMessage = 'Error deleting user: User ID $userId not found';
      print(errorMessage);
      throw Exception(errorMessage);
    } else {
      print('Error deleting user. Status code: ${response.statusCode}');
      print('Error response body: ${response.body}');
      throw Exception('Failed to delete user');
    }
  } catch (e) {
    print('Error deleting user: $e');
    throw Exception('Failed to delete user');
  }
}
