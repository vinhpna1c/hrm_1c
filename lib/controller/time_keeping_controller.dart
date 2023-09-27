import 'package:get/get.dart';
import 'package:hrm_1c/components/shift_table.dart';
import 'package:hrm_1c/controller/staff_data_controller.dart';
import 'package:hrm_1c/controller/user_controller.dart';

import '../models/contract.dart';
import '../services/api/api_handler.dart';
import '../utils/utils.dart';

class TimeKeepingController extends GetxController {
  RxList<DateTime> checkInDays = <DateTime>[].obs;
  RxList<List<DateTime>> checkInDatas = <List<DateTime>>[].obs;
  static final days_in_week_map = {
    "Monday": DateTime.monday,
    "Tuesday": DateTime.monday,
    "Wednesday": DateTime.monday,
    "Thursday": DateTime.monday,
    "Friday": DateTime.monday,
    "Saturday": DateTime.monday,
    "Sunday": DateTime.monday,
  };
  List<int> workPartTimeDays = [];

  static const personalCheckInDaysPath = "/V1/PersonalTimeKeeping";

  Future<List<DateTime>> getPersonalCheckInDays() async {
    final userController = Get.find<UserController>();
    var respond = await ApiHandler.getRequest(userController.username,
        userController.password, personalCheckInDaysPath);
    List<DateTime> checkIns = [];
    if (respond.statusCode == 200) {
      var data = respond.data["CheckInDays"] ?? [];
      for (var req in data) {
        checkIns.add(parseDateTimeFromStr(req['Date']!.toString(),
            format: 'dd.MM.yyyy hh:mm:ss')!);
      }
    }
    return checkIns;
  }

  // future developement
  Future<List<DateTime>> getMyCheckInByMonth({int? month}) async {
    List<DateTime> ret = [];

    return ret;
  }

  List<int> getWorkPartTimeDays() {
    final staffDataCtrl = Get.find<StaffDataController>();
    if (staffDataCtrl.contract.value!.contractType == "Part time") {
      workPartTimeDays.clear();
      for (var workday
          in staffDataCtrl.contract.value!.timeSheet ?? <TimeSheet>[]) {
        workPartTimeDays.add(days_in_week_map[workday.workDate] ?? 0);
      }
    }
    return workPartTimeDays;
  }
}
