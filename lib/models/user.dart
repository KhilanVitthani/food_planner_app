import 'package:get/get.dart';

class UserModels {
  int? id;
  RxString name = "".obs;
  RxString location = "".obs;

  UserModels({
    required this.name,
    required this.location,
    this.id,
  });

  UserModels.fromJson(Map<String, dynamic> json) {
    name.value = json['name'];
    location.value = json['Location'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name.value;
    data['Location'] = this.location.value;
    data['id'] = this.id;
    return data;
  }
}
