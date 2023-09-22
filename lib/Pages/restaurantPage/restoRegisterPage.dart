import 'package:flutter/material.dart';
import '../../Services/restaurant/restoRegisterApi.dart';
import '../loginPage/loginPage.dart';

class RestaurantRegisterPage extends StatefulWidget {
  const RestaurantRegisterPage({Key? key});

  @override
  _RestaurantRegisterPageState createState() => _RestaurantRegisterPageState();
}

class _RestaurantRegisterPageState extends State<RestaurantRegisterPage> {
  final TextEditingController restaurantNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();



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
                    'Restaurant Registration',
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
                        ListTile(
                          leading: Icon(Icons.restaurant),
                          title: TextFormField(
                            controller: restaurantNameController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              labelText: 'Restaurant Name',
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
                          leading: Icon(Icons.phone),
                          title: TextFormField(
                            controller: phoneController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              labelText: 'Phone number',
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
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    registerRestaurant(
                      restaurantName: restaurantNameController.text,
                      email: emailController.text,
                      password: passwordController.text,
                      location: locationController.text,
                      phonenumber: phoneController.text,
                      context: context,
                    );
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
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
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
    restaurantNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    locationController.dispose();
    super.dispose();
  }
}
