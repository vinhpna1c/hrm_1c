import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_1c/controller/user_controller.dart';
import 'package:hrm_1c/screens/auth/login_screen.dart';
import 'package:hrm_1c/utils/styles.dart';

import 'employee_avatar.dart';

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
                  ),
                ),
                Text(
                  "Employee name",
                  style: HRMTextStyles.h3Text.copyWith(
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  "Job title",
                  style: HRMTextStyles.h3Text
                      .copyWith(fontWeight: FontWeight.w100),
                ),
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
                  NavigationTile(label: "Home"),
                  _userController.accountType == AccountType.EMPLOYEE
                      ? NavigationTile(label: "Request leave-day")
                      : const SizedBox(),
                  NavigationTile(label: "Change password"),
                  _userController.accountType == AccountType.EMPLOYEE
                      ? NavigationTile(label: "Check-in History")
                      : const SizedBox(),
                  _userController.accountType == AccountType.MANAGER
                      ? NavigationTile(label: "Settings")
                      : const SizedBox(),
                ],
              )),
          Container(
            width: double.infinity,
            height: _SIGN_OUT_HEIGHT,
            decoration: BoxDecoration(border: Border.all(color: Colors.white)),
            child: TextButton(
                onPressed: () {
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
    return Ink(
      color: Colors.lightGreen,
      child: ListTile(
        title: Text('With lightGreen background'),
        onTap: () {},
      ),
    );
  }
}
