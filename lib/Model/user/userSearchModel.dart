class UserSearchApi {
  List<Data>? data;
  String? message;
  bool? success;

  UserSearchApi({this.data, this.message, this.success});

  UserSearchApi.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    message = json['message'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    data['success'] = this.success;
    return data;
  }
}

class Data {
  String? name;
  String? phonenumber;
  String? id;

  Data({this.name, this.phonenumber,this.id});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phonenumber = json['phonenumber'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['phonenumber'] = this.phonenumber;
    data['id'] = this.id;
    return data;
  }
}
