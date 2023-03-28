import 'dart:convert';

import 'package:get/get.dart';
import 'package:hrm_1c/controller/user_controller.dart';
import 'package:hrm_1c/models/personal_information.dart';
import 'package:hrm_1c/models/transfer_shift_request.dart';
import 'package:hrm_1c/services/api/api_handler.dart';
import 'package:hrm_1c/utils/utils.dart';
import 'package:intl/intl.dart';

import '../models/leave_request.dart';

class AdminDataController extends GetxController {
  RxList<LeaveRequest> leaveRequests = <LeaveRequest>[].obs;
  RxList<PersonalInformation> employees = <PersonalInformation>[].obs;
  RxList<TransferShiftRequest> transferRequests = <TransferShiftRequest>[].obs;

  static const allEmployeePath = "/V1/AllEmployee";
  static const allTransferShiftPath = "/V1/AllTransferShift";

  Future<void> getAllLeaveRequest(
      {DateTime? startTime, DateTime? endTime}) async {
    final userController = Get.find<UserController>();
    startTime ??= getFirstDayOfWeek(DateTime.now());
    endTime ??= startTime.add(const Duration(days: 7));
    DateFormat df = DateFormat("yyyyMMdd");
    if (userController.accountType == AccountType.ADMINISTRATOR) {
      // print(jsonEncode({
      //   "Token": userController.identifyString,
      //   "FromDate": df.format(startTime),
      //   "ToDate": df.format(endTime),
      // }));
      var respond = await ApiHandler.getRequest(userController.username, userController.password,"/V1/AllLeave", params: {
        "Token": userController.identifyString,
        "FromDate": df.format(startTime),
        "ToDate": df.format(endTime),
      });
      if (respond.statusCode == 200) {
        leaveRequests.clear();
        var data = respond.data["AllLeave"] ?? [];
        for (var req in data) {
          leaveRequests.add(LeaveRequest.fromJson(req));
        }
        print("Leave request get: ${leaveRequests.length}");
      }
    }
  }

  Future<void> getAllEmployeeList() async {
    final userController = Get.find<UserController>();
    if (userController.accountType == AccountType.ADMINISTRATOR) {
      var respond = await ApiHandler.getRequest(userController.username, userController.password,allEmployeePath,
          params: {"Token": userController.identifyString});
      if (respond.statusCode == 200) {
        employees.clear();
        var data = respond.data["Information"] ?? [];
        for (var req in data) {
          employees.add(PersonalInformation.fromJson(req));
        }
      }
    }
  }

  Future<void> getAllTransferRequest(
      {DateTime? startTime, DateTime? endTime}) async {
    final userController = Get.find<UserController>();
    startTime ??= getFirstDayOfWeek(DateTime.now());
    endTime ??= startTime.add(const Duration(days: 7));
    DateFormat df = DateFormat("yyyyMMdd");
    if (userController.accountType == AccountType.ADMINISTRATOR) {
      print(jsonEncode({
        "Token": userController.identifyString,
        "FromDate": df.format(startTime),
        "ToDate": df.format(endTime),
      }));
      var respond = await ApiHandler.getRequest(userController.username, userController.password,allTransferShiftPath, params: {
        "Token": userController.identifyString,
        "FromDate": df.format(startTime),
        "ToDate": df.format(endTime),
      });
      if (respond.statusCode == 200) {
        transferRequests.clear();
        var data = respond.data["AllTransferShift"] ?? [];

        for (var req in data) {
          transferRequests.add(TransferShiftRequest.fromJson(req));
        }
        print("Transfer request get: ${transferRequests.length}");
      }
    }
  }
}
