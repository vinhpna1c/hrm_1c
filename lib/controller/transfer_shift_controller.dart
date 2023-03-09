// ignore_for_file: non_constant_identifier_names, constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_1c/models/contract.dart';

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
}
