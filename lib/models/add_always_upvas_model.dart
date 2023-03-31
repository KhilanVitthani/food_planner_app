import 'package:get/get.dart';

class AddAlwaysUpvasModel {
  int? id;
  RxString name = "".obs;
  RxBool isSelected = false.obs;

  AddAlwaysUpvasModel({
    required this.name,
    required this.isSelected,
    this.id,
  });

  AddAlwaysUpvasModel.fromJson(Map<String, dynamic> json) {
    name.value = json['name'];
    isSelected.value = json['isSelected'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name.value;
    data['isSelected'] = this.isSelected.value;
    data['id'] = this.id;
    return data;
  }
}
