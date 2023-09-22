import 'dart:convert';
import 'package:al_dhaher/Pages/restaurantPage/manageFoodPage.dart';
import 'package:flutter/material.dart';
import '../../Config/constants.dart';
import '../../Model/restaurant/restoLoginModel.dart';
import '../../Pages/restaurantPage/restaurantHomePage.dart';
import '../apiServices.dart';

Future<RestoLoginModel> loginResto({
  required BuildContext context, // Pass the context here
  required String password,
  required String username, // Replace with the actual field name
}) async {
  final Map<String, dynamic> userData = {
    "password": password,
    "username": username, // Replace with the actual field name
    // Add other fields if needed
  };

  try {
    var response = await Api().authData(userData, ApiConstants.login); // Replace with the actual endpoint
    var body = json.decode(response.body);
    print(body);
    if (body['success'] == true) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ManageFoodPage()), // Replace with the actual page
      );
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(body['message'])));
    }
  } catch (e) {
    print("JSON Decoding Error: $e");
    throw Exception("Failed to login restaurant");
  }
  throw Exception("Failed to login restaurant");
}
