// ignore_for_file: non_constant_identifier_names, constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_1c/controller/user_controller.dart';
import 'package:hrm_1c/models/contract.dart';
import 'package:intl/intl.dart';

import '../models/transfer_shift_request.dart';
import '../services/api/api_handler.dart';
import '../utils/utils.dart';

enum TransferShiftStatus {
  UNSELECTED_SHIFT,
  UNSELECTED_NOT_SHIFT,
  SELECTED_SHIFT,
  SELECTED_NOT_SHIFT,
}

//Map with TransferShiftStatus enum
final TransferShiftStatusColor = [
  Colors.green,
  Colors.white,
  Colors.green.shade400,
  Colors.yellow
];

class TransferShiftController extends GetxController {
  static const DAYS_IN_WEEK = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday"
  ];

  static const SECTION_TYPES = ["Morning", "Afternoon", "Full day"];

  final TextEditingController mainShiftController = TextEditingController();
  final TextEditingController transferShiftController = TextEditingController();
  final TextEditingController reasonController = TextEditingController();

  static const requestTransferShiftPath = "/V1/RequestTransferShift";

  Rx<DateTime> firstDay = DateTime.now().obs;

  Rx<DateTime?> mainShift = Rx(null);
  Rx<DateTime?> transferShift = Rx(null);
  Rx<DateTime?> transferShift1 = Rx(null);
  RxString sectionMain = "".obs;
  RxString sectionTransfer = "".obs;
  RxString sectionTransfer1 = "".obs;
  List<RxInt> cellTypes = [];
  // Rx<String?> leaveType = Rx(null);
  // RxString sessonType = "".obs;

  //RxList<DateTime> transferDays = <DateTime>[].obs;

  RxList<TransferShiftRequest> transferRequests = <TransferShiftRequest>[].obs;

  RxMap<String, List<TransferShiftStatus>> requestMap =
      <String, List<TransferShiftStatus>>{}.obs;

  @override
  void onInit() {
    requestMap.clear();
    for (var day in DAYS_IN_WEEK) {
      requestMap[day] = [
        TransferShiftStatus.UNSELECTED_NOT_SHIFT,
        TransferShiftStatus.UNSELECTED_NOT_SHIFT,
      ];
    }
    super.onInit();
  }

  Future<void> getPersonalTransferShift() async {
    final userController = Get.find<UserController>();
    DateFormat df = DateFormat("yyyyMMdd");
    var respond = await ApiHandler.getRequest(userController.username, userController.password,"/V1/PersonalLeave", params: {
      "Token": userController.identifyString,
      "FromDate": df.format(DateTime(2023,1,1)),
      "ToDate": df.format(DateTime(2023,12,31)),
    });
    if (respond.statusCode == 200) {
      transferRequests.clear();
      var data = respond.data["PersonalTransferShift"] ?? [];
      for (var req in data) {
        transferRequests.add(TransferShiftRequest.fromJson(req));
      }
    }
    print(transferRequests.length);
  }

  void setTimeSheets(List<TimeSheet>? timeSheets) {
    if (timeSheets != null) {
      for (var timeSheet in timeSheets!) {
        if (requestMap[timeSheet.workDate ?? ""] != null) {
          if ((timeSheet.section ?? "").toLowerCase().contains('morning')) {
            requestMap[timeSheet.workDate ?? ""]![0] =
                TransferShiftStatus.UNSELECTED_SHIFT;
          } else if ((timeSheet.section ?? "")
              .toLowerCase()
              .contains('afternoon')) {
            requestMap[timeSheet.workDate ?? ""]![1] =
                TransferShiftStatus.UNSELECTED_SHIFT;
          }
        }
      }
    }
  }

  void setCellSelected(String day, int index) {
    print(day + "-" + index.toString());
  }

  Future<bool> requestTransferShift() async {
    final userController = Get.find<UserController>();
    Map<String, dynamic> data = {
      "ShiftMain": DateFormat("yyyyMMdd").format(mainShift.value ?? DateTime.now()),
      "SectionMain": sectionMain.value,
      "TransferShift": DateFormat("yyyyMMdd").format(transferShift.value ?? DateTime.now()),
      "SectionTransfer": sectionTransfer.value,
      "TransferShift2": DateFormat("yyyyMMdd").format(transferShift1.value ?? DateTime.now()),
      "SectionTransfer2": sectionTransfer1.value,
      "Description": reasonController.text,
    };

    var respond = await ApiHandler.postRequest(userController.username, userController.password, requestTransferShiftPath, body: data);
    if (respond.statusCode == 200) {
      var data = respond.data.toString();
      if (data.toLowerCase().contains("success")) {
        return true;
      }
    }
    print(data);
    return false;
  }

}
