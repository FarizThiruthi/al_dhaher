// import 'dart:convert';
// import 'package:al_dhaher/Config/constants.dart';
// import 'package:al_dhaher/Pages/homePage/homePage.dart';
// import 'package:al_dhaher/Services/apiServices.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../../Model/user/registerModel.dart';
//
//
// Future<Registermodel> registerUser({
//   required BuildContext context,
//   required String fullName,
//   required String email,
//   required String password,
//   required String username,
//   required String phoneNumber,
//   required String location,
//   required String pin,
// }) async {
//   final Map<String, dynamic> userData = {
//     "name": fullName,
//     "mailid": email,
//     "password": password,
//     "phonenumber": phoneNumber,
//     "location": location,
//     "pincode": pin,
//     // Add other fields if needed
//   };
//
//   try {
//     var response = await Api().authData(userData, ApiConstants.register);
//     var body = json.decode(response.body);
//     print(body);
//
//     if (body['success'] == true) {
//       final message = body['message'] as String;
//
//       final prefs = await SharedPreferences.getInstance();
//       prefs.setString('userRole', 'user'); // Change 'user' to the actual role if needed
//       prefs.setString('userPhoneNumber', phoneNumber);
//       prefs.setString('userToken', 'yourAuthTokenHere'); // Replace with the actual authentication token
//
//
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
//       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => UserHomePage()));
//       return Registermodel.fromJson(body['data']); // Return the parsed data if needed
//     } else {
//       final message = body['message'] as String;
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
//     }
//   } catch (e) {
//     print("JSON Decoding Error: $e");
//     final errorMessage = "Failed to register user";
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(errorMessage)));
//     throw Exception(errorMessage);
//   }
//
//   throw Exception("Failed to register user");
// }
//
//
//

import 'dart:convert';
import 'package:al_dhaher/Config/constants.dart';
import 'package:al_dhaher/Services/apiServices.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Pages/homePage/homePage.dart';

Future<void> registerUser({
  required BuildContext context,
  required String fullName,
  required String email,
  required String password,
  required String username,
  required String phoneNumber,
  required String location,
  required String pin,
  //required int userId,
}) async {
  final Map<String, dynamic> userData = {
    "name": fullName,
    "mailid": email,
    "password": password,
    "phonenumber": phoneNumber,
    "location": location,
    "pincode": pin,
  };

  try {
    var response = await Api().authData(userData, ApiConstants.register);
    var body = json.decode(response.body);
    print(body);

    if (body['success'] == true) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(body['message'])));

      // Save user data to shared preferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('role', 'user'); // Set the user role
      prefs.setString('phoneNumber', phoneNumber);

      // Redirect to the UserHomePage
      // Navigator.pushReplacement(
      //     context, MaterialPageRoute(builder: (context) => UserHomePage(userId: userId)));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(body['message'])));
    }
  } catch (e) {
    print("JSON Decoding Error: $e");
    throw Exception("Failed to register user");
  }
}
