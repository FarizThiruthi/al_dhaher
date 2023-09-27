import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../../../Config/constants.dart';


Future<Map<String, dynamic>> updateFood2(String foodId, Map<String, dynamic> foodData, File? imageFile) async {
  try {
    final request = http.MultipartRequest(
      'PUT',
      Uri.parse('${ApiConstants.baseUrl}${ApiConstants.foodUpdate}/$foodId/'),
    );

    // Add the image file to the request if it's provided
    if (imageFile != null) {
      final imageStream = http.ByteStream(imageFile.openRead());
      final imageLength = await imageFile.length();
      final imageFileName = imageFile.path.split('/').last;

      final imageMultipartFile = http.MultipartFile(
        'image',
        imageStream,
        imageLength,
        filename: imageFileName,
      );

      request.files.add(imageMultipartFile);
    }

    // Add other data fields to the request
    for (var entry in foodData.entries) {
      request.fields[entry.key] = entry.value.toString();
    }


    final response = await request.send();
    //final responseBody = await response.stream.bytesToString();
    //print('Response Body first: $responseBody');

    print('Request URL: ${response.request?.url}');
    print('Request Headers: ${response.request?.headers}');
    print('Response Status Code: ${response.statusCode}');

    if (response.statusCode == 200) {
      final responseBody = await response.stream.bytesToString();
      final Map<String, dynamic> updatedFoodData = json.decode(responseBody);
      print('Food updated successfully');
      return updatedFoodData;
    } else if (response.statusCode == 404) {
      final errorMessage = 'Error updating food: Food ID $foodId not found';
      print(errorMessage);
      throw Exception(errorMessage);
    } else if (response.statusCode == 400) {
      final errorMessage = 'Error updating food: ${await response.stream.bytesToString()}';
      print(errorMessage);
      throw Exception(errorMessage);
    } else {
      final errorMessage = 'Error updating food. Status code: ${response.statusCode}';
      print(errorMessage);
      throw Exception(errorMessage);
    }
  } catch (e) {
    print('Error updating food: $e');
    throw Exception('Failed to update food');
  }
}
