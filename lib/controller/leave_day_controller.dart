// ignore_for_file: camel_case_types, constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_1c/controller/user_controller.dart';
import 'package:hrm_1c/services/api/api_handler.dart';
import 'package:intl/intl.dart';

import '../models/leave_request.dart';
import '../utils/utils.dart';

enum CheckInDateType {
  WORK_DATE,
  OFF_DATE,
  ABSENT_DATE,
  LEAVE_DATE,
}

class LeaveDayController extends GetxController {
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

  RxList<DateTime> leaveDays = <DateTime>[].obs;

  RxList<LeaveRequest> leaveRequests = <LeaveRequest>[].obs;

  static const requestLeavePath = "/V1/RequestLeave";

  @override
  void onInit() {
    // TODO: implement onInit
    sectionLeave.value = SECTION_LEAVE_TYPES[0];
    leaveType.value = null;
    sessonType.value = SESSION_TYPES[0];
    super.onInit();
  }

  Future<void> getPersonalLeaveDay() async {
    final userController = Get.find<UserController>();
    DateFormat df = DateFormat("yyyyMMdd");
    var respond = await ApiHandler.getRequest(
        userController.username, userController.password, "/V1/PersonalLeave",
        params: {
          "Token": userController.identifyString,
          "FromDate": df.format(DateTime(2023, 1, 1)),
          "ToDate": df.format(DateTime(2023, 12, 31)),
        });
    if (respond.statusCode == 200) {
      leaveDays.clear();
      leaveRequests.clear();
      var data = respond.data["PersonalLeave"] ?? [];
      for (var req in data) {
        if (req['Status'] == "Approve") {
          DateTime startdate = parseDateTimeFromStr(req['FromDate']!.toString(),
              format: 'dd.MM.yyyy hh:mm:ss')!;
          DateTime enddate = parseDateTimeFromStr(req['ToDate']!.toString(),
              format: 'dd.MM.yyyy hh:mm:ss')!;
          while (startdate.isBefore(enddate.add(Duration(days: 1)))) {
            leaveDays.add(startdate);
            startdate = startdate.add(Duration(days: 1));
          }
        }
        leaveRequests.add(LeaveRequest.fromJson(req));
      }
    }
    print(leaveDays.length);
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

    var respond = await ApiHandler.postRequest(
        userController.username, userController.password, requestLeavePath,
        body: data);
    if (respond.statusCode == 200) {
      var data = respond.data.toString();
      if (data.toLowerCase().contains("success")) {
        return true;
      }
    }
    return false;
  }

  Future<bool> approveLeaveDay(String requestNumber) async {
    final userController = Get.find<UserController>();
    var respond = await ApiHandler.postRequest(
        userController.username, userController.password, "/V1/ApproveLeaveDay",
        body: {"Number": requestNumber});
    if (respond.statusCode == 200) {
      var data = respond.data.toString();
      if (data.toLowerCase().contains("success")) {
        return true;
      }
    }
    return false;
  }

  Future<bool> rejectLeaveDay(String requestNumber) async {
    final userController = Get.find<UserController>();
    var respond = await ApiHandler.postRequest(
        userController.username, userController.password, "/V1/RejectLeaveDay",
        body: {"Number": requestNumber});
    if (respond.statusCode == 200) {
      var data = respond.data.toString();
      if (data.toLowerCase().contains("success")) {
        return true;
      }
    }
    return false;
  }

  Future<bool> approveTransferShift(String requestNumber) async {
    final userController = Get.find<UserController>();
    var respond = await ApiHandler.postRequest(userController.username,
        userController.password, "/V1/ApproveTransferShift",
        body: {"Number": requestNumber});
    if (respond.statusCode == 200) {
      var data = respond.data.toString();
      if (data.toLowerCase().contains("success")) {
        return true;
      }
    }
    return false;
  }

  Future<bool> rejectTransferShift(String requestNumber) async {
    final userController = Get.find<UserController>();
    var respond = await ApiHandler.postRequest(userController.username,
        userController.password, "/V1/RejectTransferShift",
        body: {"Number": requestNumber});
    if (respond.statusCode == 200) {
      var data = respond.data.toString();
      if (data.toLowerCase().contains("success")) {
        return true;
      }
    }
    return false;
  }
}
