class UserUpdate {
  Data? data;
  String? message;
  bool? success;

  UserUpdate({this.data, this.message, this.success});

  UserUpdate.fromJson(Map<String, dynamic> json) {
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
  String? phonenumber;
  String? password;
  String? mailid;
  String? pincode;
  String? location;
  String? role;
  String? profilePic;
  int? loginId;

  Data(
      {this.id,
        this.name,
        this.phonenumber,
        this.password,
        this.mailid,
        this.pincode,
        this.location,
        this.role,
        this.profilePic,
        this.loginId});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phonenumber = json['phonenumber'];
    password = json['password'];
    mailid = json['mailid'];
    pincode = json['pincode'];
    location = json['location'];
    role = json['role'];
    profilePic = json['profile_pic'];
    loginId = json['login_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phonenumber'] = this.phonenumber;
    data['password'] = this.password;
    data['mailid'] = this.mailid;
    data['pincode'] = this.pincode;
    data['location'] = this.location;
    data['role'] = this.role;
    data['profile_pic'] = this.profilePic;
    data['login_id'] = this.loginId;
    return data;
  }
}
