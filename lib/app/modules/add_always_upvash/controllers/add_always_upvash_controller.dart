import 'package:flutter/material.dart';
import 'package:food_planner_app/constants/app_constant.dart';
import 'package:food_planner_app/constants/sizeConstant.dart';
import 'package:get/get.dart';

import '../../../../db/db_helper.dart';
import '../../../../main.dart';
import '../../../../models/selected_model.dart';
import '../../../../models/user.dart';

class AddAlwaysUpvashController extends GetxController {
  RxBool isFromHome = false.obs;
  RxBool isFromLocation = false.obs;
  RxList<UserModels> selectedList = RxList<UserModels>([]);
  RxBool hasData = false.obs;
  RxList<SelectedModels> attendanceList = RxList<SelectedModels>([]);

  @override
  Future<void> onInit() async {
    if (Get.arguments != null) {
      isFromHome.value = Get.arguments[ArgumentConstant.isFromHome];
      isFromLocation.value = Get.arguments[ArgumentConstant.isFromLocation];
    }
    await getUserList(context: Get.context!);
    super.onInit();
  }

  deleteAttendance({required UserModels userData}) {
    if (!isNullEmptyOrFalse(attendanceList)) {
      if (attendanceList.any((element) => element.id == userData.id)) {
        SelectedModels selectedData = attendanceList
            .where((p0) =>
                (p0.id == userData.id) &&
                (p0.status == 2 && userData.isSelected == 0))
            .first;
        getIt<DBHelper>().deleteUsingId(id: selectedData.id);
      }
    }
  }

  Future<void> getUserList({required BuildContext context}) async {
    selectedList.clear();
    List<Map<String, dynamic>> tasks = await getIt<DBHelper>().queryUser();
    tasks.forEach((e) {
      int id = e["id"];
      RxString name = e['name'].toString().obs;
      RxString location = e['location'].toString().obs;
      int isSelected = e["isSelected"];
      selectedList.add(UserModels(
          id: id, name: name, location: location, isSelected: isSelected.obs));
    });
    await getSelectedList(context: context);
  }

  Future<void> getSelectedList({required BuildContext context}) async {
    hasData.value = false;

    List<Map<String, dynamic>> tasks =
        await getIt<DBHelper>().queryAttendance();
    attendanceList.clear();
    tasks.forEach((e) {
      if (!attendanceList.contains(e)) {
        attendanceList.add(SelectedModels.fromJson(e));
      }
    });
    hasData.value = true;
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
