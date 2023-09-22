import 'package:al_dhaher/Pages/loginPage/loginPage.dart';
import 'package:al_dhaher/Pages/registrationPage/signUpChoice.dart';
import 'package:al_dhaher/Pages/restaurantPage/manageFoodPage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Pages/homePage/homePage.dart';
import 'Pages/restaurantPage/restaurantHomePage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? restaurantId;

  @override
  void initState() {
    super.initState();
    _navigateToAppropriatePage();
  }

  Future<void> _navigateToAppropriatePage() async {
    await Future.delayed(Duration(seconds: 3));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? role = prefs.getString('role');

    if (role == 'user') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => UserHomePage()),
      );
    } else if (role == 'restaurant') {
      restaurantId = prefs.getString('restaurant_id');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ManageFoodPage()),
       // MaterialPageRoute(builder: (context) => ResHomePage(restaurantId: 'restaurant_id',)),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image(
              image: AssetImage('lib/Images/LogoRes.gif'),
              fit: BoxFit.fitHeight,
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Center( // Center the row
          //     child: Row(
          //       crossAxisAlignment: CrossAxisAlignment.center,
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: [
          //         Expanded(
          //           child: AspectRatio(
          //             aspectRatio: 1.6,
          //             child: GestureDetector(
          //               onTap: () {
          //                 Navigator.push(
          //                   context,
          //                   MaterialPageRoute(builder: (context) => LoginPage()),
          //                 );
          //               },
          //               child: Card(
          //                 shape: RoundedRectangleBorder(
          //                   borderRadius: BorderRadius.circular(15.0),
          //                   side: BorderSide(color: Colors.black),
          //                 ),
          //                 elevation: 10,
          //                 child: Column(
          //                   mainAxisAlignment: MainAxisAlignment.center,
          //                   children: [
          //                     Icon(Icons.login),
          //                     SizedBox(height: 5),
          //                     Text('Login'),
          //                   ],
          //                 ),
          //               ),
          //             ),
          //           ),
          //         ),
          //         SizedBox(width: 25), // Add spacing between buttons
          //         Expanded(
          //           child: AspectRatio(
          //             aspectRatio: 1.6,
          //             child: GestureDetector(
          //               onTap: () {
          //                 Navigator.push(
          //                   context,
          //                   MaterialPageRoute(builder: (context) => SignUpChoicePage()),
          //                 );
          //               },
          //               child: Card(
          //                 shape: RoundedRectangleBorder(
          //                   borderRadius: BorderRadius.circular(15.0),
          //                   side: BorderSide(color: Colors.black),
          //                 ),
          //                 elevation: 10,
          //                 child: Column(
          //                   mainAxisAlignment: MainAxisAlignment.center,
          //                   children: [
          //                     Icon(Icons.person_add),
          //                     SizedBox(height: 5),
          //                     Text('Sign Up'),
          //                   ],
          //                 ),
          //               ),
          //             ),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
