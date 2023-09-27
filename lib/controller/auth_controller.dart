import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hrm_1c/controller/admin_data_controller.dart';
import 'package:hrm_1c/controller/geo_controller.dart';
import 'package:hrm_1c/controller/staff_data_controller.dart';
import 'package:hrm_1c/models/auth_account.dart';
import 'package:hrm_1c/services/api/api_handler.dart';
import 'package:hrm_1c/controller/user_controller.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'check_in_controller.dart';

Future<void> initAdminData() async {
  var _geoController = Get.find<GeoController>();
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
  var _geoController = Get.find<GeoController>();
  final staffDataCtrl = Get.put(StaffDataController());
  print("Init staff data controller");
  await _geoController.getCheckInLocation();
  await staffDataCtrl.getContract();
  //update check in postion
}

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
  static const BIOMETRIC_ACCOUNT = 'biometric_account';
  final LocalAuthentication localAuth = LocalAuthentication();

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
        initAdminData();
      } else {
        userController.accountType = AccountType.STAFF;
        initStaffData();
      }

      await userController.getUserInformation();

      return 200;
    }

    return respond.statusCode ?? 404;
  }

  Future<bool> biometricAuth() async {
    final bool canAuthenticateWithBiometrics =
        await localAuth.canCheckBiometrics;
    final bool canAuthenticate =
        canAuthenticateWithBiometrics || await localAuth.isDeviceSupported();
    if (!canAuthenticate) {
      throw PlatformException(
          message: "Your device does not support biometric auth", code: '401');
    }
    final List<BiometricType> availableBiometrics =
        await localAuth.getAvailableBiometrics();

    if (availableBiometrics.isEmpty) {
      throw PlatformException(
          message: "Please enroll a biometric for authentication", code: '401');
    }
    bool didAuthenticate = false;
    if (availableBiometrics.contains(BiometricType.strong) ||
        availableBiometrics.contains(BiometricType.face)) {
      didAuthenticate = await localAuth.authenticate(
          localizedReason: 'Please authenticate to show account balance');
    }
    return didAuthenticate;
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

  Future<AuthAccount?> getBiometricAccount() async {
    final _prefs = await SharedPreferences.getInstance();
    String? data = _prefs.getString(BIOMETRIC_ACCOUNT);
    if (data == null) {
      return null;
    }
    var json = JsonDecoder().convert(data);
    return AuthAccount.fromJson(json);
  }

  Future<bool> setBiometricAccount(
      {String username = "", String password = ""}) async {
    final _prefs = await SharedPreferences.getInstance();
    return _prefs.setString(
        BIOMETRIC_ACCOUNT,
        jsonEncode(
            AuthAccount(username: username, password: password).toJson()));
  }

  Future<void> signOut() async {
    print("Delete all controller");
    await Get.deleteAll();
  }
}
