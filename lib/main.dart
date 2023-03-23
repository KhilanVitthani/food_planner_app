import 'package:flutter/material.dart';
import 'package:food_planner_app/constants/app_module.dart';
import 'package:food_planner_app/db/db_helper.dart';

import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';

import 'app/routes/app_pages.dart';

final getIt = GetIt.instance;
GetStorage box = GetStorage();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setUp();
  await GetStorage.init();
  await getIt<DBHelper>().initDb();
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'JosefinSans',
      ),
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
