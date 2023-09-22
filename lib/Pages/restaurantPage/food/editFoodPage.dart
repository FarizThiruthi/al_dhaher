import 'package:flutter/material.dart';

import '../../../Services/restaurant/food/updateFoodApi.dart';


class EditFoodPage extends StatefulWidget {
  final Map<String, dynamic> foodData;

  EditFoodPage({Key? key, required this.foodData}) : super(key: key);

  @override
  _EditFoodPageState createState() => _EditFoodPageState();
}

class _EditFoodPageState extends State<EditFoodPage> {
  final TextEditingController foodNameController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  // final TextEditingController imageController = TextEditingController();

  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    // Initialize the text fields with food data when the page loads
    final foodData = widget.foodData['data'];
    foodNameController.text = foodData['food_name'] ?? '';
    quantityController.text = foodData['quantity'] ?? '';
    priceController.text = foodData['price'] ?? '';
    categoryController.text = foodData['category'] ?? '';
    // imageController.text = foodData['image'] ?? '';
  }

  Future<void> editFood() async {
    final updatedFoodData = {
      "food_name": foodNameController.text,
      "quantity": quantityController.text,
      "price": priceController.text,
      "category": categoryController.text,
      // "image": imageController.text,
    };
print('updatedData : $updatedFoodData');
    try {
      await updateFood(widget.foodData['data']['id'].toString(), updatedFoodData,);

      // Pass the updated data back to the previous screen (ResHomePage)
      Navigator.pop(context, updatedFoodData);
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Update Error'),
            content: Text('Failed to update food data: $e'),
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
        title: Text('Edit Food'),
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
                    'Edit Food',
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
                          controller: foodNameController,
                          icon: Icons.fastfood,
                          label: 'Food Name',
                        ),
                        buildTextField(
                          controller: quantityController,
                          icon: Icons.shopping_cart,
                          label: 'Quantity',
                        ),
                        buildTextField(
                          controller: priceController,
                          icon: Icons.money,
                          label: 'Price',
                        ),
                        buildTextField(
                          controller: categoryController,
                          icon: Icons.category,
                          label: 'Category',
                        ),
                        // buildTextField(
                        //   controller: imageController,
                        //   icon: Icons.image,
                        //   label: 'Image URL',
                        // ),
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
                      // You can add any additional actions when switching to edit mode here
                    } else {
                      if (_validateForm()) {
                        // Pass the updated data to the updateFood function
                        editFood();
                      }
                    }
                  },
                  child: Text(isEditing ? 'Update' : 'Edit Food'),
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
    foodNameController.dispose();
    quantityController.dispose();
    priceController.dispose();
    categoryController.dispose();
    // imageController.dispose();
    super.dispose();
  }
}
