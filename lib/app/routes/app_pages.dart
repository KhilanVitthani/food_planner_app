import 'package:get/get.dart';

import '../../constants/app_constant.dart';
import '../../constants/sizeConstant.dart';
import '../../main.dart';
import '../modules/add_always_upvash/bindings/add_always_upvash_binding.dart';
import '../modules/add_always_upvash/views/add_always_upvash_view.dart';
import '../modules/add_upvas/bindings/add_upvas_binding.dart';
import '../modules/add_upvas/views/add_upvas_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/location_screen/bindings/location_screen_binding.dart';
import '../modules/location_screen/views/location_screen_view.dart';
import '../modules/main_screen/bindings/main_screen_binding.dart';
import '../modules/main_screen/views/main_screen_view.dart';
import '../modules/upavas_list_view/bindings/upavas_list_view_binding.dart';
import '../modules/upavas_list_view/views/upavas_list_view_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static String INITIAL =
      (isNullEmptyOrFalse(box.read(ArgumentConstant.isFirstTime)))
          ? Routes.LOCATION_SCREEN
          : Routes.MAIN_SCREEN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOCATION_SCREEN,
      page: () => const LocationScreenView(),
      binding: LocationScreenBinding(),
    ),
    GetPage(
      name: _Paths.MAIN_SCREEN,
      page: () => const MainScreenView(),
      binding: MainScreenBinding(),
    ),
    GetPage(
      name: _Paths.UPAVAS_LIST_VIEW,
      page: () => const UpavasListViewView(),
      binding: UpavasListViewBinding(),
    ),
    GetPage(
      name: _Paths.ADD_UPVAS,
      page: () => const AddUpvasView(),
      binding: AddUpvasBinding(),
    ),
    GetPage(
      name: _Paths.ADD_ALWAYS_UPVASH,
      page: () => const AddAlwaysUpvashView(),
      binding: AddAlwaysUpvashBinding(),
    ),
  ];
}
