import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_1c/components/employee_avatar.dart';
import 'package:hrm_1c/components/hrm_appbar.dart';
import 'package:hrm_1c/components/hrm_drawer.dart';
import 'package:hrm_1c/controller/admin_data_controller.dart';
import 'package:hrm_1c/controller/geo_controller.dart';
import 'package:hrm_1c/controller/user_controller.dart';
import 'package:hrm_1c/screens/auth/login_screen.dart';
import 'package:hrm_1c/screens/home/home_screen.dart';
import 'package:hrm_1c/screens/jobs/job_screen.dart';
import 'package:hrm_1c/screens/leave_days/leave_day_screen.dart';
import 'package:hrm_1c/utils/styles.dart';

import 'account/account_screen.dart';
import 'employees/employees_screen.dart';

class RootScreen extends StatelessWidget {
  RootScreen({super.key});
  final RxInt _currentIndex = 0.obs;

  List<Widget> screenWidgets = [
    HomeScreen(),
    JobScreen(),
    EmployeesScreen(),
    LeaveDayScreen(),
    AccountScreen(
      isShowAppBar: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final _userController = Get.find<UserController>();

    bool isManager = _userController.accountType == AccountType.ADMINISTRATOR;
    if (!isManager) {
      screenWidgets = [HomeScreen()];
    }
    //final adminController = Get.find<AdminDataController>();

    return DefaultTabController(
      initialIndex: _currentIndex.value,
      length: screenWidgets.length,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        extendBody: true,
        drawer: HRMDrawer(),
        appBar: HRMAppBar(),
        body: TabBarView(
          children: screenWidgets,
        ),
        // screenWidgets[_currentIndex.value],

        bottomNavigationBar: isManager
            ? Container(
                color: Colors.white.withOpacity(0.0),
                padding: const EdgeInsets.all(16.0),
                 child: Container(
                  decoration:
                      BoxDecoration(color: HRMColorStyles.unselectedBlueColor),
                  child: TabBar(
                      indicator: BoxDecoration(
                        color: HRMColorStyles.selectedBlueColor,
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
                              Icons.document_scanner_outlined,
                              color: Colors.white,
                            ),
                            "Jobs"),
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
              )
            : const SizedBox(),
      ),
    );
  }

  Widget TabWidget(Icon icon, String label) {
    return Tab(
      iconMargin: EdgeInsets.zero,
      height: 80,
      icon: icon,
      child: Text(
        label,
        style: HRMTextStyles.normalText.copyWith(fontSize: 12),
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
        textAlign: TextAlign.center,
      ),
    );
  }
}
