// import 'package:al_dhaher/Model/restaurant/food/addFoodModel.dart';
// import 'package:al_dhaher/Pages/restaurantPage/food/addFoodPage.dart';
// import 'package:al_dhaher/Pages/restaurantPage/searchFoodPage.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../../Config/constants.dart';
// import '../../Model/restaurant/food/allFoodRestaurantModel.dart' as allfood;
// import '../../Model/restaurant/food/foodSearchModel.dart' as search;
// import '../../Services/restaurant/food/allFoodRestaurantApi.dart';
// import '../../Services/restaurant/food/deleteFoodApi.dart';
// import '../../Services/restaurant/food/foodSearchApi.dart';
// import '../../Services/restaurant/food/updateFoodApi.dart';
// import '../loginPage/loginPage.dart';
// import 'food/editFoodPage.dart';
//
// class ManageFoodPage extends StatefulWidget {
//   const ManageFoodPage({Key? key}) : super(key: key);
//
//   //final String restaurantId;
//
//   @override
//   _ManageFoodPageState createState() => _ManageFoodPageState();
// }
//
// class _ManageFoodPageState extends State<ManageFoodPage> {
//   List<search.Data> searchResults = [];
//
//   //
//   // late SharedPreferences prefs;
//   //  late int restoId ;
//
//   final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
//       GlobalKey<RefreshIndicatorState>();
//
//   void searchFoodsByQuery(String query) async {
//     try {
//       final List<search.Data> results =
//           (await searchFoods(query)).cast<search.Data>();
//
//       setState(() {
//         searchResults = results;
//       });
//     } catch (e) {
//       // Handle search error
//       print('Error searching foods: $e');
//     }
//   }
//
//   void editFood(BuildContext context, String foodId) async {
//     try {
//       // Fetch food data
//       Map<String, dynamic> foodData = await updateFood(
//           foodId, {}); // Pass an empty map as the second argument
//
//       // Navigate to the EditFoodPage and pass the food data
//       final updatedFoodData = await Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => EditFoodPage(foodData: foodData),
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
//   Future<void> _refreshData() async {
//     // Implement the refresh logic here
//     // For example, you can re-fetch the data and update the UI.
//     // Then call _refreshIndicatorKey.currentState?.show() to dismiss the indicator.
//     setState(() {
//       // Update the UI with new data
//     });
//   }
//
//   String restaurantName = ''; // Add this variable to store the restaurant name
//
//   @override
//   void initState() {
//     super.initState();
//     // Retrieve the restaurant name from SharedPreferences
//     _retrieveRestaurantName();
//   }
//
//   Future<void> _retrieveRestaurantName() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     setState(() {
//       restaurantName =
//           prefs.getString('restoName') ?? ''; // Get the restaurant name
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     //final String restaurantId = widget.restaurantId;
//     return Scaffold(
//       appBar: AppBar(
//         leading: GestureDetector(
//           onTap: () {
//             _showRestaurantDetailsDialog(context);
//           },
//         ),
//         title: Text(restaurantName),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.search),
//             onPressed: () async {
//               final query = await showSearch<String>(
//                 context: context,
//                 delegate: FoodSearchDelegate(searchFoodsByQuery),
//               );
//               if (query != null) {
//                 // Perform additional actions if needed with the query
//               }
//             },
//           ),
//           // Add filter options here if needed
//         ],
//       ),
//       body: RefreshIndicator(
//         key: _refreshIndicatorKey,
//         onRefresh: _refreshData,
//         child: searchResults.isEmpty
//             ? FutureBuilder<allfood.AllFoodRestaurantModel?>(
//                 future: getAllRestaurantFoods(ApiConstants.baseUrl),
//                 // Replace 'restaurantId' with the actual restaurant ID
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return Center(child: CircularProgressIndicator());
//                   } else if (snapshot.hasError) {
//                     return Center(child: Text('Error: ${snapshot.error}'));
//                   } else if (!snapshot.hasData || snapshot.data?.data == null) {
//                     return Center(child: Text('No foods found.'));
//                   } else {
//                     final foodList = snapshot.data!.data!;
//
//                     return ListView.builder(
//                       itemCount: foodList.length,
//                       itemBuilder: (context, index) {
//                         final food = foodList[index];
//                         return Card(
//                           elevation: 3.0,
//                           margin: EdgeInsets.all(10.0),
//                           child: ListTile(
//                             leading: CircleAvatar(
//                               backgroundColor: Colors.black,
//                               child: Text(
//                                 food.foodName?.isNotEmpty == true
//                                     ? food.foodName![0].toUpperCase()
//                                     : '?',
//                                 style: TextStyle(
//                                   fontSize: 20,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                             ),
//                             title: Text(food.foodName ?? ''),
//                             subtitle: Text('Price: \$${food.price ?? ''}'),
//                             trailing: PopupMenuButton<String>(
//                               onSelected: (value) {
//                                 if (value == 'edit') {
//                                   editFood(context, food.id.toString());
//                                 } else if (value == 'delete') {
//                                   showDialog(
//                                     context: context,
//                                     builder: (BuildContext context) {
//                                       return AlertDialog(
//                                         title: Text('Confirm Deletion'),
//                                         content: Text(
//                                             'Are you sure you want to delete this food?'),
//                                         actions: <Widget>[
//                                           TextButton(
//                                             child: Text('Cancel'),
//                                             onPressed: () {
//                                               Navigator.of(context).pop();
//                                             },
//                                           ),
//                                           TextButton(
//                                             child: Text('Delete'),
//                                             onPressed: () async {
//                                               try {
//                                                 await deleteFood(
//                                                     food.id.toString());
//                                                 print(
//                                                     'Food deleted successfully');
//                                                 // Trigger the refresh to update the food list
//                                                 _refreshIndicatorKey
//                                                     .currentState
//                                                     ?.show();
//                                               } catch (e) {
//                                                 print(
//                                                     'Error deleting food: $e');
//                                                 // Optionally, show an error message to the user
//                                               }
//                                               Navigator.of(context).pop();
//                                             },
//                                           ),
//                                         ],
//                                       );
//                                     },
//                                   );
//                                 }
//                               },
//                               itemBuilder: (BuildContext context) =>
//                                   <PopupMenuEntry<String>>[
//                                 const PopupMenuItem<String>(
//                                   value: 'edit',
//                                   child: Text('Edit Food'),
//                                 ),
//                                 const PopupMenuItem<String>(
//                                   value: 'delete',
//                                   child: Text('Delete Food'),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         );
//                       },
//                     );
//                   }
//                 },
//               )
//             : ListView.builder(
//                 itemCount: searchResults.length,
//                 itemBuilder: (context, index) {
//                   final food = searchResults[index];
//                   return Card(
//                     elevation: 3.0,
//                     margin: EdgeInsets.all(10.0),
//                     child: ListTile(
//                       leading: CircleAvatar(
//                         backgroundColor: Colors.black,
//                         child: Text(
//                           food.foodName?.isNotEmpty == true
//                               ? food.foodName![0].toUpperCase()
//                               : '?',
//                           style: TextStyle(
//                             fontSize: 20,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                       title: Text(food.foodName ?? ''),
//                       subtitle: Text('Price: \$${food.price ?? ''}'),
//                       trailing: PopupMenuButton<String>(
//                         onSelected: (value) {
//                           if (value == 'edit') {
//                             editFood(context, food.id.toString());
//                           } else if (value == 'delete') {
//                             showDialog(
//                               context: context,
//                               builder: (BuildContext context) {
//                                 return AlertDialog(
//                                   title: Text('Confirm Deletion'),
//                                   content: Text(
//                                       'Are you sure you want to delete this food?'),
//                                   actions: <Widget>[
//                                     TextButton(
//                                       child: Text('Cancel'),
//                                       onPressed: () {
//                                         Navigator.of(context).pop();
//                                       },
//                                     ),
//                                     TextButton(
//                                       child: Text('Delete'),
//                                       onPressed: () async {
//                                         try {
//                                           await deleteFood(food.id.toString());
//                                           print('Food deleted successfully');
//                                           // Trigger the refresh to update the food list
//                                           _refreshIndicatorKey.currentState
//                                               ?.show();
//                                         } catch (e) {
//                                           print('Error deleting food: $e');
//                                           // Optionally, show an error message to the user
//                                         }
//                                         Navigator.of(context).pop();
//                                       },
//                                     ),
//                                   ],
//                                 );
//                               },
//                             );
//                           }
//                         },
//                         itemBuilder: (BuildContext context) =>
//                             <PopupMenuEntry<String>>[
//                           const PopupMenuItem<String>(
//                             value: 'edit',
//                             child: Text('Edit Food'),
//                           ),
//                           const PopupMenuItem<String>(
//                             value: 'delete',
//                             child: Text('Delete Food'),
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.push(
//               context, MaterialPageRoute(builder: (context) => AddFoodPage()));
//         },
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }
//
// void _logout(BuildContext context) async {
//   // Clear user session data in SharedPreferences
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   prefs.remove('role');
//   prefs.remove('phoneNumber');
//
//   // Navigate to the login page
//   Navigator.pushReplacement(
//     context,
//     MaterialPageRoute(builder: (context) => LoginPage()),
//   );
// }
//
// void _showRestaurantDetailsDialog(BuildContext context) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: Text('Restaurant Details'),
//         content: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             // Display restaurant details here
//             Text('Restaurant Name'),
//             // Add more restaurant details as needed
//             SizedBox(height: 16),
//             // Logout option
//             GestureDetector(
//               onTap: () {
//                 // Handle logout here
//                 _logout(context);
//               },
//               child: Row(
//                 children: [
//                   Icon(Icons.logout),
//                   SizedBox(width: 8),
//                   Text('Logout'),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       );
//     },
//   );
// }

