import 'package:al_dhaher/Pages/adminPage/adminPage.dart';
import 'package:al_dhaher/Pages/adminPage/manageRestaurantPage.dart';
import 'package:al_dhaher/Pages/adminPage/manageUserPage.dart';
import 'package:al_dhaher/Pages/homePage/homePage.dart';
import 'package:al_dhaher/Pages/registrationPage/signUpChoice.dart';
import 'package:al_dhaher/Pages/restaurantPage/food/addFoodPage.dart';
import 'package:al_dhaher/Pages/restaurantPage/restaurantHomePage.dart';
import 'package:al_dhaher/Pages/restaurantPage/restoRegisterPage.dart';
import 'package:al_dhaher/Pages/user/editUserPage.dart';
import 'package:al_dhaher/splashScreen.dart';
import 'package:al_dhaher/Pages/loginPage/loginPage.dart';
import 'package:al_dhaher/Pages/user/userRegistrationPage.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(MyRestaurantApp());
}

class MyRestaurantApp extends StatelessWidget {
  const MyRestaurantApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(color: Colors.black),
        primaryColor: Colors.black,
        indicatorColor: Colors.black,
        highlightColor: Colors.black,
        hoverColor: Colors.black,
        textTheme: TextTheme(
          // Set text colors to white
          titleLarge: TextStyle(color: Colors.black), // for app bar text
          bodyMedium: TextStyle(color: Colors.black), // for body text
        ),
        inputDecorationTheme: InputDecorationTheme(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red), // Change to your desired color
          ),
          fillColor: Colors.white, // Set the background color of the TextFormField
          filled: true,

        ),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: Colors.black,
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Colors.black, // Change the text color of TextButton
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black, // Change the text color of ElevatedButton
          ),
        ),
        //iconTheme: IconThemeData(color: Colors.green),
      ),


      home: SplashScreen(),
    );
  }
}
