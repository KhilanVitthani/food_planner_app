import 'package:flutter/material.dart';
import 'package:food_planner_app/constants/app_constant.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../constants/color_constant.dart';
import '../../../../db/db_helper.dart';
import '../../../../main.dart';
import '../../../../models/selected_model.dart';
import '../../../../models/user.dart';
import '../../../../utilities/progress_dialog_utils.dart';

class AddUpvasController extends GetxController {
  RxString selectedDate = "".obs;
  RxBool isSavarSelected = true.obs;
  RxBool isSanjSelected = false.obs;
  RxBool isFullDaySelected = false.obs;
  RxBool isPrvahi = false.obs;
  RxBool isFaral = false.obs;
  RxBool hasData = false.obs;
  RxList<SelectedModels> getDataList = RxList<SelectedModels>([]);
  RxList<String> list = RxList<String>([]);
  RxString dropdownValue = "1".obs;
  RxString selectedDataDate = "".obs;
  RxList<UserModels> userList = RxList<UserModels>([]);
  RxList<UserModels> selectedUserList = RxList<UserModels>([]);
  RxList<SelectedModels> attendanceList = RxList<SelectedModels>([]);
  RxList<SelectedModels> savarAttendanceList = RxList<SelectedModels>([]);
  RxList<SelectedModels> sanjAttendanceList = RxList<SelectedModels>([]);
  RxList<SelectedModels> tempList = RxList<SelectedModels>([]);

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
    list.clear();
    selectedUserList.clear();
    tempList.value = attendanceList.where((p0) => p0.status == 2).toList();
    // print(tempList.length);
    selectedUserList.clear();
    for (int i = 0; i < userList.length; i++) {
      if (!tempList
          .map((element) => element.id)
          .toList()
          .contains(userList[i].id)) {
        selectedUserList.add(userList[i]);
      }
    }
    list.clear();
    list.addAll(selectedUserList.map((element) => element.name.value));
    dropdownValue.value = list.first;
    getIt<CustomDialogs>().hideCircularDialog(context);
  }

  addTask({SelectedModels? task, required BuildContext context}) async {
    await getIt<DBHelper>().insertAttendanceTable(task).then((value) {
      return 1;
    });
    getSelectedList(context: context);
  }

  Future<void> getUserList({required BuildContext context}) async {
    userList.clear();
    List<Map<String, dynamic>> tasks = await getIt<DBHelper>().queryUser();
    tasks.forEach((e) {
      int id = e["id"];
      RxString name = e['name'].toString().obs;
      RxString location = e['location'].toString().obs;
      int isSelected = e['isSelected'];
      userList.add(UserModels(
          id: id, name: name, location: location, isSelected: isSelected.obs));
    });
    hasData.value = true;
  }

  Future<void> getSelectedList({required BuildContext context}) async {
    List<Map<String, dynamic>> tasks = await getIt<DBHelper>()
        .getDataFromDate(date: selectedDate.value, time: getSelectedText());
    attendanceList.clear();
    tasks.forEach((e) {
      attendanceList.add(SelectedModels.fromJson(e));
    });
    // print(attendanceList.length);
    tempData(context: context);
  }

  Future<void> getFullData({required BuildContext context}) async {
    List<Map<String, dynamic>> tasks =
        await getIt<DBHelper>().queryAttendance();
    savarAttendanceList.clear();
    tasks.forEach((e) {
      savarAttendanceList.add(SelectedModels.fromJson(e));
    });
    attendanceList.value = savarAttendanceList.toSet().toList();
    tempData(context: context);
  }

  datePick({required BuildContext context}) async {
    DateTime? pickedDate = await showDatePicker(
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: appTheme.primaryTheme, // <-- SEE HERE
                onPrimary: Colors.white, // <-- SEE HERE
                // onSurface: Color.fromARGB(255, 66, 125, 145), // <-- SEE HERE
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
      // alwaysUpavas(context: context);
    } else {}
  }

  getSelectedText() {
    if (isFullDaySelected.isTrue) {
      return ArgumentConstant.full;
    } else if (isSavarSelected.isTrue) {
      return ArgumentConstant.savar;
    } else if (isSanjSelected.isTrue) {
      return ArgumentConstant.Sanj;
    }
    return ArgumentConstant.savar;
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
