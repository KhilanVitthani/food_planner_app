import 'package:get/get.dart';

class SelectedModels {
  int id = 0;
  RxString time = "".obs;
  RxInt status = 0.obs;
  RxString date = "".obs;

  SelectedModels({
    required this.id,
    required this.status,
    required this.time,
    required this.date,
  });

  SelectedModels.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    time.value = json['time'];
    status.value = json['status'];
    date.value = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['time'] = this.time.value;
    data['status'] = this.status.value;
    data['date'] = this.date.value;
    return data;
  }
}
