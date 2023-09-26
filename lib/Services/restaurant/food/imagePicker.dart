// import 'package:image_picker/image_picker.dart';
// import 'package:flutter/material.dart';
//
// class ImagePickerDialog extends StatefulWidget {
//   final Function(PickedFile?) onImageSelected;
//
//   ImagePickerDialog({required this.onImageSelected});
//
//   @override
//   _ImagePickerDialogState createState() => _ImagePickerDialogState();
// }
//
// class _ImagePickerDialogState extends State<ImagePickerDialog> {
//   PickedFile? _imageFile;
//
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: Text("Choose an Image"),
//       content: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           if (_imageFile != null)
//             Image.file(
//               File(_imageFile!.path), // Convert PickedFile to File
//               width: 150,
//               height: 150,
//             ),
//           ListTile(
//             leading: Icon(Icons.camera),
//             title: Text("Take a Photo"),
//             onTap: () async {
//               final imageFile = await _getFromCamera();
//               setState(() {
//                 _imageFile = PickedFile(imageFile!.path); // Assign PickedFile directly
//               });
//               widget.onImageSelected(_imageFile); // Pass the PickedFile directly
//               Navigator.pop(context);
//             },
//           ),
//           ListTile(
//             leading: Icon(Icons.image),
//             title: Text("Pick from Gallery"),
//             onTap: () async {
//               final imageFile = await _getFromGallery();
//               setState(() {
//                 _imageFile = PickedFile(imageFile!.path); // Assign PickedFile directly
//               });
//               widget.onImageSelected(_imageFile); // Pass the PickedFile directly
//               Navigator.pop(context);
//             },
//           ),
//         ],
//       ),
//     );
//   }
//
//   Future<PickedFile?> _getFromGallery() async {
//     final picker = ImagePicker();
//     try {
//       final pickedFile = await picker.pickImage(
//         source: ImageSource.gallery,
//         maxWidth: 1800,
//         maxHeight: 1800,
//       );
//       //return pickedFile; // Return the PickedFile
//     } catch (e) {
//       // Handle the exception if something goes wrong
//       print("Error picking image from gallery: $e");
//       return null; // Return null to indicate an error
//     }
//   }
//
//   Future<PickedFile?> _getFromCamera() async {
//     final picker = ImagePicker();
//     try {
//       final pickedFile = await picker.pickImage(
//         source: ImageSource.camera,
//         maxWidth: 1800,
//         maxHeight: 1800,
//       );
//       //return pickedFile; // Return the PickedFile
//     } catch (e) {
//       // Handle the exception if something goes wrong
//       print("Error picking image from camera: $e");
//       return null; // Return null to indicate an error
//     }
//   }
// }
//
//
//
//
// // Future<void> _getFromGallery() async {
// //   final picker = ImagePicker();
// //   try {
// //     final pickedFile = await picker.pickImage(
// //       source: ImageSource.gallery,
// //       maxWidth: 1800,
// //       maxHeight: 1800,
// //     );
// //     if (pickedFile != null) {
// //       setState(() {
// //         imageFile = File(pickedFile.path);
// //         // _filename = basename(imageFile!.path);
// //         //  print("file$_filename");
// //         //  final _nameWithoutExtension =
// //         //      basenameWithoutExtension(imageFile!.path);
// //         //  final _extension = extension(imageFile!.path);
// //         //  print("imageFile:${imageFile}");
// //         //  print(_filename);
// //         //  print(_nameWithoutExtension);
// //         //  print(_extension);
// //       });
// //     }
// //   } catch (e) {
// //     // Handle the exception if something goes wrong
// //     print("Error picking image from gallery: $e");
// //   }
// // }
// //
// // Future<void> _getFromCamera() async {
// //   final picker = ImagePicker();
// //   try {
// //     final pickedFile = await picker.pickImage(
// //       source: ImageSource.camera,
// //       maxWidth: 1800,
// //       maxHeight: 1800,
// //     );
// //     if (pickedFile != null) {
// //       setState(() {
// //         imageFile = File(pickedFile.path);
// //         // _filename = basename(imageFile!.path).toString();
// //         //  final _nameWithoutExtension =
// //         //      basenameWithoutExtension(imageFile!.path);
// //         //  final _extension = extension(imageFile!.path);
// //       });
// //     }
// //   } catch (e) {
// //     // Handle the exception if something goes wrong
// //     print("Error picking image from camera: $e");
// //   }
// // }