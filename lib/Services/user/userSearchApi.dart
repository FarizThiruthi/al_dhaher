import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../Config/constants.dart';
import '../../Model/user/userSearchModel.dart';


Future<List<Data>> searchUsers(String query) async {
  try {
    final response = await http.post(
      Uri.parse('${ApiConstants.baseUrl}${ApiConstants.searchUser}'),
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
      final List<Data> userList = (responseData['data'] as List)
          .map((item) => Data.fromJson(item))
          .toList();
      return userList;
    } else {
      print('Error searching users. Status code: ${response.statusCode}');
      print('Error response body: ${response.body}');
      throw Exception('Failed to search users');
    }
  } catch (e) {
    print('Error searching users: $e');
    throw Exception('Failed to search users');
  }
}
