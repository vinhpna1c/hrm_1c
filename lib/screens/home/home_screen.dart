import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:hrm_1c/components/home_nav_button.dart';
import 'package:hrm_1c/components/login_button.dart';
import 'package:hrm_1c/utils/styles.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 350,
            decoration: BoxDecoration(
              color: HRMColorStyles.unselectedBlueColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(64),
                bottomRight: Radius.circular(64),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(16.0),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(children: [
                      TextSpan(text: "Hi"),
                      TextSpan(text: "\nManager"),
                    ]),
                  ),
                  RichText(
                    text: TextSpan(children: [
                      TextSpan(text: "Monday"),
                      TextSpan(text: "\n10-02-2023"),
                    ]),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 24),
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(16.0)),
                height: 64,
                width: double.infinity,
                child: Text("Google Map display!"),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24),
                child: LoginButton(
                  text: "CHECK IN",
                  onTapFunction: () {
                    print("Check In");
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    HomeNavButton(
                      icon: Icon(
                        Icons.calendar_month,
                        size: 50,
                        color: HRMColorStyles.lightBlueColor,
                      ),
                      label: "Leave-day",
                    ),
                    HomeNavButton(
                      icon: Icon(
                        Icons.calendar_month,
                        size: 50,
                        color: HRMColorStyles.lightBlueColor,
                      ),
                      label: "Leave-day",
                    ),
                    HomeNavButton(
                      icon: Icon(
                        Icons.calendar_month,
                        size: 50,
                        color: HRMColorStyles.lightBlueColor,
                      ),
                      label: "Leave-day",
                    ),
                  ],
                ),
              )
            ]),
          ),
        ],
      ),
    );
  }
}