import 'dart:convert';

import 'package:al_dhaher/Pages/restaurantPage/food/addFoodPage.dart';
import 'package:al_dhaher/Pages/restaurantPage/searchFoodPage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Config/constants.dart';
import '../../Model/restaurant/food/allFoodRestaurantModel.dart' as allfood;
import '../../Model/restaurant/food/foodSearchModel.dart' as search;
import '../../Services/restaurant/food/allFoodRestaurantApi.dart';
import '../../Services/restaurant/food/deleteFoodApi.dart';
import '../../Services/restaurant/food/foodSearchApi.dart';
import '../../Services/restaurant/food/updateFoodApi.dart';
import '../loginPage/loginPage.dart';
import 'food/editFoodPage.dart';

class ManageFoodPage extends StatefulWidget {
  const ManageFoodPage({Key? key}) : super(key: key);

  @override
  _ManageFoodPageState createState() => _ManageFoodPageState();
}

class _ManageFoodPageState extends State<ManageFoodPage> {
  List<search.Data> searchResults = [];
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  GlobalKey<RefreshIndicatorState>();

  void searchFoodsByQuery(String query) async {
    try {
      final List<search.Data> results =
      (await searchFoods(query)).cast<search.Data>();

      setState(() {
        searchResults = results;
      });
    } catch (e) {
      // Handle search error
      print('Error searching foods: $e');
    }
  }

