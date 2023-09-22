import 'package:flutter/material.dart';

class RestaurantSearchDelegate extends SearchDelegate<String> {
  final Function(String) onSearch;

  RestaurantSearchDelegate(this.onSearch);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(); // No need to build results here; handled in the parent widget
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text('Search for restaurants by name or location'),
          dense: true,
        ),
        ListTile(
          leading: Icon(Icons.search),
          title: Text(query),
          onTap: () {
            onSearch(query);
            close(context, query);
          },
        ),
      ],
    );
  }
}
