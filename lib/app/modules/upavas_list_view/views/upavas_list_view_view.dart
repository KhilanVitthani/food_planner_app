import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../constants/color_constant.dart';
import '../../../../constants/sizeConstant.dart';
import '../../../routes/app_pages.dart';
import '../controllers/upavas_list_view_controller.dart';

class UpavasListViewView extends GetView<UpavasListViewController> {
  const UpavasListViewView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<UpavasListViewController>(
        init: UpavasListViewController(),
        builder: (controller) {
          return Obx(() {
            return Scaffold(
                body: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(MySize.getWidth(4)),
                          child: Container(
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
                        ),
                        Padding(
                          padding: EdgeInsets.all(MySize.getWidth(4)),
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: appTheme.textGrayColor),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12))),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(right: 10.0, left: 10),
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
                                  controller.getSelectedList(context: context);
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
                                border:
                                    Border.all(color: appTheme.textGrayColor),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12))),
                            child: Padding(
                              padding: EdgeInsets.all(8),
                              child: DropdownButton<String>(
                                value: controller.dropDownLocation.value,
                                elevation: 16,
                                style: TextStyle(
                                    fontFamily: 'JosefinSans',
                                    color: appTheme.textGrayColor,
                                    fontWeight: FontWeight.w500),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
                                icon: Image.asset("assets/icons_image/down.png",
                                    height: 20),
                                underline: Container(
                                  // height: 2,
                                  color: Colors.white,
                                ),
                                onChanged: (String? value) {
                                  // This is called when the user selects an item.
                                  controller.dropDownLocation.value = value!;
                                  controller.getSelectedList(
                                      context: Get.context!);
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
                              Text("Active", style: TextStyle(fontSize: 15)),
                              SizedBox(
                                width: 5,
                              ),
                              CircleAvatar(
                                  radius: 5, backgroundColor: Colors.red),
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
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.0),
                          child:
                              (!isNullEmptyOrFalse(controller.attendanceList))
                                  ? GridView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 5,
                                              crossAxisSpacing: 5,
                                              mainAxisSpacing: 5),
                                      itemCount: controller.tempList.length,
                                      itemBuilder: (context, index) {
                                        return Obx(() {
                                          return Container(
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.red),
                                              child: Center(
                                                  child: Text(
                                                controller.tempList[index].id
                                                    .toString(),
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20),
                                              )));
                                        });
                                      },
                                    )
                                  : Center(
                                      child: Text("No Data Found"),
                                    ),
                        ),
                      ),
                    )
                  ],
                ),
                Positioned(
                    bottom: 35,
                    child: InkWell(
                      onTap: () {
                        TimeOfDay day = TimeOfDay.now();

                        if (day.hour < 12) {
                          print('its morning');
                        } else {
                          print('its evening/night');
                        }
                        // Get.offAndToNamed(Routes.ADD_UPVAS);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  offset: Offset(0, 6),
                                  spreadRadius: 4,
                                  blurRadius: 40,
                                  color: appTheme.primaryTheme.withOpacity(0.2))
                            ],
                            color: appTheme.primaryTheme,
                            borderRadius:
                                BorderRadius.all(Radius.circular(12))),
                        height: 50,
                        width: 140,
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/icons_image/add.png",
                                height: 16,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                "Add Upvas",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14),
                              ),
                            ]),
                      ),
                    ))
              ],
            ));
          });
        });
  }
}
