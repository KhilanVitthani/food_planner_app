import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../constants/color_constant.dart';
import '../../../routes/app_pages.dart';
import '../controllers/add_always_upvash_controller.dart';

class AddAlwaysUpvashView extends GetView<AddAlwaysUpvashController> {
  const AddAlwaysUpvashView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (controller.isFromHome.isTrue) {
          Get.offAndToNamed(Routes.MAIN_SCREEN);
        }
        return await true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('AddAlwaysUpvashView'),
          leading: (controller.isFromHome == true)
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
          centerTitle: true,
        ),
        body: Center(
          child: Text(
            'AddAlwaysUpvashView is working',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