  void editFood(BuildContext context, String foodId) async {
    try {
      // Fetch food data
      Map<String, dynamic> foodData = await updateFood(
          foodId, {}); // Pass an empty map as the second argument
      print('Response Body: $foodData');

      // Navigate to the EditFoodPage and pass the food data
      final updatedFoodData = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EditFoodPage(foodData: foodData,onFoodUpdated: _refreshData,),
        ),
      );

      // Handle the updatedFoodData as needed (e.g., update the UI)
      if (updatedFoodData != null) {
        print("Updated food data received: $updatedFoodData");
        // You can update the UI or perform any other actions here.
      }
    } catch (e) {
      // Handle any errors that occur during the update process
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

  Future<void> _refreshData() async {
    try {
      final result = await getAllRestaurantFoods(ApiConstants.baseUrl);
      if (result != null) {
        setState(() {
          // Update the UI with new data
        });
      }
    } catch (e) {
      // Handle any errors here
      print('Error refreshing data: $e');
    }
  }

  String restaurantName = '';

  @override
  void initState() {
    super.initState();
    _retrieveRestaurantName();
  }

  Future<void> _retrieveRestaurantName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      restaurantName =
          prefs.getString('restoName') ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            _showRestaurantDetailsDialog(context);
          },
          child: Icon(Icons.restaurant),
        ),
        title: Text(restaurantName),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              final query = await showSearch<String>(
                context: context,
                delegate: FoodSearchDelegate(searchFoodsByQuery),
              );
              if (query != null) {
                // Perform additional actions if needed with the query
              }
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _refreshData,
        child: searchResults.isEmpty
            ? FutureBuilder<allfood.AllFoodRestaurantModel?>(
          future: getAllRestaurantFoods(ApiConstants.baseUrl),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data?.data == null) {
              return Center(child: Text('No foods found.'));
            } else {
              final foodList = snapshot.data!.data!;

              return ListView.builder(

                itemCount: foodList.length,
                itemBuilder: (context, index) {

                  final food = foodList[index];
                  print(food.image!);
                  var url=food.image!.replaceAll('http://localhost:8000', '${ApiConstants
                      .baseUrl}');
                  print('---$url');
                  return Card(
                    elevation: 3.0,
                    margin: EdgeInsets.all(10.0),
                    child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.black,
                    backgroundImage: NetworkImage(url),

                  ),
                        // leading: CircleAvatar(
                        //   backgroundColor: Colors.black,
                        //   child: (food.image != null && food.image!.isNotEmpty)
                        //       ? Image.network(
                        //     ApiConstants.baseUrl+food.image!, // Use the non-nullable image here
                        //     fit: BoxFit.cover,
                        //   )
                        //       : Text(
                        //     food.foodName?.isNotEmpty == true
                        //         ? food.foodName![0].toUpperCase()
                        //         : '?',
                        //     style: TextStyle(
                        //       fontSize: 20,
                        //       color: Colors.white,
                        //     ),
                        //   ),
                        // ),


                        title: Text(food.foodName ?? ''),
                      subtitle: Text('Price: \$${food.price ?? ''}'),
                      trailing: PopupMenuButton<String>(
                        onSelected: (value) {
                          if (value == 'edit') {
                            editFood(context, food.id.toString());
                          } else if (value == 'delete') {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Confirm Deletion'),
                                  content: Text(
                                      'Are you sure you want to delete this food?'),
                                  actions: <Widget>[
                                    TextButton(
                                      child: Text('Cancel'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    TextButton(
                                      child: Text('Delete'),
                                      onPressed: () async {
                                        try {
                                          await deleteFood(
                                              food.id.toString());
                                          print(
                                              'Food deleted successfully');
                                          _refreshIndicatorKey
                                              .currentState
                                              ?.show();
                                        } catch (e) {
                                          print(
                                              'Error deleting food: $e');
                                        }
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        },
                        itemBuilder: (BuildContext context) =>
                        <PopupMenuEntry<String>>[
                          const PopupMenuItem<String>(
                            value: 'edit',
                            child: Text('Edit Food'),
                          ),
                          const PopupMenuItem<String>(
                            value: 'delete',
                            child: Text('Delete Food'),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          },
        )
            : ListView.builder(
          itemCount: searchResults.length,
          itemBuilder: (context, index) {
            final food = searchResults[index];
            return Card(
              elevation: 3.0,
              margin: EdgeInsets.all(10.0),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.black,
                  child: Text(
                    food.foodName?.isNotEmpty == true
                        ? food.foodName![0].toUpperCase()
                        : '?',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
                title: Text(food.foodName ?? ''),
                subtitle: Text('Price: \$${food.price ?? ''}'),
                trailing: PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == 'edit') {
                      editFood(context, food.id.toString());
                    } else if (value == 'delete') {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Confirm Deletion'),
                            content: Text(
                                'Are you sure you want to delete this food?'),
                            actions: <Widget>[
                              TextButton(
                                child: Text('Cancel'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                child: Text('Delete'),
                                onPressed: () async {
                                  try {
                                    await deleteFood(food.id.toString());
                                    print('Food deleted successfully');
                                    _refreshIndicatorKey.currentState
                                        ?.show();
                                  } catch (e) {
                                    print('Error deleting food: $e');
                                  }
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                  itemBuilder: (BuildContext context) =>
                  <PopupMenuEntry<String>>[
                    const PopupMenuItem<String>(
                      value: 'edit',
                      child: Text('Edit Food'),
                    ),
                    const PopupMenuItem<String>(
                      value: 'delete',
                      child: Text('Delete Food'),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddFoodPage(refreshCallback: _refreshData),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('role');
    prefs.remove('phoneNumber');
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  void _showRestaurantDetailsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Restaurant Details'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Restaurant Name: $restaurantName'),
              GestureDetector(
                onTap: () {
                  _logout(context);
                },
                child: Row(
                  children: [
                    Icon(Icons.logout),
                    SizedBox(width: 8),
                    Text('Logout'),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
