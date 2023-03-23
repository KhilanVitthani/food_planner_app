import 'package:flutter/material.dart';
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
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: (controller.isFromLocation == true)
              ? InkWell(
                  onTap: () {
                    Get.back();
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
              child: Text("Save"),
              onPressed: () async {
                controller.selectedList.forEach((element) async {
                  await controller.addTask(task: element);
                });
                box.write(ArgumentConstant.isFirstTime, true);
                print(box.read(ArgumentConstant.isFirstTime));
                await Get.offAllNamed(Routes.MAIN_SCREEN);
              },
            ),
          ],
        ),
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              itemCount: controller.selectedList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(controller.selectedList[index].name.toString()),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Obx(() => Row(
                            children: [
                              Radio(
                                value: controller.location[0],
                                groupValue: controller
                                    .selectedList[index].location.value
                                    .toString(),
                                onChanged: (value) {
                                  controller.selectedList[index].location
                                      .value = value!;
                                },
                              ),
                              Text(
                                "Kundal",
                                style: TextStyle(
                                    color: (controller.selectedList[index]
                                                .location.value ==
                                            controller.location[0])
                                        ? Colors.blue
                                        : Colors.black),
                              ),
                            ],
                          )),
                      Obx(() => Row(
                            children: [
                              Radio(
                                value: controller.location[1],
                                groupValue: controller
                                    .selectedList[index].location.value
                                    .toString(),
                                onChanged: (value) {
                                  controller.selectedList[index].location
                                      .value = value!;
                                },
                              ),
                              Text(
                                "Vadodara",
                                style: TextStyle(
                                    color: (controller.selectedList[index]
                                                .location.value ==
                                            controller.location[1])
                                        ? Colors.blue
                                        : Colors.black),
                              ),
                            ],
                          )),
                      Obx(() => Row(
                            children: [
                              Radio(
                                value: controller.location[2],
                                groupValue: controller
                                    .selectedList[index].location.value
                                    .toString(),
                                onChanged: (value) {
                                  controller.selectedList[index].location
                                      .value = value!;
                                },
                              ),
                              Text(
                                "Gam",
                                style: TextStyle(
                                    color: (controller.selectedList[index]
                                                .location.value ==
                                            controller.location[2])
                                        ? Colors.blue
                                        : Colors.black),
                              ),
                            ],
                          )),
                    ],
                  ),
                );
              },
            )));
  }
}
