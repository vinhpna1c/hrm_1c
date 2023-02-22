import 'dart:async';

import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hrm_1c/components/slide_digital_clock.dart';
import 'package:hrm_1c/controller/geo_controller.dart';
import 'package:hrm_1c/controller/user_controller.dart';
import 'package:slide_digital_clock/slide_digital_clock.dart';
import 'package:timer_builder/timer_builder.dart';
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
    final _userController = Get.find<UserController>();
    final _geoController = Get.put(GeoController());
    final _checkInCtrl = Get.put(CheckInController());
    bool isManager = _userController.accountType == AccountType.MANAGER;
    double width = MediaQuery.of(context).size.width;
    double homeNavSize = (width - _HOME_NAV_SPACE * 2 - 16 * 2) / 3;
    var currentLocation = _geoController.currentLocation.value!;
    print("Position update: " + currentLocation.toString());

    DateTime today = DateTime.now();

    String platform = Theme.of(context).platform.name;

    return Container(
      color: Colors.white,
      child: ListView(
        children: [
          SizedBox(
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 200,
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
                                    "\n${DateFormat("MMMM dd, yyyy").format(today)}",
                                style: HRMTextStyles.normalText),
                          ]),
                        ),
                      ],
                    ),
                    // Text("Distance to check in point: 450m"),
                    // Container(
                    //   margin: const EdgeInsets.only(top: 24),
                    //   decoration: BoxDecoration(
                    //       color: Colors.grey,
                    //       borderRadius: BorderRadius.circular(16.0)),
                    //   height: 200,
                    //   width: double.infinity,
                    //   alignment: Alignment.center,
                    //   child: WebView(
                    //     initialUrl:
                    //         'https://www.google.com/maps/@10.7816212,106.6806794,17z?hl=vi',
                    //     javascriptMode: JavascriptMode.unrestricted,
                    //     zoomEnabled: true,
                    //     onWebViewCreated: (controller) {
                    //       controller.scrollBy(200, 300);
                    //       // controller.scrollTo(200, 300);
                    //     },
                    //     onPageFinished: (url) {
                    //       // String decodeURI = Uri.decodeFull(url).toString();
                    //       // //check if find locarion
                    //       // String decodeURL = getLocationFromMapURL(decodeURI);
                    //       // if (decodeURL.contains('google') == false) {
                    //       //   if (_searchController.text ==
                    //       //       "https://www.google.com/maps") {
                    //       //     _searchController.text = " ";
                    //       //   } else {
                    //       //     _searchController.text = decodeURL;
                    //       //   }
                    //       //   _daycareController.pickupLocation.value =
                    //       //       _searchController.text;
                    //       // }
                    //     },
                    //   ),
                    //   // Text("Google Map display!"),
                    // ),
                    SlideDigitalClock(),
                    const SizedBox(
                      height: 60,
                    ),
                    isManager
                        ? const SizedBox()
                        : Container(
                            padding: EdgeInsets.symmetric(vertical: 20),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                    color: HRMColorStyles.lightBlueColor,
                                    width: 2.0),
                                borderRadius: BorderRadius.circular(8.0)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.directions_run_rounded,
                                  size: 60,
                                  color: Colors.grey,
                                ),
                                Container(
                                  width: 200,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Distance to your workplace",
                                        style: HRMTextStyles.normalText
                                            .copyWith(color: Colors.black),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 15),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: List.generate(
                                            8,
                                            (index) => Container(
                                              height: 4,
                                              width: 4,
                                              decoration: BoxDecoration(
                                                  color: Colors.yellow,
                                                  shape: BoxShape.circle),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Obx(
                                        () => RichText(
                                          text: TextSpan(
                                            text: Geolocator.distanceBetween(
                                                    _geoController
                                                        .currentLocation
                                                        .value!
                                                        .latitude,
                                                    _geoController
                                                        .currentLocation
                                                        .value!
                                                        .longitude,
                                                    _geoController
                                                        .checkInLocation
                                                        .latitude,
                                                    _geoController
                                                        .checkInLocation
                                                        .longitude)
                                                .toStringAsFixed(0),
                                            style: HRMTextStyles.boldText
                                                .copyWith(color: Colors.green),
                                            children: [
                                              TextSpan(
                                                text: " (m)",
                                                style: HRMTextStyles.normalText
                                                    .copyWith(
                                                        color: Colors.black),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Icon(
                                  Icons.location_on,
                                  size: 60,
                                  color: Colors.red,
                                )
                              ],
                            ),
                          ),
                    isManager
                        ? const SizedBox()
                        : Obx(() {
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
                                    if (_checkInCtrl.checkOutDate.value ==
                                        null) {
                                      print("Check out");
                                    }
                                  }
                                },
                              ),
                            );
                          }),

                    isManager
                        ? ExpandablePanel(
                            controller:
                                ExpandableController(initialExpanded: true),
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
                            ),
                          )
                        : const SizedBox(),
                    isManager
                        ? ExpandablePanel(
                            controller:
                                ExpandableController(initialExpanded: true),
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
                            ),
                          )
                        : const SizedBox(),
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
