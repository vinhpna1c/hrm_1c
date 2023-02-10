import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_1c/screens/auth/login_screen.dart';
import 'package:hrm_1c/screens/home/home_screen.dart';
import 'package:hrm_1c/utils/styles.dart';

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
    Container(
      child: Center(
        child: Text("In development"),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        width: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 100,
              color: Colors.yellow,
              child: DrawerHeader(
                  child: Container(color: Colors.red, child: Text("None"))),
            ),
            Container(
                color: Colors.green,
                height: MediaQuery.of(context).size.height - 100 - 40,
                child: ListView(
                  children: [
                    Text("Drawer"),
                  ],
                )),
            TextButton(
                onPressed: () {
                  Get.to(LoginScreen());
                },
                style: TextButton.styleFrom(
                    fixedSize: Size(double.infinity, 40),
                    backgroundColor: HRMColorStyles.selectedBlueColor),
                child: Text("Sign out"))
          ],
        ),
      ),
      appBar: AppBar(
        title: Text("1C:HRM"),
        backgroundColor: HRMColorStyles.darkBlueColor,
        centerTitle: true,
      ),
      body: Obx(
        () => screenWidgets[_currentIndex.value],
      ),
      bottomNavigationBar: Obx(
        () => FloatingNavbar(
            borderRadius: 8.0,
            backgroundColor: HRMColorStyles.unselectedBlueColor,
            unselectedItemColor: Colors.white,
            selectedBackgroundColor: HRMColorStyles.selectedBlueColor,
            selectedItemColor: Colors.white,
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
            padding: EdgeInsets.zero,
            currentIndex: _currentIndex.value,
            onTap: (val) {
              _currentIndex.value = val;
            },
            items: [
              FloatingNavbarItem(
                icon: Icons.home,
                title: "Home",
              ),
              FloatingNavbarItem(
                icon: Icons.people,
                title: "Jobs",
              ),
              FloatingNavbarItem(
                icon: Icons.people,
                title: "Employees",
              ),
              FloatingNavbarItem(
                icon: Icons.calendar_today_rounded,
                title: "Leave-day",
              ),
              FloatingNavbarItem(
                icon: Icons.person_pin,
                title: "Account",
              ),
            ]),
      ),
    );
  }
}
