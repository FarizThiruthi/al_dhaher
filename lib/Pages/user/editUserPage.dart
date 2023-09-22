import 'package:flutter/material.dart';
import '../../Services/user/edit_user.dart';

class EditProfilePage extends StatefulWidget {
  final Map<String, dynamic> userData;

  EditProfilePage({Key? key, required this.userData}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController pinController = TextEditingController();

  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    // Initialize the text fields with user data when the page loads
    final userData = widget.userData['data'];
    fullNameController.text = userData['name'] ?? '';
    emailController.text = userData['mailid'] ?? '';
    passwordController.text = userData['password'] ?? '';
    usernameController.text = userData['name'] ?? '';
    phoneNumberController.text = userData['phonenumber'] ?? '';
    locationController.text = userData['location'] ?? '';
    pinController.text = userData['pincode'] ?? '';
  }

  Future<void> updateProfile() async {
    final updatedUserData = {
      "name": fullNameController.text,
      "mailid": emailController.text,
      "password": passwordController.text,
      "username": usernameController.text,
      "phonenumber": phoneNumberController.text,
      "location": locationController.text,
      "pin": pinController.text,
    };

    try {
      await updateUser(widget.userData['data']['id'].toString(), updatedUserData);

      // Pass the updated data back to the previous screen (ManageUserPage)
      Navigator.pop(context, updatedUserData);
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Update Error'),
            content: Text('Failed to update user data: $e'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
              ),
            ],
          );
        },
      );
    }
  }

  Widget buildTextField({
    required TextEditingController controller,
    required IconData icon,
    required String label,
    bool isPassword = false,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: TextFormField(
        controller: controller,
        enabled: isEditing,
        obscureText: isPassword,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          labelText: label,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                Center(
                  child: Text(
                    'Edit Profile',
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
                        buildTextField(
                          controller: fullNameController,
                          icon: Icons.person,
                          label: 'Full Name',
                        ),
                        buildTextField(
                          controller: emailController,
                          icon: Icons.email,
                          label: 'Email',
                        ),
                        buildTextField(
                          controller: passwordController,
                          icon: Icons.lock,
                          label: 'Password',
                          isPassword: true,
                        ),
                        buildTextField(
                          controller: usernameController,
                          icon: Icons.person,
                          label: 'Username',
                        ),
                        buildTextField(
                          controller: phoneNumberController,
                          icon: Icons.phone,
                          label: 'Phone Number',
                        ),
                        buildTextField(
                          controller: locationController,
                          icon: Icons.location_on,
                          label: 'Location',
                        ),
                        buildTextField(
                          controller: pinController,
                          icon: Icons.pin,
                          label: 'Pin',
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isEditing = !isEditing; // Toggle editing mode
                    });
                    if (isEditing) {
                    } else {
                      if (_validateForm()) {
                        updateProfile();
                      }
                    }
                  },
                  child: Text(isEditing ? 'Update' : 'Edit Profile'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool _validateForm() {
    // Implement form validation logic here
    // Return true if the form data is valid, otherwise return false
    return true; // Placeholder, replace with actual validation logic
  }

  @override
  void dispose() {
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
