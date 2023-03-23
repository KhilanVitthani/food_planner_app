import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../models/selected_model.dart';

class AddUpvasController extends GetxController {
  RxString selectedDate = "".obs;
  RxBool isSavarSelected = true.obs;
  RxBool isSanjSelected = false.obs;
  RxBool isFullDaySelected = false.obs;
  RxBool hasData = false.obs;
  RxList<SelectedModels> getDataList = RxList<SelectedModels>([]);
  RxList<String> list = RxList<String>([]);
  RxString dropdownValue = "1".obs;
  RxString selectedDataDate = "".obs;

  @override
  void onInit() {
    selectedDate.value =
        DateFormat('dd MMM, yyyy').format(DateTime.now()).toString();
    super.onInit();
  }

  datePick({required BuildContext context}) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1950),
        lastDate: DateTime(2100));
    if (pickedDate != null) {
      print(pickedDate);
      selectedDate.value = DateFormat('dd/MM/yyyy').format(pickedDate);
      selectedDataDate.value = DateFormat('dd/MM/yyyy').format(pickedDate);
    } else {}
  }

  getSelectedText() {
    if (isFullDaySelected.isTrue) {
      return "Full";
    } else if (isSavarSelected.isTrue) {
      return "Savar";
    } else if (isSanjSelected.isTrue) {
      return "Sanj";
    }
    return "Savar";
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
