import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hrm_1c/controller/user_controller.dart';
import 'package:hrm_1c/models/account.dart';
import 'package:hrm_1c/services/firebase/firebase_service.dart';

import 'check_in_controller.dart';

class AuthController extends GetxController {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _checkInController = Get.put(CheckInController());

  Future<int> signIn() async {
    final userController = Get.find<UserController>();
    String username = usernameController.text;
    String password = passwordController.text;
    var account = await FirebaseService.findOne("account", {
      "username": username,
      "password": password,
    });

    print(account);
    if (account.keys.isNotEmpty) {
      userController.username = username;
      userController.password = password;
      if ((account["accountType"] ?? "")
          .toString()
          .toLowerCase()
          .contains("manager")) {
        userController.accountType = AccountType.MANAGER;
      } else {
        userController.accountType = AccountType.EMPLOYEE;
      }
      _checkInController.getCheckInInformation();
      return 200;
    }
    return 404;
  }

  Future<void> signOut() async {
    await Get.deleteAll();
  }
}
