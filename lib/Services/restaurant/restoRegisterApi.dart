import 'dart:convert';
import 'package:al_dhaher/Config/constants.dart';
import 'package:al_dhaher/Pages/restaurantPage/manageFoodPage.dart';
import 'package:al_dhaher/Services/apiServices.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Model/restaurant/restoRgisterModel.dart';
import '../../Pages/restaurantPage/restaurantHomePage.dart';

Future<RestoRegisterModel> registerRestaurant({
  required BuildContext context,
  required String restaurantName,
  required String email,
  required String password,
  required String location,
  required String phonenumber,
}) async {
  final Map<String, dynamic> restaurantData = {
    "name": restaurantName,
    "mailid": email,
    "password": password,
    "location": location,
    'phonenumber': phonenumber,
  };

  try {
    var response = await Api().authData(restaurantData, ApiConstants.restoRegister);
    var body = json.decode(response.body);
    print(body);
    if (body['success'] == true) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(body['message'])));

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('role', 'restaurant'); // Set the user role
      prefs.setString('phonenumber', phonenumber);

      String restaurantId = body['data']['restaurantId'];
      // Create an instance of RestoRegisterModel and return it
      RestoRegisterModel restoRegisterModel = RestoRegisterModel(
        // Initialize the fields of the model with relevant data
        restaurantId: restaurantId,
        // You can add other fields here as needed
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ManageFoodPage()),
      );

      return restoRegisterModel; // Return the RestoRegisterModel instance
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(body['message'])));
    }
    return RestoRegisterModel.fromJson(jsonDecode(response.body));
  } catch (e) {
    print("JSON Decoding Error: $e");
    throw Exception("Failed to register restaurant");
  }
}


// Future<RestoRegisterModel> registerRestaurant({
//   required BuildContext context,
//   required String restaurantName,
//   required String email,
//   required String password,
//   required String location,
//   required String phonenumber,
//
// }) async {
//   final Map<String, dynamic> restaurantData = {
//     "name": restaurantName,
//     "mailid": email,
//     "password": password,
//     "location": location,
//     'phonenumber': phonenumber,
//
//   };
//
//   try {
//     var response =
//     await Api().authData(restaurantData, ApiConstants.restoRegister);
//     var body = json.decode(response.body);
//     print(body);
//     if (body['success'] == true) {
//       ScaffoldMessenger.of(context)
//           .showSnackBar(SnackBar(content: Text(body['message'])));
//
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       prefs.setString('role', 'restaurant'); // Set the user role
//       prefs.setString('phonenumber', phonenumber);
//
//
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => ResHomePage()),
//       );
//       String restaurantId = body['data']['restaurantId'];
//       return restaurantId;
//     } else {
//       ScaffoldMessenger.of(context)
//           .showSnackBar(SnackBar(content: Text(body['message'])));
//     }
//     return RestoRegisterModel.fromJson(jsonDecode(response.body));
//   } catch (e) {
//     print("JSON Decoding Error: $e");
//     throw Exception("Failed to register restaurant");
//   }
// }
