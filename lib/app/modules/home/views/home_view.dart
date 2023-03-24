import 'package:flutter/material.dart';
import 'package:food_planner_app/models/selected_model.dart';
import 'package:food_planner_app/utilities/progress_dialog_utils.dart';

import 'package:get/get.dart';

import '../../../../constants/color_constant.dart';
import '../../../../db/db_helper.dart';
import '../../../../main.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        init: HomeController(),
        builder: (controller) {
          return Obx(() {
            return Scaffold(
                body: (controller.hasData.isFalse)
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: appTheme.textGrayColor),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(12))),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: InkWell(
                                      onTap: () {
                                        controller.datePick(
                                            context: Get.context!);
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(controller.selectedDate.value,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  color:
                                                      appTheme.textGrayColor)),
                                          SizedBox(width: 10),
                                          Image.asset(
                                              "assets/icons_image/date.png",
                                              height: 20),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: appTheme.textGrayColor),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(12))),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        right: 10.0, left: 10),
                                    child: DropdownButton<String>(
                                      value: controller.dropdownValue.value,
                                      elevation: 16,
                                      style: TextStyle(
                                          fontFamily: 'JosefinSans',
                                          color: appTheme.textGrayColor,
                                          fontWeight: FontWeight.w500),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(12)),
                                      icon: Padding(
                                        padding: EdgeInsets.only(left: 20.0),
                                        child: Image.asset(
                                            "assets/icons_image/down.png",
                                            height: 20),
                                      ),
                                      underline: Container(
                                        // height: 2,
                                        color: Colors.white,
                                      ),
                                      onChanged: (String? value) {
                                        // This is called when the user selects an item.
                                        controller.dropdownValue.value = value!;
                                        controller.getSelectedList(
                                            context: context);
                                      },
                                      items: controller.list
                                          .map<DropdownMenuItem<String>>(
                                              (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: appTheme.textGrayColor),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(12))),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        right: 10.0, left: 10),
                                    child: DropdownButton<String>(
                                      value: controller.dropdownlocation.value,
                                      elevation: 16,
                                      style: TextStyle(
                                          fontFamily: 'JosefinSans',
                                          color: appTheme.textGrayColor,
                                          fontWeight: FontWeight.w500),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(12)),
                                      icon: Padding(
                                        padding: EdgeInsets.only(left: 20.0),
                                        child: Image.asset(
                                            "assets/icons_image/down.png",
                                            height: 20),
                                      ),
                                      underline: Container(
                                        // height: 2,
                                        color: Colors.white,
                                      ),
                                      onChanged: (String? value) {
                                        // This is called when the user selects an item.
                                        controller.dropdownlocation.value =
                                            value!;
                                        controller.getSelectedList(
                                            context: context);
                                      },
                                      items: controller.dropdownListLocation
                                          .map<DropdownMenuItem<String>>(
                                              (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 8.0, left: 8, bottom: 8),
                                child: Row(
                                  children: [
                                    Text("Active",
                                        style: TextStyle(fontSize: 15)),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    CircleAvatar(
                                        radius: 5,
                                        backgroundColor:
                                            appTheme.SelectedColor),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      controller.tempList.length.toString(),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5.0),
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    GridView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 5,
                                              crossAxisSpacing: 5,
                                              mainAxisSpacing: 5),
                                      itemCount: controller.userList
                                          .where((element) =>
                                              element.location.value ==
                                              controller.dropdownlocation.value)
                                          .toList()
                                          .length,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {
                                            if (controller
                                                .attendanceList.isNotEmpty) {
                                              int mId = controller.userList
                                                  .where((element) =>
                                                      element.location.value ==
                                                      controller
                                                          .dropdownlocation
                                                          .value)
                                                  .toList()[index]
                                                  .id!;
                                              // print("object");
                                              bool isPresnt = controller
                                                  .attendanceList
                                                  .any((element) =>
                                                      element.id == mId);
                                              if (isPresnt) {
                                                SelectedModels selectedData =
                                                    controller.attendanceList
                                                        .where((p0) =>
                                                            p0.id == mId)
                                                        .first;
                                                if (selectedData.status == 1) {
                                                  getIt<DBHelper>().updateTime(
                                                      id: selectedData.id,
                                                      time: selectedData.time,
                                                      date: selectedData.date,
                                                      status: 2.obs);
                                                } else if (selectedData
                                                        .status ==
                                                    2) {
                                                  getIt<DBHelper>().delete(
                                                      id: selectedData.id,
                                                      time: selectedData.time,
                                                      date: selectedData.date);
                                                } else {
                                                  getIt<DBHelper>().update(
                                                      id: selectedData.id,
                                                      status: 1.obs);
                                                }
                                                controller.getSelectedList(
                                                    context: context);
                                              } else {
                                                controller.addTask(
                                                  context: context,
                                                  task: SelectedModels(
                                                      id: controller.userList
                                                          .where((element) =>
                                                              element.location
                                                                  .value ==
                                                              controller
                                                                  .dropdownlocation
                                                                  .value)
                                                          .toList()[index]
                                                          .id!,
                                                      status: 1.obs,
                                                      time: controller
                                                          .dropdownValue,
                                                      date: controller
                                                          .selectedDate),
                                                );
                                              }
                                            } else {
                                              controller.addTask(
                                                  task: SelectedModels(
                                                      id: controller.userList
                                                          .where((element) =>
                                                              element.location
                                                                  .value ==
                                                              controller
                                                                  .dropdownlocation
                                                                  .value)
                                                          .toList()[index]
                                                          .id!,
                                                      status: 1.obs,
                                                      time: controller
                                                          .dropdownValue,
                                                      date: controller
                                                          .selectedDate),
                                                  context: context);
                                            }
                                          },
                                          child: Obx(() {
                                            return Container(
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: controller.getColor(
                                                        id: controller.userList
                                                            .where((element) =>
                                                                element.location
                                                                    .value ==
                                                                controller
                                                                    .dropdownlocation
                                                                    .value)
                                                            .toList()[index]
                                                            .id!)
                                                    // color: (controller.userList
                                                    //             .where((element) =>
                                                    //                 element
                                                    //                     .location
                                                    //                     .value ==
                                                    //                 controller
                                                    //                     .dropdownlocation
                                                    //                     .value)
                                                    //             .toList()[index]
                                                    //             .isSelected
                                                    //             .value ==
                                                    //         0)
                                                    //     ? appTheme.unSelectedColor
                                                    //     : (controller.userList
                                                    //                 .where((element) =>
                                                    //                     element
                                                    //                         .location
                                                    //                         .value ==
                                                    //                     controller
                                                    //                         .dropdownlocation
                                                    //                         .value)
                                                    //                 .toList()[
                                                    //                     index]
                                                    //                 .isSelected
                                                    //                 .value ==
                                                    //             1)
                                                    //         ? appTheme
                                                    //             .SelectedColor
                                                    //         : Colors.red,
                                                    ),
                                                child: Center(
                                                    child: Text(
                                                  controller.userList
                                                      .where((element) =>
                                                          element
                                                              .location.value ==
                                                          controller
                                                              .dropdownlocation
                                                              .value)
                                                      .toList()[index]
                                                      .name
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20),
                                                )));
                                          }),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ));
          });
        });
  }
}
