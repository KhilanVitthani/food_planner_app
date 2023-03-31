import 'package:food_planner_app/constants/app_constant.dart';
import 'package:get/get.dart';

class AddAlwaysUpvashController extends GetxController {
  RxBool isFromHome = false.obs;

  @override
  void onInit() {
    if (Get.arguments != null) {
      isFromHome = Get.arguments[ArgumentConstant.isFromHome];
    }
    super.onInit();
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
