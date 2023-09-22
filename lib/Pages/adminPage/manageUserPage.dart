import 'package:flutter/material.dart';
import '../../Config/constants.dart';
import '../../Model/user/viewAllUserModel.dart';
import '../../Model/user/userSearchModel.dart' as search;
import '../../Services/user/deleteUserApi.dart';
import '../../Services/user/edit_user.dart';
import '../../Services/user/userSearchApi.dart';
import '../../Services/user/viewAllUserApi.dart';
import '../user/editUserPage.dart';
import '../user/searchUserPage.dart';

class ManageUserPage extends StatefulWidget {
  ManageUserPage({Key? key}) : super(key: key);

  @override
  _ManageUserPageState createState() => _ManageUserPageState();
}

class _ManageUserPageState extends State<ManageUserPage> {
  List<search.Data> searchResults = [];
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  GlobalKey<RefreshIndicatorState>();

  void searchUsersByQuery(String query) async {
    try {
      final List<search.Data> results = (await searchUsers(query)).cast<search.Data>();

      setState(() {
        searchResults = results;
      });
    } catch (e) {
      // Handle search error
      print('Error searching users: $e');
    }
  }


  void editUser(BuildContext context, String userId) async {
    try {
      // Fetch user data
      Map<String, dynamic> userData = await updateUser(
          userId, {}); // Pass an empty map as the second argument

      // Navigate to the EditProfilePage and pass the user data
      final updatedUserData = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EditProfilePage(userData: userData),
        ),
      );

      // Handle the updatedUserData as needed (e.g., update the UI)
      if (updatedUserData != null) {
        print("Updated user data received: $updatedUserData");
        // You can update the UI or perform any other actions here.
      }
    } catch (e) {
      // Handle any errors that occur during the update process
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
        title: Text('Manage Users'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              final query = await showSearch<String>(
                context: context,
                delegate: UserSearchDelegate(searchUsersByQuery),
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
                value: 'active',
                child: Text('Active Users'),
              ),
              const PopupMenuItem<String>(
                value: 'inactive',
                child: Text('Inactive Users'),
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
            ? FutureBuilder<ViewAllUserModel?>(
          future: getAllUsers(ApiConstants.baseUrl),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data?.data == null) {
              return Center(child: Text('No users found.'));
            } else {
              final userList = snapshot.data!.data!;

              return ListView.builder(
                itemCount: userList.length,
                itemBuilder: (context, index) {
                  final user = userList[index];
                  return Card(
                    elevation: 3.0,
                    margin: EdgeInsets.all(10.0),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.black,
                        child: Text(
                          user.name?.isNotEmpty == true
                              ? user.name![0].toUpperCase()
                              : '?',
                          style: TextStyle(
                              fontSize: 20, color: Colors.white),
                        ),
                      ),
                      title: Text(user.name ?? ''),
                      subtitle: Text('@${user.phonenumber ?? ''}'),
                      trailing: PopupMenuButton<String>(
                        onSelected: (value) {
                          if (value == 'edit') {
                            editUser(context, user.id.toString());
                          } else if (value == 'delete') {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Confirm Deletion'),
                                  content: Text(
                                      'Are you sure you want to delete this user?'),
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
                                          await deleteUser(
                                              user.id.toString());
                                          print(
                                              'User deleted successfully');
                                          // Trigger the refresh to update the user list
                                          _refreshIndicatorKey.currentState
                                              ?.show();
                                        } catch (e) {
                                          print(
                                              'Error deleting user: $e');
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
                            child: Text('Edit User'),
                          ),
                          const PopupMenuItem<String>(
                            value: 'delete',
                            child: Text('Delete User'),
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
            final user = searchResults[index];
            return Card(
              elevation: 3.0,
              margin: EdgeInsets.all(10.0),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.black,
                  child: Text(
                    user.name?.isNotEmpty == true
                        ? user.name![0].toUpperCase()
                        : '?',
                    style:
                    TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
                title: Text(user.name ?? ''),
                subtitle: Text('@${user.phonenumber ?? ''}'),
                trailing: PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == 'edit') {
                      editUser(context, user.id.toString());
                    } else if (value == 'delete') {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Confirm Deletion'),
                            content: Text(
                                'Are you sure you want to delete this user?'),
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
                                    await deleteUser(
                                        user.id.toString());
                                    print(
                                        'User deleted successfully');
                                    // Trigger the refresh to update the user list
                                    _refreshIndicatorKey.currentState
                                        ?.show();
                                  } catch (e) {
                                    print('Error deleting user: $e');
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
                      child: Text('Edit User'),
                    ),
                    const PopupMenuItem<String>(
                      value: 'delete',
                      child: Text('Delete User'),
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
          // Implement adding a new user functionality
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
