import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../constants/app_constant.dart';
import '../../../../constants/color_constant.dart';
import '../../../../db/db_helper.dart';
import '../../../../main.dart';
import '../../../routes/app_pages.dart';
import '../controllers/add_always_upvash_controller.dart';

class AddAlwaysUpvashView extends GetWidget<AddAlwaysUpvashController> {
  const AddAlwaysUpvashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (controller.isFromHome.isTrue) {
          Get.offAndToNamed(Routes.MAIN_SCREEN);
        }
        if (controller.isFromLocation.isTrue) {
          Get.offAndToNamed(Routes.LOCATION_SCREEN);
        }
        return await true;
      },
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: (controller.isFromLocation.isTrue ||
                    controller.isFromHome.isTrue)
                ? InkWell(
                    onTap: () {
                      if (controller.isFromHome.isTrue) {
                        Get.offAndToNamed(Routes.MAIN_SCREEN);
                      } else {
                        Get.offAndToNamed(Routes.LOCATION_SCREEN, arguments: {
                          ArgumentConstant.isFromLocation: true,
                          ArgumentConstant.isFromHome: false,
                        });
                      }
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color: appTheme.primaryTheme,
                    ),
                  )
                : SizedBox(),
            title: Text(ArgumentConstant.addFullUpvas,
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
                    getIt<DBHelper>().updateIsSelected(
                        id: element.id!, isSelected: element.isSelected);
                    controller.deleteAttendance(userData: element);
                  });
                  box.write(ArgumentConstant.isFirstTime, true);
                  await Get.offAllNamed(Routes.MAIN_SCREEN);
                },
              ),
            ],
          ),
          body: Obx(() {
            return (controller.hasData.isFalse)
                ? Center(
                    child:
                        CircularProgressIndicator(color: appTheme.primaryTheme),
                  )
                : Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text("${ArgumentConstant.addFullUpvasCount} :- ",
                                style: TextStyle(fontSize: 16)),
                            Text(
                                controller.selectedList
                                    .where((p0) => p0.isSelected == 1)
                                    .toList()
                                    .length
                                    .toString(),
                                style: TextStyle(fontSize: 16))
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: ListView.builder(
                            itemCount: controller.selectedList.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(controller.selectedList[index].name
                                    .toString()),
                                trailing: Checkbox(
                                  activeColor: appTheme.primaryTheme,
                                  value: (controller
                                              .selectedList[index].isSelected ==
                                          0)
                                      ? false
                                      : true,
                                  onChanged: (value) {
                                    controller.selectedList[index].isSelected
                                        .value = (value!) ? 1 : 0;
                                    controller.selectedList.refresh();
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                      )
                    ],
                  );
          })),
    );
  }
}
