import 'package:flutter/material.dart';
import 'package:food_planner_app/app/routes/app_pages.dart';
import 'package:food_planner_app/utilities/progress_dialog_utils.dart';
import 'package:get/get.dart';
import '../../../../constants/app_constant.dart';
import '../../../../constants/color_constant.dart';
import '../../../../db/db_helper.dart';
import '../../../../main.dart';
import '../../../../models/selected_model.dart';
import '../controllers/add_upvas_controller.dart';

class AddUpvasView extends GetView<AddUpvasController> {
  const AddUpvasView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.offAndToNamed(Routes.MAIN_SCREEN);

        return await true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: InkWell(
              onTap: () {
                Get.offAndToNamed(Routes.MAIN_SCREEN);
              },
              child: Padding(
                padding: const EdgeInsets.all(13.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Color(0xffF3F3F3),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      "assets/icons_image/back.png",
                    ),
                  ),
                ),
              )),
          title: const Text('Add Upvas', style: TextStyle(color: Colors.black)),
          centerTitle: true,
        ),
        body: Obx(() {
          return Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Column(children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Time"),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              getIt<CustomDialogs>()
                                  .showCircularDialog(context);

                              controller.isFullDaySelected.value = false;
                              controller.isSavarSelected.value = true;
                              controller.isSanjSelected.value = false;
                              controller.getSelectedList(context: context);
                            },
                            child: Row(
                              children: [
                                (controller.isSavarSelected.isTrue)
                                    ? Image.asset(
                                        "assets/icons_image/CheckBox.png",
                                        height: 20)
                                    : Image.asset("assets/icons_image/box.png",
                                        height: 20),
                                SizedBox(
                                  width: 10,
                                ),
                                Text("Savar"),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          InkWell(
                            onTap: () {
                              getIt<CustomDialogs>()
                                  .showCircularDialog(context);

                              controller.isFullDaySelected.value = false;
                              controller.isSavarSelected.value = false;
                              controller.isSanjSelected.value = true;
                              controller.getSelectedList(context: context);
                            },
                            child: Row(
                              children: [
                                (controller.isSanjSelected.isTrue)
                                    ? Image.asset(
                                        "assets/icons_image/CheckBox.png",
                                        height: 20)
                                    : Image.asset("assets/icons_image/box.png",
                                        height: 20),
                                SizedBox(
                                  width: 10,
                                ),
                                Text("Sanj"),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          InkWell(
                            onTap: () {
                              getIt<CustomDialogs>()
                                  .showCircularDialog(context);
                              controller.isFullDaySelected.value = true;
                              controller.isSavarSelected.value = false;
                              controller.isSanjSelected.value = false;
                              controller.getFullData(context: context);
                            },
                            child: Row(
                              children: [
                                (controller.isFullDaySelected.isTrue)
                                    ? Image.asset(
                                        "assets/icons_image/CheckBox.png",
                                        height: 20)
                                    : Image.asset("assets/icons_image/box.png",
                                        height: 20),
                                SizedBox(
                                  width: 10,
                                ),
                                Text("Full Day"),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Number", style: TextStyle(fontSize: 17)),
                          SizedBox(
                            height: 12,
                          ),
                          Container(
                            height: 50,
                            width: 130,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: appTheme.textGrayColor),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12))),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(right: 10.0, left: 10),
                              child: DropdownButton<String>(
                                value:
                                    controller.dropdownValue.value.toString(),
                                elevation: 16,
                                style: TextStyle(
                                    fontFamily: 'JosefinSans',
                                    color: appTheme.textGrayColor,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
                                icon: Padding(
                                  padding:
                                      EdgeInsets.only(left: 45.0, right: 0),
                                  child: Image.asset(
                                      "assets/icons_image/down.png",
                                      height: 25),
                                ),
                                underline: Container(
                                  // height: 2,
                                  color: Colors.white,
                                ),
                                onChanged: (String? value) {
                                  controller.dropdownValue.value = value!;
                                },
                                items: controller.list
                                    .map<DropdownMenuItem<String>>((value) {
                                  return DropdownMenuItem<String>(
                                    value: value.toString(),
                                    child: Text((value).toString()),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Date", style: TextStyle(fontSize: 17)),
                          SizedBox(
                            height: 12,
                          ),
                          Container(
                            height: 50,
                            width: 140,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: appTheme.textGrayColor),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12))),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () {
                                  controller.datePick(context: Get.context!);
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(controller.selectedDate.value,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: appTheme.textGrayColor)),
                                    SizedBox(width: 10),
                                    Image.asset("assets/icons_image/date.png",
                                        height: 20),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(height: 80),
                InkWell(
                  onTap: () async {
                    int mId = controller.userList.indexWhere(
                        (element) => element.name == controller.dropdownValue);
                    // print(mId);
                    if (controller.getSelectedText() ==
                        ArgumentConstant.savar) {
                      bool isPresent = controller.attendanceList.any(
                          (element) =>
                              element.id == controller.userList[mId].id);
                      if (isPresent) {
                        SelectedModels selectedData = controller.attendanceList
                            .where((p0) => p0.id == controller.userList[mId].id)
                            .first;
                        getIt<DBHelper>().updateTime(
                            id: selectedData.id,
                            time: ArgumentConstant.savar.obs,
                            date: selectedData.date,
                            status: 2.obs);
                      } else {
                        controller.addTask(
                          context: context,
                          task: SelectedModels(
                              id: controller.userList[mId].id!,
                              status: 2.obs,
                              time: ArgumentConstant.savar.obs,
                              date: controller.selectedDate),
                        );
                      }
                      Get.offAndToNamed(Routes.MAIN_SCREEN);
                    } else if (controller.getSelectedText() ==
                        ArgumentConstant.Sanj) {
                      bool isPresent = controller.attendanceList.any(
                          (element) =>
                              element.id == controller.userList[mId].id);
                      if (isPresent) {
                        SelectedModels selectedData = controller.attendanceList
                            .where((p0) => p0.id == controller.userList[mId].id)
                            .first;
                        if (selectedData.time != ArgumentConstant.Sanj) {
                          controller.addTask(
                            context: context,
                            task: SelectedModels(
                                id: controller.userList[mId].id!,
                                status: 2.obs,
                                time: ArgumentConstant.Sanj.obs,
                                date: controller.selectedDate),
                          );
                        } else {
                          getIt<DBHelper>().updateTime(
                              id: selectedData.id,
                              status: 2.obs,
                              date: selectedData.date,
                              time: ArgumentConstant.Sanj.obs);
                        }
                      } else {
                        controller.addTask(
                          context: context,
                          task: SelectedModels(
                              id: controller.userList[mId].id!,
                              status: 2.obs,
                              time: ArgumentConstant.Sanj.obs,
                              date: controller.selectedDate),
                        );
                      }
                    } else {
                      bool isPresent = controller.savarAttendanceList.any(
                          (element) =>
                              element.id == controller.userList[mId].id);
                      if (isPresent) {
                        SelectedModels selectedData = controller
                            .savarAttendanceList
                            .where((p0) => p0.id == controller.userList[mId].id)
                            .first;
                        if (selectedData.time != ArgumentConstant.Sanj) {
                          controller.addTask(
                            context: context,
                            task: SelectedModels(
                                id: controller.userList[mId].id!,
                                status: 2.obs,
                                time: ArgumentConstant.Sanj.obs,
                                date: controller.selectedDate),
                          );

                          getIt<DBHelper>().updateTime(
                              id: selectedData.id,
                              status: 2.obs,
                              date: selectedData.date,
                              time: ArgumentConstant.savar.obs);
                        }
                        if (selectedData.time != ArgumentConstant.savar) {
                          controller.addTask(
                            context: context,
                            task: SelectedModels(
                                id: controller.userList[mId].id!,
                                status: 2.obs,
                                time: ArgumentConstant.savar.obs,
                                date: controller.selectedDate),
                          );
                          getIt<DBHelper>().updateTime(
                              id: selectedData.id,
                              status: 2.obs,
                              date: selectedData.date,
                              time: ArgumentConstant.Sanj.obs);
                        }
                      } else {
                        controller.addTask(
                          context: context,
                          task: SelectedModels(
                              id: controller.userList[mId].id!,
                              status: 2.obs,
                              time: ArgumentConstant.savar.obs,
                              date: controller.selectedDate),
                        );
                        controller.addTask(
                          context: context,
                          task: SelectedModels(
                              id: controller.userList[mId].id!,
                              status: 2.obs,
                              time: ArgumentConstant.Sanj.obs,
                              date: controller.selectedDate),
                        );
                      }
                    }
                    Get.offAndToNamed(Routes.MAIN_SCREEN);
                    controller.tempData(context: context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: appTheme.primaryTheme,
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    height: 50,
                    width: 140,
                    child: Center(
                      child: Text(
                        "Save",
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ),
                  ),
                )
              ]),
              Positioned(
                  child: Image.asset(
                "assets/icons_image/background.png",
                color: Colors.black,
              )),
            ],
          );
        }),
      ),
    );
  }
}
