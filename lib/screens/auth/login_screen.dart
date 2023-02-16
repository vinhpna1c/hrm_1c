import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_1c/components/input_widget.dart';
import 'package:hrm_1c/components/login_button.dart';
import 'package:hrm_1c/controller/auth_controller.dart';
import 'package:hrm_1c/screens/root_screen.dart';
import 'package:hrm_1c/services/firebase/firebase_service.dart';
import 'package:hrm_1c/utils/styles.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    final _authController = Get.put(AuthController());

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  HRMColorStyles.blueColor,
                  Colors.white,
                ],
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 140, bottom: 60),
                  height: 140,
                  child: Image.asset("assets/images/logo_crop.png",
                      fit: BoxFit.fitHeight),
                ),
                InputWidget(
                  label: "Username",
                  prefixIcon: const Icon(Icons.person),
                  controller: _authController.usernameController,
                ),
                InputWidget(
                  label: "Password",
                  prefixIcon: const Icon(Icons.lock),
                  isObsocured: true,
                  controller: _authController.passwordController,
                ),
                LoginButton(
                  text: "LOGIN",
                  onTapFunction: () async {
                    int statusCode = await _authController.signIn();

                    if (statusCode == 200) {
                      Get.to(RootScreen());
                    } else {
                      Get.snackbar("1C:HRM", "Invalid credentials!");
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
