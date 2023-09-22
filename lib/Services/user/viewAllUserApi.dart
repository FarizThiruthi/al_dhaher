import 'dart:convert';
import 'package:al_dhaher/Config/constants.dart';
import 'package:http/http.dart' as http;
import '../../Model/user/viewAllUserModel.dart';

Future<ViewAllUserModel?> getAllUsers(String baseUrl) async {
  try {
    final response = await http.get(Uri.parse(baseUrl + ApiConstants.allUser));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      return ViewAllUserModel.fromJson(jsonResponse);
    } else {
      print('API Error: ${response.statusCode}');
      print('Response Body: ${response.body}');
      throw Exception('Failed to load users');
    }
  } catch (e) {
    print('Error: $e');
    throw Exception('Failed to load users');
  }
}
