// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
//
// import '../../../Config/constants.dart';
// import '../../../Services/restaurant/food/updateFoodApi.dart';
// import '../manageFoodPage.dart';
//
// class EditFoodPage extends StatefulWidget {
//   final Map<String, dynamic> foodData;
//
//   EditFoodPage({Key? key, required this.foodData}) : super(key: key);
//
//   @override
//   _EditFoodPageState createState() => _EditFoodPageState();
// }
//
// class _EditFoodPageState extends State<EditFoodPage> {
//   final TextEditingController foodNameController = TextEditingController();
//   final TextEditingController quantityController = TextEditingController();
//   final TextEditingController priceController = TextEditingController();
//   final TextEditingController categoryController = TextEditingController();
//   final TextEditingController imageController = TextEditingController();
//
//   bool isEditing = false;
//   File? imageFile; // Add this property to store the selected image file
//   late String _filename; // Add this property to store the filename
//
//   @override
//   void initState() {
//     super.initState();
//     // Initialize the text fields with food data when the page loads
//     final foodData = widget.foodData['data'];
//     foodNameController.text = foodData['food_name'] ?? '';
//     quantityController.text = foodData['quantity'] ?? '';
//     priceController.text = foodData['price'] ?? '';
//     categoryController.text = foodData['category'] ?? '';
//     //imageController.text = foodData['image'] ?? '';
//   }
//
//   Future<void> editFood() async {
//     // final updatedFoodData = {
//     //   "food_name": foodNameController.text,
//     //   "quantity": quantityController.text,
//     //   "price": priceController.text,
//     //   "category": categoryController.text,
//     //   //"image": imageController.text,
//     // };
//     //print('updatedData : $updatedFoodData');
//     // try {
//     print(widget.foodData['data']['id']);
//     int id = widget.foodData['data']['id'];
//     var uri = Uri.parse(
//         '${ApiConstants.baseUrl}${ApiConstants.foodUpdate}/${id
//             .toString()}/'); // Replace with your API endpoint
//     print("url: $uri");
//     var request = http.MultipartRequest('POST', uri);
//
//     request.fields['food_name'] = foodNameController.text;
//     request.fields['quantity'] = quantityController.text;
//     request.fields['price'] = priceController.text;
//     //request.fields['user_id'] = user_id.toString();
//     request.fields['category'] = categoryController.text;
//
//     print(request.fields);
//     final imageStream = http.ByteStream(imageFile!.openRead());
//     final imageLength = await imageFile!.length();
//
//     final multipartFile = await http.MultipartFile(
//       'image',
//       imageStream,
//       imageLength,
//       filename: imageFile!
//           .path
//           .split('/')
//           .last,
//     );
//     print(imageFile!
//         .path
//         .split('/')
//         .last);
//     request.files.add(multipartFile);
//
//     final response = await request.send();
//     print(response);
//
//     if (response.statusCode == 200) {
//       print('Form submitted successfully');
//       Navigator.push(this.context,
//           MaterialPageRoute(builder: (context) => ManageFoodPage()));
//     } else {
//       print('Error submitting form. Status code: ${response.statusCode}');
//     }
//     // await updateFood(
//     //   widget.foodData['data']['id'].toString(),
//     //   updatedFoodData,
//     // );
//
//     // Pass the updated data back to the previous screen (ResHomePage)
//     // Navigator.pop(context, updatedFoodData);
//     // } catch (e) {
//     //   showDialog(
//     //     context: context,
//     //     builder: (BuildContext context) {
//     //       return AlertDialog(
//     //         title: Text('Update Error'),
//     //         content: Text('Failed to update food data: $e'),
//     //         actions: <Widget>[
//     //           TextButton(
//     //             child: Text('OK'),
//     //             onPressed: () {
//     //               Navigator.of(context).pop(); // Close the dialog
//     //             },
//     //           ),
//     //         ],
//     //       );
//     //     },
//     //   );
//     // }
//   }
//
//   Widget buildTextField({
//     required TextEditingController controller,
//     required IconData icon,
//     required String label,
//   }) {
//     return ListTile(
//       leading: Icon(icon),
//       title: TextFormField(
//         controller: controller,
//         enabled: isEditing,
//         decoration: InputDecoration(
//           border: OutlineInputBorder(
//             borderSide: BorderSide(color: Colors.black),
//           ),
//           labelText: label,
//         ),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Edit Food'),
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
//                     'Edit Food',
//                     style: TextStyle(
//                       fontWeight: FontWeight.w600,
//                       fontSize: 30,
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
//                         if (isEditing)
//                           TextButton(
//                             onPressed: () {
//                               _showImagePickerDialog(context);
//                             },
//                             child: Icon(Icons.add_a_photo),
//                           ),
//                         buildTextField(
//                           controller: foodNameController,
//                           icon: Icons.fastfood,
//                           label: 'Food Name',
//                         ),
//                         buildTextField(
//                           controller: quantityController,
//                           icon: Icons.shopping_cart,
//                           label: 'Quantity',
//                         ),
//                         buildTextField(
//                           controller: priceController,
//                           icon: Icons.money,
//                           label: 'Price',
//                         ),
//                         buildTextField(
//                           controller: categoryController,
//                           icon: Icons.category,
//                           label: 'Category',
//                         ),
//                         // buildTextField(
//                         //   controller: imageController,
//                         //   icon: Icons.image,
//                         // ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 ElevatedButton(
//                   onPressed: () {
//                     setState(() {
//                       isEditing = !isEditing; // Toggle editing mode
//                     });
//                     if (isEditing) {
//                       // You can add any additional actions when switching to edit mode here
//                     } else {
//                       if (_validateForm()) {
//                         print("edited");
//                         // Pass the updated data to the updateFood function
//                         editFood();
//                       }
//                     }
//                   },
//                   child: Text(isEditing ? 'Update' : 'Edit Food'),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   bool _validateForm() {
//     // Implement form validation logic here
//     // Return true if the form data is valid, otherwise return false
//     return true; // Placeholder, replace with actual validation logic
//   }
//
//   @override
//   void dispose() {
//     foodNameController.dispose();
//     quantityController.dispose();
//     priceController.dispose();
//     categoryController.dispose();
//     imageController.dispose();
//     super.dispose();
//   }
//
//   Future<void> _showImagePickerDialog(BuildContext context) {
//     return showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text("Choose an Image"),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               ListTile(
//                 leading: Icon(Icons.camera),
//                 title: Text("Take a Photo"),
//                 onTap: () {
//                   _getFromCamera();
//                   Navigator.pop(context);
//                 },
//               ),
//               ListTile(
//                 leading: Icon(Icons.image),
//                 title: Text("Pick from Gallery"),
//                 onTap: () {
//                   _getFromGallery();
//                   Navigator.pop(context);
//                 },
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   Future<void> _getFromGallery() async {
//     final picker = ImagePicker();
//     try {
//       final pickedFile = await picker.pickImage(
//         source: ImageSource.gallery,
//         maxWidth: 1800,
//         maxHeight: 1800,
//       );
//       if (pickedFile != null) {
//         setState(() {
//           imageFile = File(pickedFile.path);
//           // _filename = basename(imageFile!.path);
//           //  print("file$_filename");
//           //  final _nameWithoutExtension =
//           //      basenameWithoutExtension(imageFile!.path);
//           //  final _extension = extension(imageFile!.path);
//           //  print("imageFile:${imageFile}");
//           //  print(_filename);
//           //  print(_nameWithoutExtension);
//           //  print(_extension);
//         });
//       }
//     } catch (e) {
//       // Handle the exception if something goes wrong
//       print("Error picking image from gallery: $e");
//     }
//   }
//
//   Future<void> _getFromCamera() async {
//     final picker = ImagePicker();
//     try {
//       final pickedFile = await picker.pickImage(
//         source: ImageSource.camera,
//         maxWidth: 1800,
//         maxHeight: 1800,
//       );
//       if (pickedFile != null) {
//         setState(() {
//           imageFile = File(pickedFile.path);
//           // _filename = basename(imageFile!.path).toString();
//           //  final _nameWithoutExtension =
//           //      basenameWithoutExtension(imageFile!.path);
//           //  final _extension = extension(imageFile!.path);
//         });
//       }
//     } catch (e) {
//       // Handle the exception if something goes wrong
//       print("Error picking image from camera: $e");
//     }
//   }
//
//
// }


import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

import '../../../Config/constants.dart';
import '../../../Services/restaurant/food/updateFoodApi.dart';
import '../manageFoodPage.dart';

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

  bool isEditing = false;
  File? imageFile;

  @override
  void initState() {
    super.initState();
    final foodData = widget.foodData['data'];
    foodNameController.text = foodData['food_name'] ?? '';
    quantityController.text = foodData['quantity'] ?? '';
    priceController.text = foodData['price'] ?? '';
    categoryController.text = foodData['category'] ?? '';
  }

  Future<void> editFood() async {
    try {
      int id = widget.foodData['data']['id'];
      var uri = Uri.parse('${ApiConstants.baseUrl}${ApiConstants.foodUpdate}/$id/');
      print('uri  : $uri');
      var request = http.MultipartRequest('POST', uri);

      request.fields['food_name'] = foodNameController.text;
      request.fields['quantity'] = quantityController.text;
      request.fields['price'] = priceController.text;
      request.fields['category'] = categoryController.text;

      print(request.fields);
      if (imageFile != null) {
        final imageStream = http.ByteStream(imageFile!.openRead());
        final imageLength = await imageFile!.length();

        print(imageFile!.path.split('/').last);
        final multipartFile = http.MultipartFile(
          'image',
          imageStream,
          imageLength,
          filename: imageFile!.path.split('/').last,
        );
        request.files.add(multipartFile);
      }
      // print(imageFile!
//         .path
//         .split('/')
//         .last);
//     request.files.add(multipartFile);
      final response = await request.send();

      if (response.statusCode == 200) {
        print('Form submitted successfully');
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ManageFoodPage()),
        );
      } else {
        print('Error submitting form. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error sending request: $e');
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
                        if (isEditing)
                          TextButton(
                            onPressed: () {
                              _showImagePickerDialog(context);
                            },
                            child: Icon(Icons.add_a_photo),
                          ),
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
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isEditing = !isEditing;
                    });
                    if (isEditing) {
                      // Additional actions when switching to edit mode
                    } else {
                      if (_validateForm()) {
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
    return true; // Placeholder, replace with actual validation logic
  }

  Future<void> _showImagePickerDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Choose an Image"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.camera),
                title: Text("Take a Photo"),
                onTap: () {
                  _getFromCamera();
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.image),
                title: Text("Pick from Gallery"),
                onTap: () {
                  _getFromGallery();
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _getFromGallery() async {
    final picker = ImagePicker();
    try {
      final pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1800,
        maxHeight: 1800,
      );
      if (pickedFile != null) {
        setState(() {
          imageFile = File(pickedFile.path);
        });
      }
    } catch (e) {
      print("Error picking image from gallery: $e");
    }
  }

  Future<void> _getFromCamera() async {
    final picker = ImagePicker();
    try {
      final pickedFile = await picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1800,
        maxHeight: 1800,
      );
      if (pickedFile != null) {
        setState(() {
          imageFile = File(pickedFile.path);
        });
      }
    } catch (e) {
      print("Error picking image from camera: $e");
    }
  }


}



