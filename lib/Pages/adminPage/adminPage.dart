import 'package:al_dhaher/Pages/loginPage/loginPage.dart';
import 'package:flutter/material.dart';
import 'manageRestaurantPage.dart';
import 'manageUserPage.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text('Admin Home'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
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
                          leading: Icon(Icons.assignment),
                          title: Text('Manage Users'),
                          subtitle: Text('View and manage user accounts'),
                          onTap: () {
                            // Navigate to the user management page
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ManageUserPage(),
                              ),
                            );
                          },
                        ),
                        Divider(),
                        ListTile(
                          leading: Icon(Icons.restaurant),
                          title: Text('Manage Restaurants'),
                          subtitle: Text('View and manage restaurant listings'),
                          onTap: () {
                            // Navigate to the restaurant management page
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ManageRestaurantPage(),
                              ),
                            );
                          },
                        ),
                        Divider(),
                        ListTile(
                          leading: Icon(Icons.settings),
                          title: Text('Settings'),
                          subtitle: Text('Configure application settings'),
                          onTap: () {
                            // Navigate to the settings page
                            // Replace `SettingsPage` with the actual settings page
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Show a confirmation dialog before signing out
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Sign Out Confirmation'),
                          content: Text('Are you sure you want to sign out?'),
                          actions: <Widget>[
                            TextButton(
                              child: Text('Cancel'),
                              onPressed: () {
                                Navigator.of(context).pop(); // Close the dialog
                              },
                            ),
                            TextButton(
                              child: Text('OK'),
                              onPressed: () {
                                // Navigate to the login page
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LoginPage(),
                                  ),
                                      (route) => false, // Remove all existing routes
                                );
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Text('Sign Out'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
