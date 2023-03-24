import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../constants/app_constant.dart';
import '../../../../constants/color_constant.dart';
import '../../../../db/db_helper.dart';
import '../../../../main.dart';
import '../../../../models/selected_model.dart';
import '../../../../models/user.dart';
import '../../../../utilities/progress_dialog_utils.dart';

class UpavasListViewController extends GetxController {
  RxString selectedDate = "".obs;
  RxList<UserModels> userList = RxList<UserModels>([]);
  RxList<UserModels> locationsSelectedUser = RxList<UserModels>([]);
  RxList<SelectedModels> attendanceList = RxList<SelectedModels>([]);
  RxList<SelectedModels> locationsAttendanceList = RxList<SelectedModels>([]);
  RxList<SelectedModels> tempList = RxList<SelectedModels>([]);
  RxBool hasData = false.obs;
  RxList<String> dropdownListLocation = <String>[
    "Kundal",
    "Vadodara",
    "Gam",
  ].obs;
  RxList<String> list = <String>[
    ArgumentConstant.savar,
    ArgumentConstant.Sanj,
  ].obs;
  RxString dropDownLocation = "Kundal".obs;
  RxString dropdownValue = ArgumentConstant.savar.obs;

  @override
  Future<void> onInit() async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      selectedDate.value =
          DateFormat('dd/MM/yyyy').format(DateTime.now()).toString();
      await getUserList(context: Get.context!);
      await getSelectedList(context: Get.context!);
    });
    super.onInit();
  }

  tempData({required BuildContext context}) {
    tempList.clear();
    locationsAttendanceList.clear();
    locationsSelectedUser.value = userList
        .where((element) => element.location.value == dropDownLocation.value)
        .toList();
    for (int i = 0; i < attendanceList.length; i++) {
      if (locationsSelectedUser
          .map((element) => element.id)
          .toList()
          .contains(attendanceList[i].id)) {
        locationsAttendanceList.add(attendanceList[i]);
      }
    }
    tempList.clear();
    tempList.value =
        locationsAttendanceList.where((p0) => p0.status == 2).toList();
    getIt<CustomDialogs>().hideCircularDialog(context);
  }

  Future<void> getUserList({required BuildContext context}) async {
    userList.clear();
    List<Map<String, dynamic>> tasks = await getIt<DBHelper>().queryUser();
    tasks.forEach((e) {
      int id = e["id"];
      RxString name = e['name'].toString().obs;
      RxString location = e['location'].toString().obs;
      userList.add(UserModels(id: id, name: name, location: location));
    });
    hasData.value = true;
  }

  Future<void> getSelectedList({required BuildContext context}) async {
    List<Map<String, dynamic>> tasks = await getIt<DBHelper>()
        .getDataFromDate(date: selectedDate.value, time: dropdownValue.value);
    attendanceList.clear();
    tasks.forEach((e) {
      if (!attendanceList.contains(e)) {
        // print(e);
        attendanceList.add(SelectedModels.fromJson(e));
      }
    });
    // print(attendanceList.length);
    tempData(context: context);
  }

  datePick({required BuildContext context}) async {
    DateTime? pickedDate = await showDatePicker(
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: appTheme.SelectedColor, // <-- SEE HERE
                onPrimary: appTheme.primaryTheme, // <-- SEE HERE
                onSurface: Color.fromARGB(255, 66, 125, 145), // <-- SEE HERE
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  foregroundColor: appTheme.textGrayColor, // button text color
                ),
              ),
            ),
            child: child!,
          );
        },
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1950),
        lastDate: DateTime(2100));

    if (pickedDate != null) {
      // print(pickedDate);
      selectedDate.value = DateFormat('dd/MM/yyyy').format(pickedDate);
      getSelectedList(context: context);
    } else {}
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
