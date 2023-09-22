// import 'package:al_dhaher/Pages/restaurantPage/searchRestoPage.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../../Config/constants.dart';
// import '../../Model/restaurant/food/allFoodRestaurantModel.dart'
//     as AllFoodRestaurantModel;
// import '../../Services/restaurant/food/allFoodRestaurantApi.dart' as datas;
// import '../../Services/restaurant/food/deleteFoodApi.dart';
// import '../../Services/restaurant/food/foodSearchApi.dart';
// import '../../Services/restaurant/food/updateFoodApi.dart';
// import '../loginPage/loginPage.dart';
// import 'food/editFoodPage.dart';
// //
// // class ResHomePage extends StatefulWidget {
// //   final String restaurantId;
// //
// //   ResHomePage({Key? key, required this.restaurantId}) : super(key: key);
// //
// //   @override
// //   State<ResHomePage> createState() => _ResHomePageState();
// // }
// //
// // class _ResHomePageState extends State<ResHomePage> {
// //   List<AllFoodRestaurantModel.Data> foodList = [];
// //   final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
// //       GlobalKey<RefreshIndicatorState>();
// //
// //   void getRestaurantFoods() async {
// //     try {
// //       final AllFoodRestaurantModel.AllFoodRestaurantModel? restaurantFoods =
// //           await datas.getAllRestaurantFoods(
// //               ApiConstants.baseUrl, widget.restaurantId);
// //
// //       if (restaurantFoods != null) {
// //         setState(() {
// //           foodList = restaurantFoods.data ?? [];
// //         });
// //       }
// //     } catch (e) {
// //       print('Error loading restaurant foods: $e');
// //     }
// //   }
// //
// //   void editFood(BuildContext context, int foodId) async {
// //     try {
// //       // Fetch food data
// //       Map<String, dynamic> foodData = await updateFood(foodId: foodId, data: {}); // Use named arguments
// //       // Rest of your code...
// //       // Navigate to the EditFoodPage and pass the food data
// //       final updatedFoodData = await Navigator.push(
// //         context,
// //         MaterialPageRoute(
// //           builder: (context) => EditFoodPage(foodData: foodData),
// //         ),
// //       );
// //
// //       // Handle the updatedFoodData as needed (e.g., update the UI)
// //       if (updatedFoodData != null) {
// //         print("Updated food data received: $updatedFoodData");
// //         // You can update the UI or perform any other actions here.
// //       }
// //     } catch (e) {
// //       // Handle any errors that occur during the update process
// //       showDialog(
// //         context: context,
// //         builder: (BuildContext context) {
// //           return AlertDialog(
// //             title: Text('Update Error'),
// //             content: Text('Failed to update food data: $e'),
// //             actions: <Widget>[
// //               TextButton(
// //                 child: Text('OK'),
// //                 onPressed: () {
// //                   Navigator.of(context).pop(); // Close the dialog
// //                 },
// //               ),
// //             ],
// //           );
// //         },
// //       );
// //     }
// //   }
// //
// //   void deleteFoodItem(int foodId) async {
// //     try {
// //       await deleteFood(foodId.toString());
// //       print('Food item deleted successfully');
// //       // Trigger the refresh to update the food list
// //       _refreshIndicatorKey.currentState?.show();
// //     } catch (e) {
// //       print('Error deleting food item: $e');
// //       // Optionally, show an error message to the user
// //     }
// //   }
// //
// //   Future<void> _refreshData() async {
// //     // Implement the refresh logic here
// //     // For example, you can re-fetch the data and update the UI.
// //     // Then call _refreshIndicatorKey.currentState?.show() to dismiss the indicator.
// //     getRestaurantFoods();
// //   }
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     getRestaurantFoods();
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Restaurant'),
// //         actions: [
// //           IconButton(
// //             icon: Icon(Icons.search),
// //             onPressed: () async {
// //               final query = await showSearch<String>(
// //                 context: context,
// //                 delegate: RestaurantSearchDelegate(searchFoods),
// //               );
// //               if (query != null) {
// //                 // Perform additional actions if needed with the query
// //               }
// //             },
// //           ),
// //           PopupMenuButton<String>(
// //             onSelected: (value) {
// //               // Implement filter options
// //               // You can filter food items based on user selection here
// //             },
// //             itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
// //               const PopupMenuItem<String>(
// //                 value: 'active',
// //                 child: Text('Active Food Items'),
// //               ),
// //               const PopupMenuItem<String>(
// //                 value: 'inactive',
// //                 child: Text('Inactive Food Items'),
// //               ),
// //               // Add more filter options as needed
// //             ],
// //           ),
// //         ],
// //       ),
// //       body: RefreshIndicator(
// //         key: _refreshIndicatorKey,
// //         onRefresh: _refreshData,
// //         child: foodList.isEmpty
// //             ? Center(
// //                 child: Text('No food items found.'),
// //               )
// //             : ListView.builder(
// //                 itemCount: foodList.length,
// //                 itemBuilder: (context, index) {
// //                   final food = foodList[index];
// //                   return Card(
// //                     elevation: 3.0,
// //                     margin: EdgeInsets.all(10.0),
// //                     child: ListTile(
// //                       leading: CircleAvatar(
// //                           //   backgroundImage: food.imageUrl != null
// //                           //       ? AssetImage(food.imageUrl!)
// //                           //       : AssetImage('default_image.jpg'), // Provide a default image path
// //                           ),
// //                       title: Text(food.foodName ?? ''),
// //                       // Display food name as the title
// //                       subtitle:
// //                           Text('\$${food.price?.toStringAsFixed(2) ?? ''}'),
// //                       // Display price as the subtitle
// //                       trailing: PopupMenuButton<String>(
// //                         onSelected: (value) {
// //                           if (value == 'edit') {
// //                             //editFood(context, food.id);
// //                           } else if (value == 'delete') {
// //                             showDialog(
// //                               context: context,
// //                               builder: (BuildContext context) {
// //                                 return AlertDialog(
// //                                   title: Text('Confirm Deletion'),
// //                                   content: Text(
// //                                       'Are you sure you want to delete this food item?'),
// //                                   actions: <Widget>[
// //                                     TextButton(
// //                                       child: Text('Cancel'),
// //                                       onPressed: () {
// //                                         Navigator.of(context).pop();
// //                                       },
// //                                     ),
// //                                     TextButton(
// //                                       child: Text('Delete'),
// //                                       onPressed: () {
// //                                         deleteFoodItem(food.id!.toInt());
// //                                         Navigator.of(context).pop();
// //                                       },
// //                                     ),
// //                                   ],
// //                                 );
// //                               },
// //                             );
// //                           }
// //                         },
// //                         itemBuilder: (BuildContext context) =>
// //                             <PopupMenuEntry<String>>[
// //                           const PopupMenuItem<String>(
// //                             value: 'edit',
// //                             child: Text('Edit Food'),
// //                           ),
// //                           const PopupMenuItem<String>(
// //                             value: 'delete',
// //                             child: Text('Delete Food'),
// //                           ),
// //                           // Add more actions as needed
// //                         ],
// //                       ),
// //                     ),
// //                   );
// //                 },
// //               ),
// //       ),
// //       floatingActionButton: FloatingActionButton(
// //         onPressed: () {
// //           _logout(context);
// //           // Implement adding a new food item functionality
// //           // You can navigate to a page for adding a new food item here
// //         },
// //         child: Icon(Icons.add),
// //       ),
// //     );
// //   }
// // }
// //
// // void _logout(BuildContext context) async {
// //   // Clear user session data in SharedPreferences
// //   SharedPreferences prefs = await SharedPreferences.getInstance();
// //   prefs.remove('role');
// //   prefs.remove('phoneNumber');
// //
// //   // Navigate to the login page
// //   Navigator.pushReplacement(
// //     context,
// //     MaterialPageRoute(builder: (context) => LoginPage()),
// //   );
// // }
//
//
// class ResHomePage extends StatefulWidget {
//   final String restaurantId;
//
//   ResHomePage({Key? key, required this.restaurantId}) : super(key: key);
//
//   @override
//   State<ResHomePage> createState() => _ResHomePageState();
// }
//
// class _ResHomePageState extends State<ResHomePage> {
//   List<AllFoodRestaurantModel.Data> foodList = [];
//   final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
//   GlobalKey<RefreshIndicatorState>();
//
//   void getRestaurantFoods() async {
//     try {
//       final AllFoodRestaurantModel.AllFoodRestaurantModel? restaurantFoods =
//       await datas.getAllRestaurantFoods(
//           ApiConstants.baseUrl, widget.restaurantId);
//
//       if (restaurantFoods != null) {
//         setState(() {
//           foodList = restaurantFoods.data ?? [];
//         });
//       }
//     } catch (e) {
//       print('Error loading restaurant foods: $e');
//     }
//   }
//
//   void editFood(BuildContext context, int foodId) async {
//     try {
//       // Fetch food data
//       var foodData = await updateFood(
//           foodId: foodId.toString(), foodData: {}); // Use named arguments
//       // Rest of your code...
//       // Navigate to the EditFoodPage and pass the food data
//       final updatedFoodData = await Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => EditFoodPage(foodData: {}),
//         ),
//       );
//
//       // Handle the updatedFoodData as needed (e.g., update the UI)
//       if (updatedFoodData != null) {
//         print("Updated food data received: $updatedFoodData");
//         // You can update the UI or perform any other actions here.
//       }
//     } catch (e) {
//       // Handle any errors that occur during the update process
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
//
//   void deleteFoodItem(int foodId) async {
//     try {
//       await deleteFood(foodId.toString());
//       print('Food item deleted successfully');
//       // Trigger the refresh to update the food list
//       _refreshIndicatorKey.currentState?.show();
//     } catch (e) {
//       print('Error deleting food item: $e');
//       // Optionally, show an error message to the user
//     }
//   }
//
//   Future<void> _refreshData() async {
//     // Implement the refresh logic here
//     // For example, you can re-fetch the data and update the UI.
//     // Then call _refreshIndicatorKey.currentState?.show() to dismiss the indicator.
//     getRestaurantFoods();
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     getRestaurantFoods();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Restaurant'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.search),
//             onPressed: () async {
//               final query = await showSearch<String>(
//                 context: context,
//                 delegate: RestaurantSearchDelegate(searchFoods),
//               );
//               if (query != null) {
//                 // Perform additional actions if needed with the query
//               }
//             },
//           ),
//           PopupMenuButton<String>(
//             onSelected: (value) {
//               // Implement filter options
//               // You can filter food items based on user selection here
//             },
//             itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
//               const PopupMenuItem<String>(
//                 value: 'active',
//                 child: Text('Active Food Items'),
//               ),
//               const PopupMenuItem<String>(
//                 value: 'inactive',
//                 child: Text('Inactive Food Items'),
//               ),
//               // Add more filter options as needed
//             ],
//           ),
//         ],
//       ),
//       body: RefreshIndicator(
//         key: _refreshIndicatorKey,
//         onRefresh: _refreshData,
//         child: foodList.isEmpty
//             ? Center(
//           child: Text('No food items found.'),
//         )
//             : ListView.builder(
//           itemCount: foodList.length,
//           itemBuilder: (context, index) {
//             final food = foodList[index];
//             return Card(
//               elevation: 3.0,
//               margin: EdgeInsets.all(10.0),
//               child: ListTile(
//                 leading: CircleAvatar(
//                   //   backgroundImage: food.imageUrl != null
//                   //       ? AssetImage(food.imageUrl!)
//                   //       : AssetImage('default_image.jpg'), // Provide a default image path
//                 ),
//                 title: Text(food.foodName ?? ''),
//                 // Display food name as the title
//                 subtitle:
//                 Text('\$${food.price?.toStringAsFixed(2) ?? ''}'),
//                 // Display price as the subtitle
//                 trailing: PopupMenuButton<String>(
//                   onSelected: (value) {
//                     if (value == 'edit') {
//                       editFood(context, food.id.toString() as int);
//                     } else if (value == 'delete') {
//                       showDialog(
//                         context: context,
//                         builder: (BuildContext context) {
//                           return AlertDialog(
//                             title: Text('Confirm Deletion'),
//                             content: Text(
//                                 'Are you sure you want to delete this food item?'),
//                             actions: <Widget>[
//                               TextButton(
//                                 child: Text('Cancel'),
//                                 onPressed: () {
//                                   Navigator.of(context).pop();
//                                 },
//                               ),
//                               TextButton(
//                                 child: Text('Delete'),
//                                 onPressed: () {
//                                   deleteFoodItem(food.id!.toInt());
//                                   Navigator.of(context).pop();
//                                 },
//                               ),
//                             ],
//                           );
//                         },
//                       );
//                     }
//                   },
//                   itemBuilder: (BuildContext context) =>
//                   <PopupMenuEntry<String>>[
//                     const PopupMenuItem<String>(
//                       value: 'edit',
//                       child: Text('Edit Food'),
//                     ),
//                     const PopupMenuItem<String>(
//                       value: 'delete',
//                       child: Text('Delete Food'),
//                     ),
//                     // Add more actions as needed
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           _logout(context);
//           // Implement adding a new food item functionality
//           // You can navigate to a page for adding a new food item here
//         },
//         child: Icon(Icons.add),
//       ),
//     );
//   }
//
//   void _logout(BuildContext context) async {
//     // Clear user session data in SharedPreferences
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.remove('role');
//     prefs.remove('phoneNumber');
//
//     // Navigate to the login page
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (context) => LoginPage()),
//     );
//   }
// }
