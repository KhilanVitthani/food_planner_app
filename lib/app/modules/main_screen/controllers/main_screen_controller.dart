import 'package:food_planner_app/constants/app_constant.dart';
import 'package:get/get.dart';

class MainScreenController extends GetxController {
  RxInt SelectedTab = 0.obs;
  List<String> choices = <String>[
    ArgumentConstant.addFullUpvas,
    ArgumentConstant.chooeslocation
  ];
  @override
  Future<void> onInit() async {
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
