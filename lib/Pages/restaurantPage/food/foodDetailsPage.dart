import 'package:flutter/material.dart';
import '../../../Model/restaurant/food/allFoodModel.dart';

class FoodDetailsScreen extends StatelessWidget {
  final Data foodItem;

  // Constructor to receive the selected food item
  FoodDetailsScreen({required this.foodItem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Food Details'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // Display food item image
              Container(
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  image: DecorationImage(
                    image: NetworkImage(foodItem.image ?? ''),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              SizedBox(height: 16),

              // Food item name
              Text(
                foodItem.foodName ?? '',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 8),

              // Food item price
              Text(
                'Price: ${foodItem.price ?? ''}',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),

              SizedBox(height: 8),

              // Food item quantity
              Text(
                'Quantity: ${foodItem.quantity ?? ''}',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),

              SizedBox(height: 16),

              // Button to add the item to the cart
              ElevatedButton(
                onPressed: () {
                  // Implement your cart logic here
                  // For example, add the selected item to a cart list
                  // You can use a state management solution like Provider or Riverpod
                  // to manage the cart state throughout your app.
                  // You can also use a callback function to add the item to the cart in the parent widget.
                },
                child: Text('Add to Cart'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
