// import 'package:al_dhaher/Services/restaurant/food/addFoodAPI.dart';
// import 'package:flutter/material.dart';
//
// class AddFoodPage extends StatefulWidget {
//   @override
//   _AddFoodPageState createState() => _AddFoodPageState();
// }
//
// class _AddFoodPageState extends State<AddFoodPage> {
//   // Controllers for text form fields
//   final TextEditingController foodNameController = TextEditingController();
//   final TextEditingController quantityController = TextEditingController();
//   final TextEditingController priceController = TextEditingController();
//   final TextEditingController categoryController = TextEditingController();
//   final TextEditingController restoIdController = TextEditingController();
//
//   @override
//   void dispose() {
//     foodNameController.dispose();
//     quantityController.dispose();
//     priceController.dispose();
//     categoryController.dispose();
//     restoIdController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Add Food'),
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(20.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 SizedBox(height: 20),
//                 Center(
//                   child: Text(
//                     'Add Food',
//                     style: TextStyle(
//                       fontWeight: FontWeight.w600,
//                       fontSize: 30,
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 // Circular Avatar for Image
//                 GestureDetector(
//                   onTap: () {
//                     // Implement image selection logic here
//                   },
//                   child: CircleAvatar(
//                     radius: 50,
//                     backgroundColor: Colors.grey[300],
//                     child: Icon(
//                       Icons.add_photo_alternate,
//                       size: 40,
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 Card(
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(15.0),
//                     side: BorderSide(color: Colors.black),
//                   ),
//                   elevation: 3.0,
//                   child: Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Column(
//                       children: [
//                         _buildTextField(
//                           controller: restoIdController,
//                           icon: Icons.password,
//                           label: 'Restaurant Id',
//                         ),
//                         _buildTextField(
//                           controller: foodNameController,
//                           icon: Icons.fastfood,
//                           label: 'Food Name',
//                         ),
//                         _buildTextField(
//                           controller: quantityController,
//                           icon: Icons.shopping_cart,
//                           label: 'Quantity',
//                         ),
//                         _buildTextField(
//                           controller: priceController,
//                           icon: Icons.money,
//                           label: 'Price',
//                         ),
//                         _buildTextField(
//                           controller: categoryController,
//                           icon: Icons.category,
//                           label: 'Category',
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 ElevatedButton(
//                   onPressed: () async {
//                     try {
//                       final result = await createFood(
//                         restaurantId: restoIdController.text,
//                         foodName: foodNameController.text,
//                         quantity: quantityController.text,
//                         price: priceController.text,
//                         category: categoryController.text,
//                       );
//
//                       // Check if the result is not null or handle it accordingly
//                       if (result != null) {
//                         // Food added successfully, navigate back to ManageFoodPage
//                         Navigator.pop(context);
//                       }
//                     } catch (e) {
//                       // Handle any errors here
//                       print('Error: $e');
//                     }
//                   },
//                   child: Text('Add Food'),
//                 ),
//
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildTextField({
//     required TextEditingController controller,
//     required IconData icon,
//     required String label,
//   }) {
//     return ListTile(
//       leading: Icon(icon),
//       title: TextFormField(
//         controller: controller,
//         decoration: InputDecoration(
//           border: OutlineInputBorder(
//             borderSide: BorderSide(color: Colors.black),
//           ),
//           labelText: label,
//         ),
//       ),
//     );
//   }
// }

import 'package:al_dhaher/Services/restaurant/food/addFoodAPI.dart';
import 'package:flutter/material.dart';

class AddFoodPage extends StatefulWidget {
  final void Function() refreshCallback;

  AddFoodPage({Key? key, required this.refreshCallback}) : super(key: key);

  @override
  _AddFoodPageState createState() => _AddFoodPageState();
}

class _AddFoodPageState extends State<AddFoodPage> {
  final TextEditingController foodNameController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController restoIdController = TextEditingController();

  @override
  void dispose() {
    foodNameController.dispose();
    quantityController.dispose();
    priceController.dispose();
    categoryController.dispose();
    restoIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Food'),
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
                    'Add Food',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 30,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    // Implement image selection logic here
                  },
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey[300],
                    child: Icon(
                      Icons.add_photo_alternate,
                      size: 40,
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
                        _buildTextField(
                          controller: restoIdController,
                          icon: Icons.restaurant,
                          label: 'Restaurant Id',
                        ),
                        _buildTextField(
                          controller: foodNameController,
                          icon: Icons.fastfood,
                          label: 'Food Name',
                        ),
                        _buildTextField(
                          controller: quantityController,
                          icon: Icons.shopping_cart,
                          label: 'Quantity',
                        ),
                        _buildTextField(
                          controller: priceController,
                          icon: Icons.money,
                          label: 'Price',
                        ),
                        _buildTextField(
                          controller: categoryController,
                          icon: Icons.category,
                          label: 'Category',
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      final result = await createFood(
                        restaurantId: restoIdController.text,
                        foodName: foodNameController.text,
                        quantity: quantityController.text,
                        price: priceController.text,
                        category: categoryController.text,
                      );

                      if (result != null) {
                        // Food added successfully, call the callback to refresh the list
                        widget.refreshCallback();
                        Navigator.pop(context);
                      }
                    } catch (e) {
                      // Handle any errors here
                      print('Error: $e');
                    }
                  },
                  child: Text('Add Food'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required IconData icon,
    required String label,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          labelText: label,
        ),
      ),
    );
  }
}
