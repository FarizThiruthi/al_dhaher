import 'package:flutter/material.dart';
import '../../Config/constants.dart';
import '../../Model/restaurant/viewAllRestoModel.dart';
import '../../Services/restaurant/restaurantSearchApi.dart';
import '../../Services/restaurant/restaurantUpdateApi.dart';
import '../../Services/restaurant/restaurantdeleteApi.dart';
import '../../Services/restaurant/viewAllRestauranApi.dart';
import '../restaurantPage/editRestoPage.dart';
import '../restaurantPage/searchRestoPage.dart';

class ManageRestaurantPage extends StatefulWidget {
  ManageRestaurantPage({Key? key}) : super(key: key);

  @override
  _ManageRestaurantPageState createState() => _ManageRestaurantPageState();
}

class _ManageRestaurantPageState extends State<ManageRestaurantPage> {
  List<Restaurant> searchResults = [];
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  void searchRestaurantsByQuery(String query) async {
    try {
      final List<Restaurant> results =
          (await searchRestaurants(query)).cast<Restaurant>();

      setState(() {
        searchResults = results;
      });
    } catch (e) {
      // Handle search error
      print('Error searching restaurants: $e');
    }
  }

  void editRestaurant(BuildContext context, String restaurantId) async {
    try {
      // Fetch restaurant data
      Map<String, dynamic> restaurantData = await updateRestaurantData(
          restaurantId, {}); // Pass an empty map as the second argument

      // Navigate to the EditRestaurantPage and pass the restaurant data
      final updatedRestaurantData = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              EditRestaurantPage(restaurantData: restaurantData),
        ),
      );

      // Handle the updatedRestaurantData as needed (e.g., update the UI)
      if (updatedRestaurantData != null) {
        print("Updated restaurant data received: $updatedRestaurantData");
        // You can update the UI or perform any other actions here.
      }
    } catch (e) {
      // Handle any errors that occur during the update process
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

  Future<void> _refreshData() async {
    // Implement the refresh logic here
    // For example, you can re-fetch the data and update the UI.
    // Then call _refreshIndicatorKey.currentState?.show() to dismiss the indicator.
    setState(() {
      // Update the UI with new data
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Restaurants'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              final query = await showSearch<String>(
                context: context,
                delegate: RestaurantSearchDelegate(searchRestaurantsByQuery),
              );
              if (query != null) {
                // Perform additional actions if needed with the query
              }
            },
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              // Implement filter options
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'open',
                child: Text('Open Restaurants'),
              ),
              const PopupMenuItem<String>(
                value: 'closed',
                child: Text('Closed Restaurants'),
              ),
              // Add more filter options as needed
            ],
          ),
        ],
      ),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _refreshData,
        child: searchResults.isEmpty
            ? FutureBuilder<ViewAllRestoModel?>(
                future: getAllRestaurants(ApiConstants.baseUrl),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data?.data == null) {
                    return Center(child: Text('No restaurants found.'));
                  } else {
                    final restaurantList = snapshot.data!.data!;

                    return ListView.builder(
                      itemCount: restaurantList.length,
                      itemBuilder: (context, index) {
                        final restaurant = restaurantList[index];
                        return Card(
                          elevation: 3.0,
                          margin: EdgeInsets.all(10.0),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.black,
                              child: Text(
                                restaurant.name?.isNotEmpty == true
                                    ? restaurant.name![0].toUpperCase()
                                    : '?',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ),
                            title: Text(restaurant.name ?? ''),
                            subtitle: Text(restaurant.location ?? ''),
                            trailing: PopupMenuButton<String>(
                              onSelected: (value) {
                                if (value == 'edit') {
                                  editRestaurant(
                                      context, restaurant.id.toString());
                                } else if (value == 'delete') {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('Confirm Deletion'),
                                        content: Text(
                                            'Are you sure you want to delete this restaurant?'),
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
                                                await deleteRestaurant(
                                                    restaurant.id.toString());
                                                print(
                                                    'Restaurant deleted successfully');
                                                // Trigger the refresh to update the restaurant list
                                                _refreshIndicatorKey
                                                    .currentState
                                                    ?.show();
                                              } catch (e) {
                                                print(
                                                    'Error deleting restaurant: $e');
                                                // Optionally, show an error message to the user
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
                                  child: Text('Edit Restaurant'),
                                ),
                                const PopupMenuItem<String>(
                                  value: 'delete',
                                  child: Text('Delete Restaurant'),
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
                  final restaurant = searchResults[index];
                  return Card(
                    elevation: 3.0,
                    margin: EdgeInsets.all(10.0),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: AssetImage(restaurant.imageUrl),
                      ),
                      title: Text(restaurant.name ?? ''),
                      subtitle: Text(restaurant.location ?? ''),
                      trailing: PopupMenuButton<String>(
                        onSelected: (value) {
                          if (value == 'edit') {
                            editRestaurant(context, restaurant.id.toString());
                          } else if (value == 'delete') {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Confirm Deletion'),
                                  content: Text(
                                      'Are you sure you want to delete this restaurant?'),
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
                                          await deleteRestaurant(
                                              restaurant.id.toString());
                                          print(
                                              'Restaurant deleted successfully');
                                          // Trigger the refresh to update the restaurant list
                                          _refreshIndicatorKey.currentState
                                              ?.show();
                                        } catch (e) {
                                          print(
                                              'Error deleting restaurant: $e');
                                          // Optionally, show an error message to the user
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
                            child: Text('Edit Restaurant'),
                          ),
                          const PopupMenuItem<String>(
                            value: 'delete',
                            child: Text('Delete Restaurant'),
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
          // Implement adding a new restaurant functionality
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class Restaurant {
  final int id;
  final String name;
  final String location;
  final String imageUrl;

  Restaurant({
    required this.id,
    required this.name,
    required this.location,
    required this.imageUrl,
  });
}
