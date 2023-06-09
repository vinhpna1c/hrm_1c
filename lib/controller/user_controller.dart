import 'dart:convert';

import 'package:get/get.dart';
import 'package:hrm_1c/controller/leave_day_controller.dart';
import 'package:hrm_1c/models/time_keeping.dart';
import 'package:hrm_1c/services/api/api_handler.dart';
import 'package:hrm_1c/controller/auth_controller.dart';
import 'package:hrm_1c/controller/check_in_controller.dart';
import 'package:hrm_1c/models/personal_information.dart';

enum AccountType { ADMINISTRATOR, STAFF, MANAGER }

class UserController extends GetxController {
  String identifyString = "87bd2ef0-b196-11ed-b0ed-00155dda4405";
  String username = "";
  String password = "";
  AccountType accountType = AccountType.STAFF;
  PersonalInformation? userInformation;

  Future<void> getUserInformation() async {
    final checkInCtrl = Get.find<CheckInController>();
    var respond = await ApiHandler.getRequest(username, password,"/V1/Information");
    if (respond.statusCode == 200) {
      userInformation = PersonalInformation.fromJson(
          respond.data['Metadata'][0]['PersonalInformation']);
      print(userInformation!.toJson());
      checkInCtrl.timeKeeping.value = userInformation!.timeKeeping;
    }
  }

  //check account is admin
  //ensure check account is valid
  Future<bool> isAdminAccount() async {
    var respond =
        await ApiHandler.postRequest(username, password, CheckInController.allLeavePath, body: {
      "UserName": username,
      "Password": password,
    });

    if (respond.statusCode != 200) {
      return false;
    }
    print(jsonEncode(respond.data));
    return respond.data["Identifier"] != null;
  }

  @override
  void onClose() {
    // TODO: implement onClose
    identifyString = "";
    username = "";
    password = "";
    accountType = AccountType.STAFF;
    super.onClose();
  }
}
