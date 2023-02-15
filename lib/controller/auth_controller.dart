import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hrm_1c/models/account.dart';
import 'package:hrm_1c/services/firebase/firebase_service.dart';

import 'check_in_controller.dart';

class AuthController extends GetxController {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _checkInController = Get.put(CheckInController());

  Future<int> signIn() async {
    var account = await FirebaseService.findOne("account", {
      "username": usernameController.text,
      "password": passwordController.text
    });
    print(account);
    if (account.keys.isNotEmpty) {
      _checkInController.getCheckInInformation();
      return 200;
    }
    return 404;
  }
}
