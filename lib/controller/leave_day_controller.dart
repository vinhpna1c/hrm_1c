import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();
  RxString sectionLeave = "".obs;
  Rx<String?> leaveType = Rx(null);
  @override
  void onInit() {
    // TODO: implement onInit
    sectionLeave.value = SECTION_LEAVE_TYPES[0];
    leaveType.value = null;
    super.onInit();
  }
}
