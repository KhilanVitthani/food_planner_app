import 'package:flutter/material.dart';
import 'package:food_planner_app/constants/app_constant.dart';
import 'package:get/get.dart';

import '../../../../db/db_helper.dart';
import '../../../../main.dart';
import '../../../../models/add_always_upvas_model.dart';
import '../../../../models/user.dart';

class AddAlwaysUpvashController extends GetxController {
  RxBool isFromHome = false.obs;
  RxList<UserModels> selectedList = RxList<UserModels>([]);
  RxList<AddAlwaysUpvasModel> UserSelectedList =
      RxList<AddAlwaysUpvasModel>([]);

  RxBool isSelected = false.obs;
  @override
  Future<void> onInit() async {
    if (Get.arguments != null) {
      isFromHome.value = Get.arguments[ArgumentConstant.isFromHome];
    }
    await getUserList(context: Get.context!);
    super.onInit();
  }

  Future<void> getUserList({required BuildContext context}) async {
    selectedList.clear();
    List<Map<String, dynamic>> tasks = await getIt<DBHelper>().queryUser();
    tasks.forEach((e) {
      int id = e["id"];
      RxString name = e['name'].toString().obs;
      RxString location = e['location'].toString().obs;
      selectedList.add(UserModels(id: id, name: name, location: location));
    });
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