//
// Future<void> submitForm( String foodId) async {
//   var prefs = await SharedPreferences.getInstance();
//   //user_id = (prefs.getInt('user_id') ?? 0);
//   var uri = Uri.parse(
//       '${ApiConstants.baseUrl}${ApiConstants.foodUpdate}/$foodId/'); // Replace with your API endpoint
//
//   var request = http.MultipartRequest('POST', uri);
//
//   //request.fields['user_id'] = user_id.toString();
//   request.fields['id'] = foodId;
//   print(request.fields);
//   final imageStream = http.ByteStream(imageFile!.openRead());
//   final imageLength = await imageFile!.length();
//
//   final multipartFile = await http.MultipartFile(
//     'image',
//     imageStream,
//     imageLength,
//     filename: _filename,
//   );
//   print(_filename);
//   request.files.add(multipartFile);
//
//   final response = await request.send();
//   print(response);
//
//   if (response.statusCode == 201) {
//     print('Form submitted successfully');
//     Navigator.push(this.context,
//         MaterialPageRoute(builder: (context) => ManageFoodPage()));
//   } else {
//     print('Error submitting form. Status code: ${response.statusCode}');
//   }
// }

// import 'package:al_dhaher/Pages/restaurantPage/manageFoodPage.dart';
// import 'package:al_dhaher/Services/restaurant/food/updateFoodApi.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:path/path.dart';
//
// import 'dart:io';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../../../Config/constants.dart';
//
// class EditFoodPage extends StatefulWidget {
//   final Map<String, dynamic> foodData;
//
//   EditFoodPage({Key? key, required this.foodData}) : super(key: key);
//
//   @override
//   _EditFoodPageState createState() => _EditFoodPageState();
// }
//
// class _EditFoodPageState extends State<EditFoodPage> {
//   final TextEditingController foodNameController = TextEditingController();
//   final TextEditingController quantityController = TextEditingController();
//   final TextEditingController priceController = TextEditingController();
//   final TextEditingController categoryController = TextEditingController();
//   bool isEditing = false;
//   File? imageFile; // Add this property to store the selected image file
//   late String _filename; // Add this property to store the filename
//
//   @override
//   void initState() {
//     super.initState();
//     final foodData = widget.foodData['data'];
//     foodNameController.text = foodData['food_name'] ?? '';
//     quantityController.text = foodData['quantity'] ?? '';
//     priceController.text = foodData['price'] ?? '';
//     categoryController.text = foodData['category'] ?? '';
//   }
//
//   Future<void> _showImagePickerDialog(BuildContext context) {
//     return showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text("Choose an Image"),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               ListTile(
//                 leading: Icon(Icons.camera),
//                 title: Text("Take a Photo"),
//                 onTap: () {
//                   _getFromCamera();
//                   Navigator.pop(context);
//                 },
//               ),
//               ListTile(
//                 leading: Icon(Icons.image),
//                 title: Text("Pick from Gallery"),
//                 onTap: () {
//                   _getFromGallery();
//                   Navigator.pop(context);
//                 },
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   Future<void> editFood(BuildContext context) async {
//     final updatedFoodData = {
//       "food_name": foodNameController.text,
//       "quantity": quantityController.text,
//       "price": priceController.text,
//       "category": categoryController.text,
//     };
//
//     try {
//       final foodId = widget.foodData['data']['id']; // Extract the food ID from widget data
//       await updateFood(foodId, updatedFoodData); // Pass the food ID and updated data to updateFood function
//       Navigator.pop(context); // Navigate back when editing is successful
//     } catch (e) {
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text('Update Error'),
//             content: Text('Failed to update food data: $e'),
//             actions: <Widget>[
//               TextButton(
//                 child: Text('OK'),
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//               ),
//             ],
//           );
//         },
//       );
//     }
//   }
//
//
//   Future<void> submitForm(int user_id,String foodId) async {
//     var prefs = await SharedPreferences.getInstance();
//     user_id = (prefs.getInt('user_id') ?? 0);
//     var uri = Uri.parse('${ApiConstants.baseUrl}${ApiConstants.foodUpdate}/$foodId/');// Replace with your API endpoint
//
//     var request = http.MultipartRequest('POST', uri);
//
//     request.fields['user_id'] = user_id.toString();
//     request.fields['id'] = foodId;
//     print(request.fields);
//     final imageStream = http.ByteStream(imageFile!.openRead());
//     final imageLength = await imageFile!.length();
//
//     final multipartFile = await http.MultipartFile(
//       'photo', imageStream, imageLength,
//       filename: _filename,
//     );
//     print(_filename);
//     request.files.add(multipartFile);
//
//     final response = await request.send();
//     print(response);
//
//     if (response.statusCode == 201) {
//       print('Form submitted successfully');
//       Navigator.push(
//           this.context, MaterialPageRoute(builder: (context) => ManageFoodPage()));
//     } else {
//       print('Error submitting form. Status code: ${response.statusCode}');
//     }
//   }
//
//
//   Widget buildTextField({
//     required TextEditingController controller,
//     required IconData icon,
//     required String label,
//   }) {
//     return ListTile(
//       leading: Icon(icon),
//       title: TextFormField(
//         controller: controller,
//         enabled: isEditing,
//         decoration: InputDecoration(
//           border: OutlineInputBorder(
//             borderSide: BorderSide(color: Colors.black),
//           ),
//           labelText: label,
//         ),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Edit Food'),
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
//                     'Edit Food',
//                     style: TextStyle(
//                       fontWeight: FontWeight.w600,
//                       fontSize: 30,
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
//                         buildTextField(
//                           controller: foodNameController,
//                           icon: Icons.fastfood,
//                           label: 'Food Name',
//                         ),
//                         buildTextField(
//                           controller: quantityController,
//                           icon: Icons.shopping_cart,
//                           label: 'Quantity',
//                         ),
//                         buildTextField(
//                           controller: priceController,
//                           icon: Icons.money,
//                           label: 'Price',
//                         ),
//                         buildTextField(
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
//                   onPressed: () {
//                     setState(() {
//                       isEditing = !isEditing; // Toggle editing mode
//                     });
//                     if (isEditing) {
//                       // You can add any additional actions when switching to edit mode here
//                     } else {
//                       if (_validateForm()) {
//                         // Pass the updated data to the updateFood function
//                         editFood(BuildContext as BuildContext);
//                       }
//                     }
//                   },
//                   child: Text(isEditing ? 'Update' : 'Edit Food'),
//                 ),
//                 SizedBox(height: 20),
//                 ElevatedButton(
//                   onPressed: () {
//                     _showImagePickerDialog(context);
//                   },
//                   child: Text('Select Image'),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   bool _validateForm() {
//     // Implement form validation logic here
//     return true; // Placeholder, replace with actual validation logic
//   }
//
//   @override
//   void dispose() {
//     foodNameController.dispose();
//     quantityController.dispose();
//     priceController.dispose();
//     categoryController.dispose();
//     super.dispose();
//   }
//

//}
//Future<void> editFood() async {
//     final updatedFoodData = {
//       "food_name": foodNameController.text,
//       "quantity": quantityController.text,
//       "price": priceController.text,
//       "category": categoryController.text,
//       "image": imageController.text,
//     };
//
//     try {
//       await updateFood(
//         widget.foodData['data']['id'].toString(),
//         updatedFoodData,
//       );
//
//       // Pass the updated data back to the previous screen (ResHomePage)
//       Navigator.pop(context, updatedFoodData);
//     } catch (e) {
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text('Update Error'),
//             content: Text('Failed to update food data: $e'),
//             actions: <Widget>[
//               TextButton(
//                 child: Text('OK'),
//                 onPressed: () {
//                   Navigator.of(context).pop(); // Close the dialog
//                 },
//               ),
//             ],
//           );
//         },
//       );
//     }
//   }



//  Future<void> _getFromGallery() async {
//     final picker = ImagePicker();
//     try {
//       final pickedFile = await picker.pickImage(
//         source: ImageSource.gallery,
//         maxWidth: 1800,
//         maxHeight: 1800,
//       );
//       if (pickedFile != null) {
//         setState(() {
//           imageFile = File(pickedFile.path);
//           imageController.text = imageFile!.path.split('/').last; // Set the image file name
//         });
//       }
//     } catch (e) {
//       print("Error picking image from gallery: $e");
//     }
//   }
//
//   Future<void> _getFromCamera() async {
//     final picker = ImagePicker();
//     try {
//       final pickedFile = await picker.pickImage(
//         source: ImageSource.camera,
//         maxWidth: 1800,
//         maxHeight: 1800,
//       );
//       if (pickedFile != null) {
//         setState(() {
//           imageFile = File(pickedFile.path);
//           imageController.text = imageFile!.path.split('/').last; // Set the image file name
//         });
//       }
//     } catch (e) {
//       print("Error picking image from camera: $e");
//     }
//   }