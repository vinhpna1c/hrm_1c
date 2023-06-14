import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hrm_1c/controller/admin_data_controller.dart';
import 'package:hrm_1c/controller/geo_controller.dart';
import 'package:hrm_1c/controller/staff_data_controller.dart';
import 'package:hrm_1c/services/api/api_handler.dart';
import 'package:hrm_1c/controller/user_controller.dart';

import 'check_in_controller.dart';

class AuthController extends GetxController {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _checkInController = Get.put(CheckInController());
  final _geoController = Get.put(GeoController());

  final TextEditingController oldPassController = TextEditingController();
  final TextEditingController newPassController = TextEditingController();
  final TextEditingController renewPassController = TextEditingController();

  static const authPath = "/V1/Employee";
  static const changePasswordPath = "/V1/ChangePassword";

  Future<int> signIn() async {
    final userController = Get.find<UserController>();
    // String username = "longpt";
    // String password = "123456";
    String username = usernameController.text;
    String password = passwordController.text;

    var respond = await ApiHandler.postRequest(
      username,
      password,
      authPath,
    );
    if (respond.statusCode == 200) {
      var respondBody = respond.data;
      //userController.identifyString = respondBody['Identifier'] ?? "";
      String accountType = respondBody['AccountType'] ?? "";
      userController.username = username;
      userController.password = password;
      if (accountType.toLowerCase().contains("admin")) {
        userController.accountType = AccountType.ADMINISTRATOR;
        await initAdminData();
      } else {
        userController.accountType = AccountType.STAFF;
        await initStaffData();
      }

      await userController.getUserInformation();

      return 200;
    }

    return respond.statusCode ?? 404;
  }

  Future<void> initAdminData() async {
    final adminDataCtrl = Get.put(AdminDataController());
    await adminDataCtrl.getAllLeaveRequest();
    await adminDataCtrl.getAllEmployeeList();
    await adminDataCtrl.getAllTransferRequest();
    await adminDataCtrl.getWorkingEmployeeToDayList();
    await adminDataCtrl.getAllTimeKeepingToday();
    //update check in postion
    await _geoController.getCheckInLocation();
  }

  Future<void> initStaffData() async {
    final staffDataCtrl = Get.put(StaffDataController());
    await staffDataCtrl.getContract();
    //update check in postion
    await _geoController.getCheckInLocation();
  }

  Future<bool> changePassword() async {
    String oldPassword = oldPassController.text;
    String newPassword = newPassController.text;
    String renewPassword = renewPassController.text;

    final userController = Get.find<UserController>();

    if (newPassword != renewPassword) {
      print("2 pass not same");
      return false;
    }
    print("Ok here");
    print(jsonEncode({
      "UserName": userController.username,
      "OldPassword": oldPassword,
      "NewPassword": newPassword
    }));

    var respond = await ApiHandler.postRequest(
        userController.username, userController.password, changePasswordPath,
        body: {
          "UserName": userController.username,
          "OldPassword": oldPassword,
          "NewPassword": newPassword
        });

    if (respond.statusCode == 200) {
      var data = respond.data.toString();
      if (data.toLowerCase().contains("success")) {
        return true;
      }
    }

    return false;
  }

  Future<void> signOut() async {
    print("Delete all controller");
    await Get.deleteAll();
  }
}
