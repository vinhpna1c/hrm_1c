import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hrm_1c/services/api/api_handler.dart';
import 'package:hrm_1c/controller/user_controller.dart';

import 'check_in_controller.dart';

class AuthController extends GetxController {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _checkInController = Get.put(CheckInController());

  static final authPath = "/V1/Employee";

  Future<int> signIn() async {
    final userController = Get.find<UserController>();
    String username = usernameController.text;
    String password = passwordController.text;

    var respond = await ApiHandler.postRequest(
      authPath,
      body: {"UserName": username, "Password": password},
    );
    if (respond.statusCode == 200) {
      var respondBody = respond.data;
      userController.identifyString = respondBody['Identifier'] ?? "";
      userController.username = username;
      userController.password = password;
      if (await userController.isAdminAccount()) {
        userController.accountType = AccountType.MANAGER;
      } else {
        userController.accountType = AccountType.EMPLOYEE;
      }

      await userController.getUserInformation();

      return 200;
    }

    return respond.statusCode ?? 404;
  }

  Future<void> signOut() async {
    await Get.deleteAll();
  }
}
