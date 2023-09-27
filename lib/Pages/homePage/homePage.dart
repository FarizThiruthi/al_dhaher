import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Config/constants.dart';
import '../../Model/restaurant/food/allFoodModel.dart';
import '../../Services/restaurant/food/allFoodAPI.dart';
import '../../Services/user/cartApi.dart';
import '../loginPage/loginPage.dart';
import '../restaurantPage/food/foodDetailsPage.dart';

class UserHomePage extends StatefulWidget {
  @override
  _UserHomePageState createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  List<Data> foodList = [];
  String userName = '';

  @override
  void initState() {
    super.initState();
    fetchFoodList();
    fetchUserDetails();
  }

  void fetchUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedUserName = prefs.getString('restoName');
    if (storedUserName != null) {
      setState(() {
        userName = storedUserName; // Update the user name
      });
    }
  }

  void fetchFoodList() async {
    try {
      final AllFoodViewModel? allFoodViewModel =
          await getAllFoods(ApiConstants.baseUrl);
      if (allFoodViewModel != null && allFoodViewModel.data != null) {
        setState(() {
          foodList = allFoodViewModel.data!;
        });
      } else {
        // Handle the case when the response is null or data is empty
        print('API Response is null or data is empty.');
      }
    } catch (e) {
      // Handle API error here
      print('Error fetching food data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Home Page"),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              // Add your cart icon click logic here
              // For example, navigate to the cart page.
            },
          ),
        ],
      ),
      drawer: Theme(
        data: ThemeData(
          canvasColor: Colors.black, // Set the drawer background color to black
          primaryColor: Colors.white, // Set the text color to white
          textTheme: TextTheme(
            bodyLarge:
                TextStyle(color: Colors.white), // Set text color to white
            bodyMedium:
                TextStyle(color: Colors.white), // Set text color to white
          ),
        ),
        child: Drawer(
          child: ListView(
            children: <Widget>[
              // Drawer header with user information
              DrawerHeader(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 40.0,
                      // Add user's profile image here
                      // backgroundImage: AssetImage('path_to_image'),
                      // You can use NetworkImage for remote images
                      // backgroundImage: NetworkImage('url_to_image'),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      userName,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              // Add other drawer items as needed
              ListTile(
                leading: Icon(Icons.exit_to_app,color: Colors.white),
                title: Text('Logout'),
                onTap: () {
                  // Call the logout function
                  _logout(context);
                },
              ),
            ],
          ),
        ),
      ),
      body: foodList.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: foodList.length,
              itemBuilder: (context, index) {
                final foodItem = foodList[index];
                return Card(
                  elevation: 3.0,
                  margin: EdgeInsets.all(10.0),
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                FoodDetailsScreen(foodItem: foodItem),
                          ));
                    },
                    leading: CircleAvatar(
                      backgroundColor: Colors.black,
                      child:
                          (foodItem.image != null && foodItem.image!.isNotEmpty)
                              ? Image.network(
                                  foodItem.image!,
                                  fit: BoxFit.cover,
                                )
                              : Text(
                                  foodItem.foodName?.isNotEmpty == true
                                      ? foodItem.foodName![0].toUpperCase()
                                      : '?',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                    ),
                    title: Text(foodItem.price ?? ""),
                    subtitle: Text("Quantity: ${foodItem.quantity ?? ""}"),
                    trailing: IconButton(
                      icon: Icon(Icons.add_shopping_cart),
                      onPressed: () {
                        // Add the selected item to the cart or perform the desired action
                        // addToCart(
                        //   context: context,
                        //   userId: widget.userId, // Pass the userId from the widget
                        //   foodId: foodItem.id ?? 0, // Pass the foodId
                        // );
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }

  void _logout(BuildContext context) async {
    // Clear user session data in SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('role');
    prefs.remove('phoneNumber');

    // Navigate to the login page
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }
}

// import 'package:al_dhaher/Pages/restaurantPage/food/foodDetailsPage.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../../Config/constants.dart';
// import '../../Model/restaurant/food/allFoodModel.dart';
// import '../../Services/restaurant/food/allFoodAPI.dart';
// import '../../Services/user/cartApi.dart';
// import '../loginPage/loginPage.dart';
//
// class UserHomePage extends StatefulWidget {
//   // final int userId;
//   // UserHomePage({required this.userId});
//
//   @override
//   _UserHomePageState createState() => _UserHomePageState();
// }
//
// class _UserHomePageState extends State<UserHomePage> {
//   List<Data> foodList = [];
//
//   @override
//   void initState() {
//     super.initState();
//     fetchFoodList();
//   }
//
//   void fetchFoodList() async {
//     try {
//       final AllFoodViewModel? allFoodViewModel =
//           await getAllFoods(ApiConstants.baseUrl);
//       if (allFoodViewModel != null && allFoodViewModel.data != null) {
//         setState(() {
//           foodList = allFoodViewModel.data!;
//         });
//       } else {
//         // Handle the case when the response is null or data is empty
//         print('API Response is null or data is empty.');
//       }
//     } catch (e) {
//       // Handle API error here
//       print('Error fetching food data: $e');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(onPressed: (){}, icon: Icon(Icons.account_circle_rounded))  ,
//         title: Text("User Home Page"),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.shopping_cart),
//             onPressed: () {
//               // Add your cart icon click logic here
//               // For example, navigate to the cart page.
//             },
//           ),
//         ],
//
//       ),
//       body: foodList.isEmpty
//           ? Center(child: CircularProgressIndicator())
//           : ListView.builder(
//               itemCount: foodList.length,
//               itemBuilder: (context, index) {
//                 final foodItem = foodList[index];
//                 return Card(
//                   elevation: 3.0,
//                   margin: EdgeInsets.all(10.0),
//                   child: ListTile(
//                     onTap: () {
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) =>
//                                 FoodDetailsScreen(foodItem: foodItem),
//                           ));
//                     },
//                     leading: CircleAvatar(
//                       backgroundColor: Colors.black,
//                       child:
//                           (foodItem.image != null && foodItem.image!.isNotEmpty)
//                               ? Image.network(
//                                   foodItem.image!,
//                                   fit: BoxFit.cover,
//                                 )
//                               : Text(
//                                   foodItem.foodName?.isNotEmpty == true
//                                       ? foodItem.foodName![0].toUpperCase()
//                                       : '?',
//                                   style: TextStyle(
//                                     fontSize: 20,
//                                     color: Colors.white,
//                                   ),
//                                 ),
//                     ),
//                     title: Text(foodItem.price ?? ""),
//                     subtitle: Text("Quantity: ${foodItem.quantity ?? ""}"),
//                     trailing: IconButton(
//                       icon: Icon(Icons.add_shopping_cart),
//                       onPressed: () {
//                         // Add the selected item to the cart or perform the desired action
//                         // addToCart(
//                         //   context: context,
//                         //   userId: widget.userId, // Pass the userId from the widget
//                         //   foodId: foodItem.id ?? 0, // Pass the foodId
//                         // );
//                       },
//                     ),
//                   ),
//                 );
//               },
//             ),
//     );
//   }
// }
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
