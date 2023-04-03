import 'package:flutter/material.dart';
import 'package:food_planner_app/constants/sizeConstant.dart';
import 'package:food_planner_app/models/selected_model.dart';
import 'package:food_planner_app/utilities/progress_dialog_utils.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../constants/app_constant.dart';
import '../../../../constants/color_constant.dart';
import '../../../../db/db_helper.dart';
import '../../../../main.dart';
import '../../../../models/user.dart';

class HomeController extends GetxController {
  RxString selectedDate = "".obs;
  RxList<UserModels> locationsSelectedUser = RxList<UserModels>([]);
  RxList<UserModels> isSelectedUserList = RxList<UserModels>([]);
  RxList<SelectedModels> locationsAttendanceList = RxList<SelectedModels>([]);
  RxList<SelectedModels> tempList = RxList<SelectedModels>([]);
  RxList<UserModels> userList = RxList<UserModels>([]);
  RxList<SelectedModels> attendanceList = RxList<SelectedModels>([]);
  RxBool hasData = false.obs;
  RxList<String> dropdownListLocation = <String>[
    ArgumentConstant.kundal,
    ArgumentConstant.vadodara,
    ArgumentConstant.gam,
  ].obs;
  RxList<String> list = <String>[
    ArgumentConstant.savar,
    ArgumentConstant.Sanj,
  ].obs;
  RxString dropDownLocation = ArgumentConstant.kundal.obs;

  RxString dropdownValue = ArgumentConstant.savar.obs;

  @override
  Future<void> onInit() async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      selectedDate.value =
          DateFormat('dd/MM/yyyy').format(DateTime.now()).toString();
      getTime();
      await getUserList(context: Get.context!);
      await getSelectedList(context: Get.context!);
    });
    super.onInit();
  }

  getTime() {
    TimeOfDay day = TimeOfDay.now();
    switch (day.period) {
      case DayPeriod.am:
        dropdownValue.value = list[0];
        break;
      case DayPeriod.pm:
        dropdownValue.value = list[1];
        break;
    }
  }

  alwaysUpavas({required BuildContext context}) {
    isSelectedUserList.clear();
    isSelectedUserList.value =
        userList.where((element) => element.isSelected.value == 1).toList();
    for (int i = 0; i < userList.length; i++) {
      if (isSelectedUserList
          .map((element) => element.id)
          .toList()
          .contains(userList[i].id)) {
        if (!isNullEmptyOrFalse(attendanceList)) {
          if (attendanceList[i].id != userList[i].id) {
            addTask(
                task: SelectedModels(
                    id: userList[i].id!,
                    status: 2.obs,
                    time: ArgumentConstant.savar.obs,
                    date: selectedDate),
                context: Get.context!);
            addTask(
                task: SelectedModels(
                    id: userList[i].id!,
                    status: 2.obs,
                    time: ArgumentConstant.Sanj.obs,
                    date: selectedDate),
                context: Get.context!);
          }
        } else {
          addTask(
              task: SelectedModels(
                  id: userList[i].id!,
                  status: 2.obs,
                  time: ArgumentConstant.savar.obs,
                  date: selectedDate),
              context: Get.context!);
          addTask(
              task: SelectedModels(
                  id: userList[i].id!,
                  status: 2.obs,
                  time: ArgumentConstant.Sanj.obs,
                  date: selectedDate),
              context: Get.context!);
        }
      }
    }
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
    print(attendanceList);
    tempList.clear();
    tempList.value =
        locationsAttendanceList.where((p0) => p0.status == 1).toList();
    getIt<CustomDialogs>().hideCircularDialog(context);
  }

  addTask({SelectedModels? task, required BuildContext context}) async {
    await getIt<DBHelper>().insertAttendanceTable(task).then((value) {
      return 1;
    });
    getSelectedList(context: context);
  }

  Color getColor({required int id}) {
    if (attendanceList.any((element) => element.id == id)) {
      SelectedModels selectedData =
          attendanceList.where((p0) => p0.id == id).first;
      if (selectedData.status == 1) {
        return appTheme.SelectedColor;
      } else if (selectedData.status == 2) {
        return Colors.red;
      } else {
        return appTheme.unSelectedColor;
      }
    } else {
      return appTheme.unSelectedColor;
    }
  }

  Color getTextColor({required int id}) {
    if (attendanceList.any((element) => element.id == id)) {
      return Colors.white;
    } else {
      return appTheme.textGrayColor;
    }
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
        .getDataFromDate(date: selectedDate.value, time: dropdownValue.value);
    attendanceList.clear();
    tasks.forEach((e) {
      if (!attendanceList.contains(e)) {
        attendanceList.add(SelectedModels.fromJson(e));
      }
    });
    tempData(context: context);
    alwaysUpavas(context: context);
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
      // alwaysUpavas(context: context);
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
