import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_1c/components/employee_avatar.dart';
import 'package:hrm_1c/components/hrm_drawer.dart';
import 'package:hrm_1c/screens/auth/login_screen.dart';
import 'package:hrm_1c/screens/home/home_screen.dart';
import 'package:hrm_1c/utils/styles.dart';

import 'account/account_screen.dart';

class RootScreen extends StatelessWidget {
  RootScreen({super.key});
  final RxInt _currentIndex = 0.obs;
  final List<Widget> screenWidgets = [
    HomeScreen(),
    Container(
      child: Center(
        child: Text("In development"),
      ),
    ),
    Container(
      child: Center(
        child: Text("In development"),
      ),
    ),
    Container(
      child: Center(
        child: Text("In development"),
      ),
    ),
    AccountScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: _currentIndex.value,
      length: screenWidgets.length,
      child: Scaffold(
        drawer: HRMDrawer(),
        appBar: AppBar(
          title: Text(
            "1C:HRM",
            style: HRMTextStyles.h3Text.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          backgroundColor: HRMColorStyles.darkBlueColor,
          centerTitle: true,
        ),
        body: TabBarView(
          children: screenWidgets,
        ),
        // screenWidgets[_currentIndex.value],

        bottomNavigationBar: Container(
          margin: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(color: HRMColorStyles.unselectedBlueColor),
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
