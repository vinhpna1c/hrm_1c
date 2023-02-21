import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:get/get.dart';
import 'package:hrm_1c/components/employee_item.dart';
import 'package:hrm_1c/components/home_nav_button.dart';
import 'package:hrm_1c/components/login_button.dart';
import 'package:hrm_1c/controller/check_in_controller.dart';
import 'package:hrm_1c/utils/styles.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  RxBool workingOpen = true.obs;
  RxBool leaveOpen = true.obs;
  RxBool isWebViewInit = false.obs;

  final _HOME_NAV_SPACE = 10;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double homeNavSize = (width - _HOME_NAV_SPACE * 2 - 16 * 2) / 3;

    DateTime today = DateTime.now();
    final _checkInCtrl = Get.put(CheckInController());

    String platform = Theme.of(context).platform.name;
    Widget googleDisplay;

    return SafeArea(
      child: ListView(
        children: [
          SizedBox(
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 350,
                  decoration: BoxDecoration(
                    color: HRMColorStyles.unselectedBlueColor,
                    borderRadius: const BorderRadius.only(
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
                            const TextSpan(
                                text: "Hi,", style: HRMTextStyles.normalText),
                            TextSpan(
                                text: "\nManager",
                                style: HRMTextStyles.boldText),
                          ]),
                        ),
                        RichText(
                          textAlign: TextAlign.end,
                          text: TextSpan(children: [
                            TextSpan(
                              text: "${DateFormat.EEEE().format(today)},",
                              style: HRMTextStyles.boldText.copyWith(),
                            ),
                            TextSpan(
                                text:
                                    "\n${DateFormat("dd-MM-yyyy").format(today)}",
                                style: HRMTextStyles.normalText),
                          ]),
                        ),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 24),
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(16.0)),
                      height: 200,
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: WebView(
                        initialUrl:
                            'https://www.google.com/maps/@10.7816212,106.6806794,17z?hl=vi',
                        javascriptMode: JavascriptMode.unrestricted,
                        zoomEnabled: true,
                        onWebViewCreated: (controller) {
                          controller.scrollBy(200, 300);
                          // controller.scrollTo(200, 300);
                        },
                        onPageFinished: (url) {
                          // String decodeURI = Uri.decodeFull(url).toString();
                          // //check if find locarion
                          // String decodeURL = getLocationFromMapURL(decodeURI);
                          // if (decodeURL.contains('google') == false) {
                          //   if (_searchController.text ==
                          //       "https://www.google.com/maps") {
                          //     _searchController.text = " ";
                          //   } else {
                          //     _searchController.text = decodeURL;
                          //   }
                          //   _daycareController.pickupLocation.value =
                          //       _searchController.text;
                          // }
                        },
                      ),
                      // Text("Google Map display!"),
                    ),
                    Obx(() {
                      return Padding(
                        padding: const EdgeInsets.only(top: 24),
                        child: LoginButton(
                          text: _checkInCtrl.documentID.value.isEmpty
                              ? "CHECK IN"
                              : "CHECK OUT",
                          onTapFunction: () {
                            if (_checkInCtrl.documentID.isEmpty) {
                              _checkInCtrl.checkIn();
                            } else {
                              if (_checkInCtrl.checkOutDate.value == null) {
                                print("Check out");
                              }
                            }
                          },
                        ),
                      );
                    }),
                    Container(
                      margin: const EdgeInsets.only(top: 40, bottom: 24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          HomeNavButton(
                            size: homeNavSize,
                            icon: Icon(
                              Icons.calendar_month,
                              size: 60,
                              color: HRMColorStyles.lightBlueColor,
                            ),
                            label: "Leave-day",
                          ),
                          HomeNavButton(
                            size: homeNavSize,
                            icon: Icon(
                              Icons.calendar_month,
                              size: 60,
                              color: HRMColorStyles.lightBlueColor,
                            ),
                            label: "Leave-day",
                          ),
                          HomeNavButton(
                            size: homeNavSize,
                            icon: Icon(
                              Icons.calendar_month,
                              size: 60,
                              color: HRMColorStyles.lightBlueColor,
                            ),
                            label: "Leave-day",
                          ),
                        ],
                      ),
                    ),
                    ExpandablePanel(
                        controller: ExpandableController(initialExpanded: true),
                        header: RowDivider("Working on today"),
                        theme: const ExpandableThemeData(
                          tapBodyToCollapse: false,
                          expandIcon: Icons.chevron_right,
                        ),
                        collapsed: const SizedBox(),
                        expanded: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ...List.generate(
                                  8,
                                  (index) => Container(
                                      margin: EdgeInsets.only(right: 4.0),
                                      child: EmployeeItem()))
                            ],
                          ),
                        )),
                    ExpandablePanel(
                        controller: ExpandableController(initialExpanded: true),
                        header: RowDivider("Leave requests"),
                        theme: const ExpandableThemeData(
                          tapBodyToCollapse: false,
                          expandIcon: Icons.chevron_right,
                        ),
                        collapsed: const SizedBox(),
                        expanded: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [],
                          ),
                        )),
                  ]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget RowDivider(String content) {
    return Container(
      margin: const EdgeInsets.only(top: 8.0, bottom: 4.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            margin: const EdgeInsets.only(right: 4),
            child: Text(
              content,
              style: HRMTextStyles.h4Text,
            ),
          ),
          Expanded(
            child: Divider(
              height: 2,
              thickness: 2,
              color: HRMColorStyles.greyColor,
            ),
          ),
        ],
      ),
    );
  }
}
