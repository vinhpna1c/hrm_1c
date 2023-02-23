import 'dart:convert';

import 'package:get/get.dart';
import 'package:hrm_1c/services/api/api_handler.dart';
import 'package:hrm_1c/controller/auth_controller.dart';
import 'package:hrm_1c/controller/check_in_controller.dart';
import 'package:hrm_1c/models/personal_information.dart';

enum AccountType { MANAGER, EMPLOYEE }

class UserController extends GetxController {
  String identifyString = "87bd2ef0-b196-11ed-b0ed-00155dda4405";
  String username = "";
  String password = "";
  AccountType accountType = AccountType.EMPLOYEE;
  PersonalInformation? userInformation;

  Future<void> getUserInformation() async {
    var respond = await ApiHandler.getRequest(AuthController.authPath, params: {
      "Token": identifyString,
    });
    if (respond.statusCode == 200) {
      print(jsonEncode(respond.data['Metadata'][0]['PersonalInformation']));
      userInformation = PersonalInformation.fromJson(
          respond.data['Metadata'][0]['PersonalInformation']);
    }
  }

  //check account is admin
  //ensure check account is valid
  Future<bool> isAdminAccount() async {
    var respond =
        await ApiHandler.postRequest(CheckInController.allLeavePath, body: {
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
    accountType = AccountType.EMPLOYEE;
    super.onClose();
  }
}
