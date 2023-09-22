import 'package:flutter/material.dart';
import '../../Services/user/user_register.dart';
import '../homePage/homePage.dart';
import '../loginPage/loginPage.dart'; // Import your registration function and other dependencies here

class UserRegisterPage extends StatefulWidget {
  const UserRegisterPage({Key? key});

  @override
  _UserRegisterPageState createState() => _UserRegisterPageState();
}

class _UserRegisterPageState extends State<UserRegisterPage> {
  // Add text editing controllers for the form fields
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController pinController = TextEditingController();

  // Function to handle user registration
  // Future<void> register() async {
  //   try {
  //     final response = await registerUser(
  //       fullName: fullNameController.text,
  //       email: emailController.text,
  //       password: passwordController.text,
  //       username: usernameController.text,
  //       phoneNumber: phoneNumberController.text,
  //       location: locationController.text,
  //       pin: pinController.text,
  //       context: context,
  //     );
  //
  //     if (response.success == true) {
  //       // Registration successful, you can navigate to the next screen or take other actions
  //       print('Registration successful!');
  //       Navigator.pushReplacement(context,
  //           MaterialPageRoute(builder: (context) => UserHomePage()));
  //     } else {
  //       // Registration failed, show an error message or handle it accordingly
  //       print('Registration failed: ${response.message}');
  //     }
  //   } catch (e) {
  //     // Handle any exceptions that occur during registration
  //     print('Error during registration: $e');
  //   }
  // }

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
                Center(
                  child: Text(
                    'Register Here',
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
                    side: BorderSide(color: Colors.black),
                  ),
                  elevation: 3.0,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        // Use text editing controllers for form fields
                        ListTile(
                          leading: Icon(Icons.person),
                          title: TextFormField(
                            controller: fullNameController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              labelText: 'Full Name',
                            ),
                          ),
                        ),
                        SizedBox(height: 16.0),
                        ListTile(
                          leading: Icon(Icons.email),
                          title: TextFormField(
                            controller: emailController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              labelText: 'Email',
                            ),
                          ),
                        ),
                        SizedBox(height: 16.0),
                        ListTile(
                          leading: Icon(Icons.lock),
                          title: TextFormField(
                            controller: passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              labelText: 'Password',
                            ),
                          ),
                        ),
                        SizedBox(height: 16.0),
                        ListTile(
                          leading: Icon(Icons.person),
                          title: TextFormField(
                            controller: usernameController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              labelText: 'Username',
                            ),
                          ),
                        ),
                        SizedBox(height: 16.0),
                        ListTile(
                          leading: Icon(Icons.phone),
                          title: TextFormField(
                            controller: phoneNumberController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              labelText: 'Phone Number',
                            ),
                          ),
                        ),
                        SizedBox(height: 16.0),
                        ListTile(
                          leading: Icon(Icons.location_on),
                          title: TextFormField(
                            controller: locationController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              labelText: 'Location',
                            ),
                          ),
                        ),
                        SizedBox(height: 16.0),
                        ListTile(
                          leading: Icon(Icons.pin),
                          title: TextFormField(
                            controller: pinController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              labelText: 'Pin',
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
                    registerUser(
                        fullName: fullNameController.text,
                        email: emailController.text,
                        password: passwordController.text,
                        username: usernameController.text,
                        phoneNumber: phoneNumberController.text,
                        location: locationController.text,
                        pin: pinController.text,
                        context: context);
                    //register();
                  },
                  child: Text('Register'),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account?"),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()));
                      },
                      child: Text('Login'),
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

  @override
  void dispose() {
    // Dispose of text editing controllers when the widget is disposed
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    usernameController.dispose();
    phoneNumberController.dispose();
    locationController.dispose();
    pinController.dispose();
    super.dispose();
  }
}
