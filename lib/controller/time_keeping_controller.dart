import 'package:get/get.dart';
import 'package:hrm_1c/controller/staff_data_controller.dart';
import 'package:hrm_1c/controller/user_controller.dart';

import '../models/contract.dart';
import '../services/api/api_handler.dart';
import '../utils/utils.dart';

class TimeKeepingController extends GetxController {
  RxList<DateTime> checkInDays = <DateTime>[].obs;
  RxList<int> workPartTimeDays = <int>[].obs;

  static const personalCheckInDaysPath = "/V1/PersonalTimeKeeping";

  Future<void> getPersonalCheckInDays() async {
    final userController = Get.find<UserController>();
      var respond = await ApiHandler.getRequest(userController.username, userController.password,personalCheckInDaysPath);
      if (respond.statusCode == 200) {
        checkInDays.clear();
        var data = respond.data["CheckInDays"] ?? [];
        for (var req in data) {
          checkInDays.add(parseDateTimeFromStr(req['Date']!.toString(),format: 'dd.MM.yyyy hh:mm:ss')!);
        }
      }
  }

  Future<void> getWorkPartTimeDays() async {
    final staffDataCtrl = Get.find<StaffDataController>();
    if (staffDataCtrl.contract.value!.contractType == "Part time") {
      for (var workday in staffDataCtrl.contract.value!.timeSheet ??
          <TimeSheet>[]) {
        int weekday = -1;
        switch (workday.workDate ?? "") {
          case "Monday" :
            weekday = 1;
            break;
          case "Tuesday" :
            weekday = 2;
            break;
          case "Wednesday" :
            weekday = 3;
            break;
          case "Thursday" :
            weekday = 4;
            break;
          case "Friday" :
            weekday = 5;
            break;
          case "Saturday" :
            weekday = 6;
            break;
          case "Sunday" :
            weekday = 7;
            break;
        }
        workPartTimeDays.add(weekday);
      }
    }
  }
}