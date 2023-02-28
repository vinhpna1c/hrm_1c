import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_1c/controller/user_controller.dart';
import 'package:hrm_1c/services/api/api_handler.dart';
import 'package:intl/intl.dart';

class LeaveDayController extends GetxController {
  // ignore: constant_identifier_names
  static const LEAVE_TYPES = [
    "Annual Leave",
    "Unpaid Leave",
    "Mission",
    "Maternity Leave",
    "Bereavement",
    "Marriage Leave",
    "Sick Leave",
  ];
  static const SECTION_LEAVE_TYPES = ["FullDay", "HalfADay"];
  static const SESSION_TYPES = ["Morning", "Affternon"];

  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();
  final TextEditingController reasonController = TextEditingController();

  Rx<DateTime?> startDate = Rx(null);
  Rx<DateTime?> endDate = Rx(null);
  RxString sectionLeave = "".obs;
  Rx<String?> leaveType = Rx(null);
  RxString sessonType = "".obs;

  static const requestLeavePath = "/V1/RequestLeave";

  @override
  void onInit() {
    // TODO: implement onInit
    sectionLeave.value = SECTION_LEAVE_TYPES[0];
    leaveType.value = null;
    sessonType.value = SESSION_TYPES[0];
    super.onInit();
  }

  Future<bool> requestLeaveDay() async {
    final userController = Get.find<UserController>();
    Map<String, dynamic> data = {
      "UserName": userController.username,
      "LeaveType": leaveType.value,
      "Section": sectionLeave.value,
      "HalfADay": sessonType.value,
      "FromDate":
          DateFormat("yyyyMMdd").format(startDate.value ?? DateTime.now()),
      "ToDate": DateFormat("yyyyMMdd").format(endDate.value ?? DateTime.now()),
      "Reason": reasonController.text,
    };

    var respond = await ApiHandler.postRequest(requestLeavePath, body: data);
    if (respond.statusCode == 200) {
      var data = respond.data.toString();
      if (data.toLowerCase().contains("success")) {
        return true;
      }
    }
    return false;
  }
}
