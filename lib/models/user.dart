import 'package:get/get.dart';

class UserModels {
  int? id;
  RxString name = "".obs;
  RxString location = "".obs;
  RxInt isSelected = 0.obs;

  UserModels({
    required this.name,
    required this.location,
    required this.isSelected,
    this.id,
  });

  UserModels.fromJson(Map<String, dynamic> json) {
    name.value = json['name'];
    location.value = json['Location'];
    isSelected.value = json['isSelected'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name.value;
    data['Location'] = this.location.value;
    data['isSelected'] = this.isSelected.value;
    data['id'] = this.id;
    return data;
  }
}
