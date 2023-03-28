import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_1c/controller/auth_controller.dart';
import 'package:hrm_1c/controller/user_controller.dart';
import 'package:hrm_1c/screens/account/account_screen.dart';
import 'package:hrm_1c/screens/auth/change_password_screen.dart';
import 'package:hrm_1c/screens/auth/login_screen.dart';
import 'package:hrm_1c/screens/leave_days/check_in_history.dart';
import 'package:hrm_1c/screens/leave_days/request_leave_screen.dart';
import 'package:hrm_1c/screens/leave_days/request_transfer_shift_screen.dart';
import 'package:hrm_1c/screens/root_screen.dart';
import 'package:hrm_1c/screens/settings.dart/setting_screen.dart';
import 'package:hrm_1c/screens/single_body_screen.dart';
import 'package:hrm_1c/utils/styles.dart';

import '../employee_avatar.dart';

class HRMDrawer extends StatelessWidget {
  const HRMDrawer({
    Key? key,
  }) : super(key: key);

  // ignore: non_constant_identifier_names
  final _HEADER_HEIGHT = 200.0;
  final _SIGN_OUT_HEIGHT = 40.0;

  @override
  Widget build(BuildContext context) {
    final _userController = Get.put(UserController());
    final _authController = Get.find<AuthController>();
    return Drawer(
      width: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: double.infinity,
            height: _HEADER_HEIGHT,
            color: HRMColorStyles.selectedBlueColor,
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 8.0),
                  child: EmployeeAvatar(
                    backgroundRadius: 54,
                    paddingSpace: 8.0,
                    imageURL: _userController.userInformation!.URL!,
                  ),
                ),
                Text(
                  _userController.userInformation!.description!,
                  style: HRMTextStyles.h3Text.copyWith(
                    fontWeight: FontWeight.w400,
                  ),
                ),
                // Text(
                //   _userController.userInformation!.position!,
                //   style: HRMTextStyles.h3Text
                //       .copyWith(fontWeight: FontWeight.w100),
                // ),
              ],
            ),
          ),
          Container(
            color: HRMColorStyles.blueShade500Color,
            height: MediaQuery.of(context).size.height -
                _HEADER_HEIGHT -
                _SIGN_OUT_HEIGHT,
            child: ListView(
              children: [
                NavigationTile(
                    label: "Home",
                    onTap: () {
                      Get.back();
                      Get.to(RootScreen());
                    }),
                _userController.accountType == AccountType.STAFF
                    ? NavigationTile(
                        label: "Request leave-day",
                        onTap: () {
                          var key = UniqueKey();
                          Get.back();
                          Get.to(RequestLeaveScreen());
                        })
                    : const SizedBox(),
                _userController.accountType == AccountType.STAFF
                    ? NavigationTile(
                        label: "Request transfer-shift",
                        onTap: () {
                          var key = UniqueKey();
                          Get.back();
                          Get.to(RequestTransferShiftScreen());
                        })
                    : const SizedBox(),
                NavigationTile(
                    label: "Change password",
                    onTap: () {
                      Get.back();
                      var key = UniqueKey();
                      Get.to(const ChangePasswordScreen());
                    }),
                _userController.accountType == AccountType.STAFF
                    ? NavigationTile(
                        label: "Check-in History",
                        onTap: () {
                          Get.back();
                          Get.to(const CheckInHistoryScreen());
                        })
                    : const SizedBox(),
                _userController.accountType == AccountType.ADMINISTRATOR
                    ? NavigationTile(
                        label: "Settings",
                        onTap: () {
                          Get.back();
                          Get.to(SettingScreen());
                        })
                    : const SizedBox(),
                _userController.accountType == AccountType.STAFF
                    ? NavigationTile(
                        label: "User Information",
                        onTap: () {
                          print("Go to user information");
                          Get.back();
                          Get.to(AccountScreen());
                        })
                    : const SizedBox(),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: _SIGN_OUT_HEIGHT,
            decoration: BoxDecoration(border: Border.all(color: Colors.white)),
            child: TextButton(
                onPressed: () async {
                  await _authController.signOut();
                  Get.to(LoginScreen());
                },
                style: TextButton.styleFrom(
                    backgroundColor: HRMColorStyles.selectedBlueColor),
                child: Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: Icon(
                        Icons.logout,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Sign out",
                      style: HRMTextStyles.normalText,
                    ),
                  ],
                )),
          )
        ],
      ),
    );
  }

  Widget NavigationTile({String label = "", Function()? onTap}) {
    // return InkWell(
    //   color: Colors.lightBlue,
    //   child: ListTile(
    //     hoverColor: Colors.blue.shade900,
    //     selectedColor: Colors.blue.shade900,
    //     title: Text(label),
    //     onTap: onTap ?? () {},
    //   ),
    // );

    return TextButton(
      style: TextButton.styleFrom(
          backgroundColor: Colors.transparent,
          alignment: Alignment.centerLeft,
          elevation: 0.1),
      child: Text(
        label,
        style: HRMTextStyles.normalText,
      ),
      onPressed: onTap,
    );
  }
}
