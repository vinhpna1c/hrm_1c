import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_1c/components/headers/hrm_appbar.dart';
import 'package:hrm_1c/components/headers/hrm_drawer.dart';
import 'package:hrm_1c/controller/geo_controller.dart';
import 'package:hrm_1c/controller/user_controller.dart';
import 'package:hrm_1c/screens/home/home_screen.dart';
import 'package:hrm_1c/screens/leave_days/leave_day_screen.dart';
import 'package:hrm_1c/utils/styles.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import 'account/account_screen.dart';
import 'employees/employees_screen.dart';

// ignore: must_be_immutable
class RootScreen extends StatelessWidget {
  RootScreen({super.key});
  final RxInt _currentIndex = 0.obs;

  List<Widget> screenWidgets = [
    HomeScreen(),

    EmployeesScreen(),
    LeaveDayScreen(),
    AccountScreen(
      isShowAppBar: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final userController = Get.find<UserController>();

    bool isManager = userController.accountType == AccountType.ADMINISTRATOR;
    if (!isManager) {
      Get.find<GeoController>().initLocationService();
      screenWidgets = [HomeScreen()];
    }
    //final adminController = Get.find<AdminDataController>();

    return DefaultTabController(
      initialIndex: _currentIndex.value,
      length: screenWidgets.length,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        extendBody: true,
        drawer: const HRMDrawer(),
        appBar: HRMAppBar(),
        body: TabBarView(
          children: screenWidgets,
        ),
        // screenWidgets[_currentIndex.value],

        bottomNavigationBar: isManager
            ?
        NavigationBarWidget()
            : const SizedBox(),
      ),
    );
  }
}

Widget NavigationBarWidget() {
  return Container(
    color: Colors.white.withOpacity(0.0),
    //padding: const EdgeInsets.all(4.0),
    child: Container(
      decoration:
      BoxDecoration(
        color: HRMColorStyles.unselectedBlueColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: TabBar(
          indicator: BoxDecoration(
            color: HRMColorStyles.selectedBlueColor,
            borderRadius: BorderRadius.circular(8),
          ),
          tabs: [
            TabWidget(
              Icon(
                Icons.home,
                color: Colors.white,
              ),
              "Home",
            ),
            TabWidget(
                Icon(
                  Icons.people,
                  color: Colors.white,
                ),
                "Employee"),
            TabWidget(
                Icon(
                  Icons.calendar_today_rounded,
                  color: Colors.white,
                ),
                "Leave-day"),
            TabWidget(
                Icon(
                  Icons.person_pin,
                  color: Colors.white,
                ),
                "Account"),
          ]),
    ),
  );
}

Widget TabWidget(Icon icon, String label) {
  return Tab(
    iconMargin: EdgeInsets.zero,
    height: 60,
    icon: icon,
    child: Text(
      label,
      style: HRMTextStyles.normalText.copyWith(fontSize: 10),
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
      textAlign: TextAlign.center,
    ),
  );
}