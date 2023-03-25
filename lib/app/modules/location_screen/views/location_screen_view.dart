import 'package:flutter/material.dart';
import 'package:food_planner_app/constants/sizeConstant.dart';
import 'package:food_planner_app/db/db_helper.dart';
import 'package:food_planner_app/main.dart';

import 'package:get/get.dart';

import '../../../../constants/app_constant.dart';
import '../../../../constants/color_constant.dart';
import '../../../routes/app_pages.dart';
import '../controllers/location_screen_controller.dart';

class LocationScreenView extends GetView<LocationScreenController> {
  const LocationScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Obx(() {
      return WillPopScope(
        onWillPop: () async {
          if (controller.isFromLocation.isTrue) {
            Get.offAndToNamed(Routes.MAIN_SCREEN);
          }
          return await true;
        },
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              leading: (controller.isFromLocation == true)
                  ? InkWell(
                      onTap: () {
                        Get.offAndToNamed(Routes.MAIN_SCREEN);
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: appTheme.primaryTheme,
                      ),
                    )
                  : SizedBox(),
              title: Text(ArgumentConstant.chooeslocation,
                  style: TextStyle(color: Colors.black)),
              centerTitle: true,
              actions: [
                TextButton(
                  child: Text(
                    "Save",
                    style: TextStyle(color: appTheme.primaryTheme),
                  ),
                  onPressed: () async {
                    controller.selectedList.forEach((element) async {
                      if (controller.isFromLocation.isTrue) {
                        getIt<DBHelper>().updateLocation(
                            id: element.id!, location: element.location);
                      } else {
                        await controller.addTask(task: element);
                      }
                    });
                    box.write(ArgumentConstant.isFirstTime, true);
                    // print(box.read(ArgumentConstant.isFirstTime));
                    await Get.offAllNamed(Routes.MAIN_SCREEN);
                  },
                ),
              ],
            ),
            body: Padding(
                padding: EdgeInsets.all(MySize.getWidth(8)),
                child: ListView.builder(
                  itemCount: controller.selectedList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        children: [
                          Spacer(),
                          Text(
                            controller.selectedList[index].name.toString(),
                          ),
                          Spacer(),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Obx(() => Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Radio(
                                        value: controller.location[0],
                                        groupValue: controller
                                            .selectedList[index].location.value
                                            .toString(),
                                        onChanged: (value) {
                                          controller.selectedList[index]
                                              .location.value = value!;
                                        },
                                        activeColor: appTheme.primaryTheme,
                                      ),
                                      Text(
                                        "Kundal",
                                        style: TextStyle(
                                          color: (controller.selectedList[index]
                                                      .location.value ==
                                                  controller.location[0])
                                              ? appTheme.primaryTheme
                                              : Colors.black,
                                        ),
                                      ),
                                    ],
                                  )),
                              Obx(() => Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Radio(
                                        value: controller.location[1],
                                        groupValue: controller
                                            .selectedList[index].location.value
                                            .toString(),
                                        onChanged: (value) {
                                          controller.selectedList[index]
                                              .location.value = value!;
                                        },
                                        activeColor: appTheme.primaryTheme,
                                      ),
                                      Text(
                                        "Vadodara",
                                        style: TextStyle(
                                            color: (controller
                                                        .selectedList[index]
                                                        .location
                                                        .value ==
                                                    controller.location[1])
                                                ? appTheme.primaryTheme
                                                : Colors.black),
                                      ),
                                    ],
                                  )),
                              Obx(() => Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Radio(
                                        value: controller.location[2],
                                        groupValue: controller
                                            .selectedList[index].location.value
                                            .toString(),
                                        onChanged: (value) {
                                          controller.selectedList[index]
                                              .location.value = value!;
                                        },
                                        activeColor: appTheme.primaryTheme,
                                      ),
                                      Text(
                                        "Gam",
                                        style: TextStyle(
                                            color: (controller
                                                        .selectedList[index]
                                                        .location
                                                        .value ==
                                                    controller.location[2])
                                                ? appTheme.primaryTheme
                                                : Colors.black),
                                      ),
                                    ],
                                  )),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ))),
      );
    });
  }
}
