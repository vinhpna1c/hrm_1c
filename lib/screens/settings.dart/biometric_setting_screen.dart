import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_1c/components/login_button.dart';
import 'package:hrm_1c/controller/auth_controller.dart';
import 'package:hrm_1c/controller/user_controller.dart';
import 'package:hrm_1c/screens/single_body_screen.dart';

import '../../utils/styles.dart';

class BiometricSettingScreen extends StatelessWidget {
  BiometricSettingScreen({super.key});
  final userController = Get.find<UserController>();
  final authController = Get.find<AuthController>();
  final passwordCtrl = TextEditingController();
  void _onNextPress() async {
    if (passwordCtrl.text == userController.password) {
      bool result = await authController.biometricAuth();
      if (result) {
        bool done = await authController.setBiometricAccount(
            username: userController.username,
            password: userController.password);
        if (done) {
          passwordCtrl.clear();
          Get.snackbar(
            "1C:HRM",
            "Set up biometric done!\nYou can login with biometric from now.",
            icon: Icon(Icons.check_circle, color: Colors.green),
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.white,
            borderRadius: 20,
            margin: EdgeInsets.all(15),
            colorText: Colors.black,
            duration: Duration(seconds: 4),
            isDismissible: true,
            forwardAnimationCurve: Curves.easeOutBack,
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleBodyScreen(
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(16.0)),
            margin: EdgeInsets.all(8),
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Password",
                    style:
                        HRMTextStyles.boldText.copyWith(color: Colors.black87)),
                TextField(
                  obscureText: true,
                  controller: passwordCtrl,
                ),
                Container(
                  margin: EdgeInsets.only(top: 4),
                  child: const Text(
                    " Enter password to set up biometric login on this device",
                    style: HRMTextStyles.lightText,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: HRMColorStyles.blueColor),
                    child: Text(
                      "Next",
                      style: HRMTextStyles.h3Text,
                    ),
                    onPressed: _onNextPress,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
