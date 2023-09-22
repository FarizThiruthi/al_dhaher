class FoodCreateModel {
  Data? data;
  String? message;
  bool? success;

  FoodCreateModel({this.data, this.message, this.success});

  FoodCreateModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    data['success'] = this.success;
    return data;
  }
}

class Data {
  int? id;
  String? restaurantName;
  String? restaurantId;
  String? foodName;
  String? quantity;
  String? price;
  String? category;
  Null? image;

  Data(
      {this.id,
        this.restaurantName,
        this.restaurantId,
        this.foodName,
        this.quantity,
        this.price,
        this.category,
        this.image});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    restaurantName = json['restaurant_name'];
    restaurantId = json['restaurant_id'];
    foodName = json['food_name'];
    quantity = json['quantity'];
    price = json['price'];
    category = json['category'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['restaurant_name'] = this.restaurantName;
    data['restaurant_id'] = this.restaurantId;
    data['food_name'] = this.foodName;
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    data['category'] = this.category;
    data['image'] = this.image;
    return data;
  }
}
