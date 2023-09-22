class LoginModel {
  Data? data;
  bool? success;
  String? message;

  LoginModel({this.data, this.success, this.message});

  LoginModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    success = json['success'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['success'] = this.success;
    data['message'] = this.message;
    return data;
  }
}

class Data {
  int? loginId;
  String? username;
  String? password;
  String? role;
  int? userid;

  Data({this.loginId, this.username, this.password, this.role, this.userid});

  Data.fromJson(Map<String, dynamic> json) {
    loginId = json['login_id'];
    username = json['username'];
    password = json['password'];
    role = json['role'];
    userid = json['userid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['login_id'] = this.loginId;
    data['username'] = this.username;
    data['password'] = this.password;
    data['role'] = this.role;
    data['userid'] = this.userid;
    return data;
  }
}
