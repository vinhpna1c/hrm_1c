// ignore_for_file: constant_identifier_names

import 'dart:convert';

// import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:hrm_1c/controller/configuration_controller.dart';
import 'package:hrm_1c/services/api/api_handler.dart';
import 'package:hrm_1c/controller/check_in_controller.dart';
import 'package:hrm_1c/models/personal_information.dart';
import 'package:intl/intl.dart';

enum AccountType { ADMINISTRATOR, STAFF, MANAGER }

class UserController extends GetxController {
  static const DEFAULT_TO_NAME = "Mr. Long";
  //TODO: replace mail of Long Pham here before build apk
  static const DEFAULT_TO_MAIL = "long.pham@1cinnovation.com";
  static const EMAILJS_URL = "https://api.emailjs.com/api/v1.0/email/send";

  String identifyString = "";
  String username = "";
  String password = "";
  AccountType accountType = AccountType.STAFF;
  PersonalInformation? userInformation;

  Future<void> getUserInformation() async {
    final checkInCtrl = Get.find<CheckInController>();
    var respond =
        await ApiHandler.getRequest(username, password, "/V1/Information");
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
    var respond = await ApiHandler.postRequest(
        username, password, CheckInController.allLeavePath,
        body: {
          "UserName": username,
          "Password": password,
        });

    if (respond.statusCode != 200) {
      return false;
    }
    print(jsonEncode(respond.data));
    return respond.data["Identifier"] != null;
  }

  Future<bool> sendEmail({
    required String mailContent,
    required String mailSubject,
    String toName = DEFAULT_TO_NAME,
    String to_email = DEFAULT_TO_MAIL,
  }) async {
    final api = ApiHandler.getHandler();
    final respond = await api.post(
      EMAILJS_URL,
      data: {
        "service_id": ConfigurationController.EMAIL_SERVICE_ID,
        "template_id": ConfigurationController.EMAIL_TEMPLATE_ID,
        "user_id": ConfigurationController.EMAIL_USER_ID,
        "template_params": {
          "mail_subject": mailSubject,
          "to_name": toName,
          "mail_content": mailContent,
          "to_email": to_email,
        },
      },
      options: Options(
        headers: {
          Headers.contentTypeHeader: Headers.jsonContentType,
          'origin': 'http://localhost',
        },
      ),
    );
    print(respond.toString());
    return respond.statusCode == 200;
  }

  // Future<void> sendRequestEmail() async {
  //   final Email email = Email(
  //     body: 'Hello',
  //     subject: 'Test',
  //     recipients: [RECEIVE_EMAIL],
  //     // cc: ['cc@example.com'],s
  //     // bcc: ['bcc@example.com'],
  //     // attachmentPaths: ['/path/to/attachment.zip'],
  //     isHTML: false,
  //   );

  //   await FlutterEmailSender.send(email);
  // }

  String getMailContent(
      {required String leaveType,
      String reason = "",
      DateTime? startDate,
      DateTime? endDate}) {
    String content = "";
    content += "Leave type: $leaveType\n";
    if (startDate != null) {
      content += "From: ${DateFormat("d/M/y").format(startDate)}\n";
    }
    if (endDate != null) {
      content += "To: ${DateFormat("d/M/y").format(endDate)}\n";
    }
    content += "Reason: $reason \n";
    content += "Sincerely,\n";
    content += userInformation?.description ?? "";
    return content;
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
