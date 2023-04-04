import 'package:flutter/material.dart';
import 'package:food_planner_app/constants/app_constant.dart';
import 'package:food_planner_app/constants/sizeConstant.dart';
import 'package:food_planner_app/models/selected_model.dart';

import 'package:get/get.dart';

import '../../../../constants/color_constant.dart';
import '../../../../db/db_helper.dart';
import '../../../../main.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    MySize().init(context);
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
                                padding: EdgeInsets.all(MySize.getWidth(4)),
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: appTheme.textGrayColor),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(12))),
                                  child: Padding(
                                    padding: EdgeInsets.all(MySize.getWidth(8)),
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
                                padding: EdgeInsets.all(MySize.getWidth(4)),
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
                                padding: EdgeInsets.all(MySize.getWidth(4)),
                                child: Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: appTheme.textGrayColor),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(12))),
                                  child: Padding(
                                    padding: EdgeInsets.all(MySize.getWidth(8)),
                                    child: DropdownButton<String>(
                                      value: controller.dropDownLocation.value,
                                      elevation: 16,
                                      style: TextStyle(
                                          fontFamily: 'JosefinSans',
                                          color: appTheme.textGrayColor,
                                          fontWeight: FontWeight.w500),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(12)),
                                      icon: Padding(
                                        padding: EdgeInsets.only(left: 00.0),
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
                                        controller.dropDownLocation.value =
                                            value!;
                                        controller.getSelectedList(
                                            context: context);
                                        controller.alwaysUpavas(
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
                          Padding(
                            padding: EdgeInsets.only(
                                left: MySize.getWidth(8),
                                right: MySize.getWidth(8),
                                bottom: MySize.getHeight(8),
                                top: MySize.getHeight(8)),
                            child: Row(
                              children: [
                                Text(ArgumentConstant.totalUpvas,
                                    style: TextStyle(
                                      fontSize: 15,
                                    )),
                                SizedBox(
                                  width: 5,
                                ),
                                CircleAvatar(
                                    radius: 5, backgroundColor: Colors.red),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  controller.locationsAttendanceList
                                      .where((p0) => p0.status == 2)
                                      .toList()
                                      .length
                                      .toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Spacer(),
                                Text(ArgumentConstant.totalJamnar,
                                    style: TextStyle(
                                      fontSize: 15,
                                    )),
                                SizedBox(
                                  width: 5,
                                ),
                                CircleAvatar(
                                    radius: 5,
                                    backgroundColor: appTheme.SelectedColor),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  controller.locationsAttendanceList
                                      .where((p0) => p0.status == 1)
                                      .toList()
                                      .length
                                      .toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: appTheme.SelectedColor),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5.0),
                              child: SingleChildScrollView(
                                physics: BouncingScrollPhysics(),
                                child: Column(
                                  children: [
                                    (controller.userList
                                            .where((element) =>
                                                element.location.value ==
                                                controller
                                                    .dropDownLocation.value)
                                            .toList()
                                            .isEmpty)
                                        ? Container(
                                            height: MySize.screenHeight,
                                            child: Text("No Data Found!"))
                                        : GridView.builder(
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 2,
                                                    childAspectRatio: 3,
                                                    crossAxisSpacing: 5,
                                                    mainAxisSpacing: 5),
                                            itemCount: controller.userList
                                                .where((element) =>
                                                    element.location.value ==
                                                    controller
                                                        .dropDownLocation.value)
                                                .toList()
                                                .length,
                                            itemBuilder: (context, index) {
                                              return GestureDetector(
                                                onTap: () {
                                                  if (controller.userList
                                                          .where((element) =>
                                                              element.location
                                                                  .value ==
                                                              controller
                                                                  .dropDownLocation
                                                                  .value)
                                                          .toList()[index]
                                                          .isSelected
                                                          .value !=
                                                      1) {
                                                    if (controller
                                                        .attendanceList
                                                        .isNotEmpty) {
                                                      int mId = controller
                                                          .userList
                                                          .where((element) =>
                                                              element.location
                                                                  .value ==
                                                              controller
                                                                  .dropDownLocation
                                                                  .value)
                                                          .toList()[index]
                                                          .id!;
                                                      // print("object");
                                                      bool isPresent =
                                                          controller
                                                              .attendanceList
                                                              .any((element) =>
                                                                  element.id ==
                                                                  mId);
                                                      if (isPresent) {
                                                        SelectedModels
                                                            selectedData =
                                                            controller
                                                                .attendanceList
                                                                .where((p0) =>
                                                                    p0.id ==
                                                                    mId)
                                                                .first;
                                                        if (selectedData
                                                                .status ==
                                                            1) {
                                                          getIt<DBHelper>()
                                                              .updateTime(
                                                                  id:
                                                                      selectedData
                                                                          .id,
                                                                  time:
                                                                      selectedData
                                                                          .time,
                                                                  date:
                                                                      selectedData
                                                                          .date,
                                                                  status:
                                                                      2.obs);
                                                        } else if (selectedData
                                                                .status ==
                                                            2) {
                                                          getIt<DBHelper>().delete(
                                                              id: selectedData
                                                                  .id,
                                                              time: selectedData
                                                                  .time,
                                                              date: selectedData
                                                                  .date);
                                                        } else {
                                                          getIt<DBHelper>()
                                                              .update(
                                                                  id:
                                                                      selectedData
                                                                          .id,
                                                                  status:
                                                                      1.obs);
                                                        }
                                                        controller
                                                            .getSelectedList(
                                                                context:
                                                                    context);
                                                      } else {
                                                        controller.addTask(
                                                          context: context,
                                                          task: SelectedModels(
                                                              id: controller
                                                                  .userList
                                                                  .where((element) =>
                                                                      element
                                                                          .location
                                                                          .value ==
                                                                      controller
                                                                          .dropDownLocation
                                                                          .value)
                                                                  .toList()[
                                                                      index]
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
                                                              id: controller
                                                                  .userList
                                                                  .where((element) =>
                                                                      element
                                                                          .location
                                                                          .value ==
                                                                      controller
                                                                          .dropDownLocation
                                                                          .value)
                                                                  .toList()[
                                                                      index]
                                                                  .id!,
                                                              status: 1.obs,
                                                              time: controller
                                                                  .dropdownValue,
                                                              date: controller
                                                                  .selectedDate),
                                                          context: context);
                                                    }
                                                  } else {}
                                                },
                                                child: Obx(() {
                                                  return Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(12),
                                                          color: controller.getColor(
                                                              id: controller
                                                                  .userList
                                                                  .where((element) =>
                                                                      element
                                                                          .location
                                                                          .value ==
                                                                      controller
                                                                          .dropDownLocation
                                                                          .value)
                                                                  .toList()[
                                                                      index]
                                                                  .id!)),
                                                      child: Center(
                                                          child: Text(
                                                        controller.userList
                                                            .where((element) =>
                                                                element.location
                                                                    .value ==
                                                                controller
                                                                    .dropDownLocation
                                                                    .value)
                                                            .toList()[index]
                                                            .name
                                                            .toString(),
                                                        style: TextStyle(
                                                            color: controller.getTextColor(
                                                                id: controller
                                                                    .userList
                                                                    .where((element) =>
                                                                        element
                                                                            .location
                                                                            .value ==
                                                                        controller
                                                                            .dropDownLocation
                                                                            .value)
                                                                    .toList()[
                                                                        index]
                                                                    .id!),
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
