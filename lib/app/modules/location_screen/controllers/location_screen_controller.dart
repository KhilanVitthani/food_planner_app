import 'package:food_planner_app/db/db_helper.dart';
import 'package:food_planner_app/models/user.dart';
import 'package:get/get.dart';

import '../../../../main.dart';

class LocationScreenController extends GetxController {
  RxList location = ["Kundal", "Vadodara", "Gam"].obs;
  RxList<UserModels> selectedList = RxList<UserModels>([
    UserModels(name: "1".obs, location: "Kundal".obs),
    UserModels(name: "2".obs, location: "Kundal".obs),
    UserModels(name: "3".obs, location: "Kundal".obs),
    UserModels(name: "4".obs, location: "Kundal".obs),
    UserModels(name: "5".obs, location: "Kundal".obs),
    UserModels(name: "6".obs, location: "Kundal".obs),
    UserModels(name: "7".obs, location: "Kundal".obs),
    UserModels(name: "8".obs, location: "Kundal".obs),
    UserModels(name: "9".obs, location: "Kundal".obs),
    UserModels(name: "10".obs, location: "Kundal".obs),
    UserModels(name: "11".obs, location: "Kundal".obs),
    UserModels(name: "12".obs, location: "Kundal".obs),
    UserModels(name: "13".obs, location: "Kundal".obs),
    UserModels(name: "14".obs, location: "Kundal".obs),
    UserModels(name: "15".obs, location: "Kundal".obs),
    UserModels(name: "16".obs, location: "Kundal".obs),
    UserModels(name: "17".obs, location: "Kundal".obs),
    UserModels(name: "18".obs, location: "Kundal".obs),
    UserModels(name: "19".obs, location: "Kundal".obs),
    UserModels(name: "20".obs, location: "Kundal".obs),
    UserModels(name: "21".obs, location: "Kundal".obs),
    UserModels(name: "22".obs, location: "Kundal".obs),
    UserModels(name: "23".obs, location: "Kundal".obs),
    UserModels(name: "24".obs, location: "Kundal".obs),
    UserModels(name: "25".obs, location: "Kundal".obs),
    UserModels(name: "26".obs, location: "Kundal".obs),
    UserModels(name: "27".obs, location: "Kundal".obs),
    UserModels(name: "28".obs, location: "Kundal".obs),
    UserModels(name: "29".obs, location: "Kundal".obs),
    UserModels(name: "30".obs, location: "Kundal".obs),
    UserModels(name: "31".obs, location: "Kundal".obs),
    UserModels(name: "32".obs, location: "Kundal".obs),
    UserModels(name: "33".obs, location: "Kundal".obs),
    UserModels(name: "34".obs, location: "Kundal".obs),
    UserModels(name: "35".obs, location: "Kundal".obs),
    UserModels(name: "36".obs, location: "Kundal".obs),
    UserModels(name: "37".obs, location: "Kundal".obs),
    UserModels(name: "38".obs, location: "Kundal".obs),
    UserModels(name: "39".obs, location: "Kundal".obs),
    UserModels(name: "40".obs, location: "Kundal".obs),
    UserModels(name: "41".obs, location: "Kundal".obs),
    UserModels(name: "42".obs, location: "Kundal".obs),
    UserModels(name: "43".obs, location: "Kundal".obs),
    UserModels(name: "44".obs, location: "Kundal".obs),
    UserModels(name: "45".obs, location: "Kundal".obs),
    UserModels(name: "46".obs, location: "Kundal".obs),
    UserModels(name: "47".obs, location: "Kundal".obs),
    UserModels(name: "48".obs, location: "Kundal".obs),
    UserModels(name: "49".obs, location: "Kundal".obs),
    UserModels(name: "50".obs, location: "Kundal".obs),
    UserModels(name: "51".obs, location: "Kundal".obs),
    UserModels(name: "52".obs, location: "Kundal".obs),
    UserModels(name: "53".obs, location: "Kundal".obs),
    UserModels(name: "54".obs, location: "Kundal".obs),
    UserModels(name: "55".obs, location: "Kundal".obs),
    UserModels(name: "56".obs, location: "Kundal".obs),
    UserModels(name: "57".obs, location: "Kundal".obs),
    UserModels(name: "58".obs, location: "Kundal".obs),
    UserModels(name: "59".obs, location: "Kundal".obs),
    UserModels(name: "60".obs, location: "Kundal".obs),
    UserModels(name: "61".obs, location: "Kundal".obs),
    UserModels(name: "62".obs, location: "Kundal".obs),
    UserModels(name: "63".obs, location: "Kundal".obs),
    UserModels(name: "64".obs, location: "Kundal".obs),
    UserModels(name: "65".obs, location: "Kundal".obs),
    UserModels(name: "P1".obs, location: "Kundal".obs),
    UserModels(name: "P2".obs, location: "Kundal".obs),
    UserModels(name: "P3".obs, location: "Kundal".obs),
    UserModels(name: "P4".obs, location: "Kundal".obs),
    UserModels(name: "P5".obs, location: "Kundal".obs),
    UserModels(name: "P6".obs, location: "Kundal".obs),
    UserModels(name: "P7".obs, location: "Kundal".obs),
    UserModels(name: "P8".obs, location: "Kundal".obs),
    UserModels(name: "P9".obs, location: "Kundal".obs),
    UserModels(name: "P10".obs, location: "Kundal".obs),
    UserModels(name: "S1".obs, location: "Kundal".obs),
    UserModels(name: "S2".obs, location: "Kundal".obs),
    UserModels(name: "S3".obs, location: "Kundal".obs),
    UserModels(name: "S4".obs, location: "Kundal".obs),
    UserModels(name: "S5".obs, location: "Kundal".obs),
    UserModels(name: "S6".obs, location: "Kundal".obs),
    UserModels(name: "S7".obs, location: "Kundal".obs),
    UserModels(name: "S8".obs, location: "Kundal".obs),
    UserModels(name: "S9".obs, location: "Kundal".obs),
    UserModels(name: "S10".obs, location: "Kundal".obs),
    UserModels(name: "S11".obs, location: "Kundal".obs),
    UserModels(name: "S12".obs, location: "Kundal".obs),
    UserModels(name: "S13".obs, location: "Kundal".obs),
    UserModels(name: "S14".obs, location: "Kundal".obs),
    UserModels(name: "S15".obs, location: "Kundal".obs),
    UserModels(name: "S16".obs, location: "Kundal".obs),
    UserModels(name: "S17".obs, location: "Kundal".obs),
    UserModels(name: "M18".obs, location: "Kundal".obs),
    UserModels(name: "M19".obs, location: "Kundal".obs),
    UserModels(name: "M20".obs, location: "Kundal".obs),
    UserModels(name: "M21".obs, location: "Kundal".obs),
    UserModels(name: "M22".obs, location: "Kundal".obs),
    UserModels(name: "SE1".obs, location: "Kundal".obs),
    UserModels(name: "SE2".obs, location: "Kundal".obs),
    UserModels(name: "SE3".obs, location: "Kundal".obs),
    UserModels(name: "SE4".obs, location: "Kundal".obs),
    UserModels(name: "SE5".obs, location: "Kundal".obs),
    UserModels(name: "SE6".obs, location: "Kundal".obs),
    UserModels(name: "SE7".obs, location: "Kundal".obs),
    UserModels(name: "SE8".obs, location: "Kundal".obs),
  ]);
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  Future<int> addTask({UserModels? task}) async {
    return await getIt<DBHelper>().insertUserTable(task).then((value) {
      return 1;
    });
  }

  @override
  void onClose() {
    super.onClose();
  }
}
