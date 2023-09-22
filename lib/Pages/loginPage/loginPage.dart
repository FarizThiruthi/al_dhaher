import 'package:al_dhaher/Pages/registrationPage/signUpChoice.dart';
import 'package:al_dhaher/Services/user/user_login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String? restaurantId;
  String users = 'user';
  String resto = 'restaurent';
  late SharedPreferences localStorage;

  @override
  void dispose() {
    passwordController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 50),
                Center(
                  child: Text(
                    'Login Here',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 30,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      side: BorderSide(color: Colors.black)),
                  elevation: 3.0,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        ListTile(
                          leading: Icon(Icons.email),
                          title: TextFormField(
                            controller: phoneNumberController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)),
                              labelText: 'Phone number',
                            ),
                          ),
                        ),
                        SizedBox(height: 16.0),
                        // Add spacing between email and password
                        ListTile(
                          leading: Icon(Icons.lock),
                          title: TextFormField(
                            controller: passwordController,
                            obscureText: true, // for password
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)),
                              labelText: 'Password',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    final phoneNumber = phoneNumberController.text; // You can use username for restaurant login
                    final password = passwordController.text;
                    loginUser(
                      phoneNumber: phoneNumber,
                      password: password,
                      restaurantId: restaurantId,
                      context: context,
                    );
                  },
                  child: Text('Login'),
                ),

                // ElevatedButton(
                //   onPressed: () {
                //     //login();
                //     loginUser(
                //         password: passwordController.text,
                //         phoneNumber: phoneNumberController.text,
                //         context: context); // Add your login logic here
                //   },
                //   child: Text('Login'),
                // ),
                SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    // Add your password recovery logic here
                  },
                  child: Text('Forgot Password?'),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account?"),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignUpChoicePage()));
                      },
                      child: Text('Sign Up'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
