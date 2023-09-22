import 'package:flutter/material.dart';

import '../../Services/restaurant/restaurantUpdateApi.dart';

class EditRestaurantPage extends StatefulWidget {
  final Map<String, dynamic> restaurantData;

  EditRestaurantPage({Key? key, required this.restaurantData}) : super(key: key);

  @override
  _EditRestaurantPageState createState() => _EditRestaurantPageState();
}

class _EditRestaurantPageState extends State<EditRestaurantPage> {
  final TextEditingController restaurantNameController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController imageUrlController = TextEditingController();

  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    // Initialize the text fields with restaurant data when the page loads
    final restaurantData = widget.restaurantData['data'];
    restaurantNameController.text = restaurantData['name'] ?? '';
    locationController.text = restaurantData['location'] ?? '';
    phoneNumberController.text = restaurantData['phonenumber'] ?? '';
    imageUrlController.text = restaurantData['imageUrl'] ?? '';
  }

  Future<void> updateRestaurant() async {
    final updatedRestaurantData = {
      "name": restaurantNameController.text,
      "location": locationController.text,
      "phonenumber": phoneNumberController.text,
      "imageUrl": imageUrlController.text,
    };

    try {
      // Call your update restaurant API here and pass the updated data
       await updateRestaurantData(widget.restaurantData['data']['id'].toString(), updatedRestaurantData);

      // Pass the updated data back to the previous screen (ManageRestaurantPage)
      Navigator.pop(context, updatedRestaurantData);
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Update Error'),
            content: Text('Failed to update restaurant data: $e'),
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
  }) {
    return ListTile(
      leading: Icon(icon),
      title: TextFormField(
        controller: controller,
        enabled: isEditing,
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
        title: Text('Edit Restaurant'),
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
                    'Edit Restaurant',
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
                          controller: restaurantNameController,
                          icon: Icons.restaurant,
                          label: 'Restaurant Name',
                        ),
                        buildTextField(
                          controller: locationController,
                          icon: Icons.location_on,
                          label: 'Location',
                        ),
                        buildTextField(
                          controller: phoneNumberController,
                          icon: Icons.phone,
                          label: 'Phone Number',
                        ),
                        buildTextField(
                          controller: imageUrlController,
                          icon: Icons.image,
                          label: 'Image URL',
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
                      // When entering editing mode, clear any validation errors
                      // or messages from previous submissions.
                    } else {
                      // When exiting editing mode, validate the form data
                      // and submit the changes if valid.
                      if (_validateForm()) {
                        updateRestaurant();
                      }
                    }
                  },
                  child: Text(isEditing ? 'Update' : 'Edit Restaurant'),
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
    restaurantNameController.dispose();
    locationController.dispose();
    phoneNumberController.dispose();
    imageUrlController.dispose();
    super.dispose();
  }
}
