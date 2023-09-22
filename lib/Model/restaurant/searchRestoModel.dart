class SearchRestoModel {
  List<Data>? data;
  String? message;
  bool? success;

  SearchRestoModel({this.data, this.message, this.success});

  SearchRestoModel.fromJson(Map<String, dynamic> json) {
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

  Data({this.name, this.phonenumber});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phonenumber = json['phonenumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['phonenumber'] = this.phonenumber;
    return data;
  }
}
