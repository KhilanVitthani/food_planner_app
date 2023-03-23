import 'package:get/get.dart';

import '../controllers/upavas_list_view_controller.dart';

class UpavasListViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UpavasListViewController>(
      () => UpavasListViewController(),
    );
  }
}
