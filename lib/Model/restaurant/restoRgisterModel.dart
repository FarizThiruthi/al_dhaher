class RestoRegisterModel {
  Data? data;
  String? message;
  bool? success;

  RestoRegisterModel({this.data, this.message, this.success, required String restaurantId});

  RestoRegisterModel.fromJson(Map<String, dynamic> json) {
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
  String? name;
  String? location;
  String? phonenumber;
  String? mailid;
  String? password;
  String? role;
  int? loginId;

  Data(
      {this.id,
        this.name,
        this.location,
        this.phonenumber,
        this.mailid,
        this.password,
        this.role,
        this.loginId});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    location = json['location'];
    phonenumber = json['phonenumber'];
    mailid = json['mailid'];
    password = json['password'];
    role = json['role'];
    loginId = json['login_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['location'] = this.location;
    data['phonenumber'] = this.phonenumber;
    data['mailid'] = this.mailid;
    data['password'] = this.password;
    data['role'] = this.role;
    data['login_id'] = this.loginId;
    return data;
  }
}
