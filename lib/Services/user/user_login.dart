import 'dart:convert';
import 'package:al_dhaher/Config/constants.dart';
import 'package:al_dhaher/Pages/restaurantPage/manageFoodPage.dart';
import 'package:al_dhaher/Services/apiServices.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Model/user/loginModel.dart';
import '../../Pages/homePage/homePage.dart';
import '../../Pages/restaurantPage/restaurantHomePage.dart';


Future<void> loginUser({
  required BuildContext context,
  required String password,
  required String phoneNumber,
  //required String restaurantName,
  String? restaurantId,
}) async {
  final Map<String, dynamic> userData = {
    "password": password,
    "phone": phoneNumber,
  };

  try {
    var response = await Api().authData(userData, ApiConstants.login);
    print('Response Status Code is : ${response.statusCode}');
    print('Response Body: ${response.body}');

    var body = json.decode(response.body);
    print(body);
    if (body['success'] == true) {
      String role = body['data']['role'];

      print('uid = ${body['data']['userid'].runtimeType}.');

      if (role == 'user' || role == 'restaurant') {
        // Save user data to shared preferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('role', role);
        prefs.setString('restoName', body['data']['username']);
        //prefs.setString('phoneNumber', phoneNumber);
        prefs.setInt('userId',body['data']['userid'] );

        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(body['message'])));

        // Redirect to the appropriate page
        if (role == 'user') {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => UserHomePage()));
        } else if (role == 'restaurant') {
          //String restaurantId = body['data']['restaurant_id']; // Extract restaurant ID
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => ManageFoodPage()));
        }
      } else {
        // Handle other roles if needed
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(body['message'])));
    }
  } catch (e) {
    print("JSON Decoding Error: $e");
    throw Exception("Failed to login");
  }
}




// Future<void> loginUser({
//   required BuildContext context,
//   required String password,
//   required String phoneNumber,
// }) async {
//   final Map<String, dynamic> userData = {
//     "password": password,
//     "phone": phoneNumber,
//   };
//
//   try {
//     var response = await Api().authData(userData, ApiConstants.login);
//     var body = json.decode(response.body);
//     print(body);
//     if (body['success'] == true) {
//       String role = body['data']['role'];
//       if (role == 'user' || role == 'restaurant') {
//         // Save user data to shared preferences
//         SharedPreferences prefs = await SharedPreferences.getInstance();
//         prefs.setString('role', role);
//         prefs.setString('phoneNumber', phoneNumber);
//
//         ScaffoldMessenger.of(context)
//             .showSnackBar(SnackBar(content: Text(body['message'])));
//
//         // Redirect to the appropriate page
//         if (role == 'user') {
//           Navigator.pushReplacement(
//               context, MaterialPageRoute(builder: (context) => UserHomePage()));
//         } else if (role == 'restaurant') {
//           Navigator.pushReplacement(
//               context, MaterialPageRoute(builder: (context) =>ManageFoodPage (restaurantId: 'restaurant_id')));
//         }
//       } else {
//         // Handle other roles if needed
//       }
//     } else {
//       ScaffoldMessenger.of(context)
//           .showSnackBar(SnackBar(content: Text(body['message'])));
//     }
//   } catch (e) {
//     print("JSON Decoding Error: $e");
//     throw Exception("Failed to login");
//   }
// }
//
//
//


// Future<LoginModel> loginUser({
//   required BuildContext context, // Pass the context here
//   required String password,
//   required String phoneNumber,
// }) async {
//   final Map<String, dynamic> userData = {
//     "password": password,
//     "phone": phoneNumber,
//   };
//
//   try {
//     var response = await Api().authData(userData, ApiConstants.login);
//     var body = json.decode(response.body);
//     print(body);
//     if (body['success'] == true) {
//       String role = body['data']['role'];
//       if (role == 'user') {
//         ScaffoldMessenger.of(context)
//             .showSnackBar(SnackBar(content: Text(body['message'])));
//         Navigator.pushReplacement(
//             context, MaterialPageRoute(builder: (context) => UserHomePage()));
//       } else if (role == 'restaurant') {
//         ScaffoldMessenger.of(context)
//             .showSnackBar(SnackBar(content: Text(body['message'])));
//         Navigator.pushReplacement(
//             context, MaterialPageRoute(builder: (context) => ResHomePage()));
//        }
//       //else {
//       //   // Handle other roles if needed
//       // }
//     } else {
//       ScaffoldMessenger.of(context)
//           .showSnackBar(SnackBar(content: Text(body['message'])));
//     }
//   } catch (e) {
//     print("JSON Decoding Error: $e");
//     throw Exception("Failed to login");
//   }
//   throw Exception("Failed to login");
// }
