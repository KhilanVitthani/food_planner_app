import 'package:get/get.dart';

import '../controllers/add_always_upvash_controller.dart';

class AddAlwaysUpvashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddAlwaysUpvashController>(
      () => AddAlwaysUpvashController(),
    );
  }
}
