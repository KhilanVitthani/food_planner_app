import 'package:flutter/material.dart';
import 'package:food_planner_app/app/modules/upavas_list_view/views/upavas_list_view_view.dart';

import 'package:get/get.dart';

import '../../../../constants/app_constant.dart';
import '../../../../constants/color_constant.dart';
import '../../../routes/app_pages.dart';
import '../../home/views/home_view.dart';
import '../controllers/main_screen_controller.dart';

class MainScreenView extends GetWidget<MainScreenController> {
  const MainScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                  onPressed: () {
                    Get.toNamed(Routes.LOCATION_SCREEN,
                        arguments: {ArgumentConstant.isFromLocation: true});
                  },
                  icon: Icon(
                    Icons.settings,
                    color: appTheme.primaryTheme,
                  ))
            ],
            backgroundColor: Colors.white,
            centerTitle: true,
            title: Text(
              "Daily Food Planner",
              style: TextStyle(
                  color: appTheme.primaryTheme, fontWeight: FontWeight.bold),
            ),
            elevation: 0,
            bottom: TabBar(
                indicatorColor: appTheme.primaryTheme,
                onTap: (value) {
                  controller.SelectedTab.value = value;
                },
                // unselectedLabelColor: appTheme.textGrayColor,
                tabs: [
                  Tab(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      (controller.SelectedTab.value == 0)
                          ? Image.asset("assets/icons_image/home_select.png",
                              height: 20)
                          : Image.asset("assets/icons_image/home_unselect.png",
                              height: 20),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Home",
                        style: TextStyle(
                            color: controller.SelectedTab.value == 0
                                ? appTheme.primaryTheme
                                : appTheme.textGrayColor),
                      ),
                    ],
                  )),
                  Tab(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      (controller.SelectedTab.value == 0)
                          ? Image.asset("assets/icons_image/menu_unselect.png",
                              height: 15)
                          : Image.asset("assets/icons_image/menu_select.png",
                              height: 15),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        ArgumentConstant.upvaslist,
                        style: TextStyle(
                            color: controller.SelectedTab.value == 0
                                ? appTheme.textGrayColor
                                : appTheme.primaryTheme),
                      ),
                    ],
                  )),
                ]),
          ),
          body: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              children: [HomeView(), const UpavasListViewView()]),
        ),
      );
    });
  }
}
