import 'package:get/get.dart';

import '../controllers/add_upvas_controller.dart';

class AddUpvasBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddUpvasController>(
      () => AddUpvasController(),
    );
  }
}
