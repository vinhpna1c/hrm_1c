import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_1c/components/input_widget.dart';
import 'package:hrm_1c/components/login_button.dart';
import 'package:hrm_1c/controller/auth_controller.dart';

import 'package:hrm_1c/main.dart';
import 'package:hrm_1c/screens/root_screen.dart';

import 'package:hrm_1c/utils/styles.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // ignore: no_leading_underscores_for_local_identifiers
  final _authController = Get.put(AuthController());

  void _onLoginPress() async {
    Get.dialog(
      const Center(
        child: CircularProgressIndicator(),
      ),
    );
    int statusCode = await _authController.signIn();
    Get.back();
    if (statusCode == 200) {
      Get.to(() => RootScreen());
      _authController.usernameController.clear();
      _authController.passwordController.clear();
    } else {
      Get.snackbar("1C:HRM", "Invalid credentials!");
    }
  }

  @override
  void initState() {
    super.initState();
    initController();
    _authController.onInit();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
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
                Container(
                  margin: EdgeInsets.only(top: 16, bottom: 8),
                  child: IconButton(
                      style:
                          IconButton.styleFrom(backgroundColor: Colors.white),
                      iconSize: 48,
                      onPressed: () async {
                        try {
                          bool result = await _authController.biometricAuth();
                          if (result) {
                            final account =
                                await _authController.getBiometricAccount();
                            if (account != null) {
                              _authController.usernameController.text =
                                  account.username ?? "";
                              _authController.passwordController.text =
                                  account.password ?? "";
                              _onLoginPress();
                            } else {
                              Get.snackbar("1C:HRM",
                                  "Please set up your account with biometric with this device");
                            }
                          }
                        } catch (e) {
                          print(
                            "Error" + e.toString(),
                          );
                        }
                      },
                      icon: Icon(
                        Icons.fingerprint,
                        color: Colors.blue.shade400,
                      )),
                ),
                LoginButton(
                  // width: Get.size.width - 100,
                  text: "LOGIN",
                  onTapFunction: _onLoginPress,
                ),
                SizedBox(height: MediaQuery.of(context).viewInsets.bottom + 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
