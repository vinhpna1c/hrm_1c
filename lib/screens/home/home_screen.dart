// import 'dart:async';
// import 'dart:js_interop';

import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hrm_1c/components/slide_digital_clock.dart';
import 'package:hrm_1c/controller/admin_data_controller.dart';
import 'package:hrm_1c/controller/geo_controller.dart';
import 'package:hrm_1c/controller/user_controller.dart';
import 'package:slide_digital_clock/slide_digital_clock.dart';
import 'package:timer_builder/timer_builder.dart';

import 'package:get/get.dart';
import 'package:hrm_1c/components/employee_item.dart';
import 'package:hrm_1c/components/home_nav_button.dart';
import 'package:hrm_1c/components/login_button.dart';
import 'package:hrm_1c/controller/check_in_controller.dart';
import 'package:hrm_1c/utils/styles.dart';
import 'package:intl/intl.dart';

import '../../components/employee_avatar.dart';
import '../../controller/configuration_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  RxBool workingOpen = true.obs;
  RxBool leaveOpen = true.obs;
  RxBool isWebViewInit = false.obs;

  //screen controllers
  late final UserController userController;
  late final GeoController geoController;
  late final CheckInController checkInCtrl;
  late final AdminDataController adminDataCtrl;
  late final bool isManager;

  @override
  void initState() {
    userController = Get.find<UserController>();
    geoController = Get.find<GeoController>();

    checkInCtrl = Get.find<CheckInController>();
    adminDataCtrl = Get.find<AdminDataController>();

    isManager = userController.accountType == AccountType.ADMINISTRATOR;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DateTime today = DateTime.now();
    bool isCheckedOut =
        checkInCtrl.timeKeeping.value!.number == null ? true : false;
    // final configutationCtrl=Get.find<ConfigurationController>();
    // print("Check in position "+configutationCtrl.checkInPosition.toJson());
    print("${geoController.longitude.value} - ${geoController.latitude.value}");

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
                                text:
                                    "\n${(userController.userInformation!.description ?? "").split(" ").last}",
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
                                      TimerBuilder.periodic(
                                          Duration(milliseconds: 500),
                                          builder: (context) {
                                        print(geoController
                                            .currentLocation.value);
                                        if (geoController
                                                .currentLocation.value ==
                                            null) {
                                          return const SizedBox();
                                        }
                                        return RichText(
                                          text: TextSpan(
                                            text: Geolocator.distanceBetween(
                                                    geoController
                                                        .currentLocation
                                                        .value!
                                                        .latitude,
                                                    geoController
                                                        .currentLocation
                                                        .value!
                                                        .longitude,
                                                    geoController
                                                        .latitude.value,
                                                    geoController
                                                        .longitude.value)
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
                                        );
                                      }),
                                    ],
                                  ),
                                ),
                                const Icon(
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
                                enabled: isCheckedOut,
                                text: checkInCtrl.timeKeeping.value!.number ==
                                        null
                                    ? "CHECK IN"
                                    : "CHECK OUT",
                                onTapFunction: () async {
                                  if (Geolocator.distanceBetween(
                                          geoController
                                              .currentLocation.value!.latitude,
                                          geoController
                                              .currentLocation.value!.longitude,
                                          geoController.latitude.value,
                                          geoController.longitude.value) >
                                      geoController.checkInRadius.value) {
                                    Get.snackbar("1C:HRM",
                                        "Your location is too far from the company");
                                  } else {
                                    if ((checkInCtrl
                                                .timeKeeping.value!.number ==
                                            null) ||
                                        (checkInCtrl.timeKeeping.value!.number!
                                            .isEmpty)) {
                                      var res = await checkInCtrl.checkIn();
                                      if (res) {
                                        Get.snackbar(
                                            "1C:HRM", "Check in successfull");
                                      }
                                    } else {
                                      if (checkInCtrl
                                              .timeKeeping.value!.checkout ==
                                          null) {
                                        var res = await checkInCtrl.checkOut();
                                        if (res) {
                                          isCheckedOut = false;
                                          Get.snackbar("1C:HRM",
                                              "Check out successfull");
                                        }
                                      }
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
                                      adminDataCtrl.workingEmployees.length,
                                      (index) {
                                    final workingEmployee =
                                        adminDataCtrl.workingEmployees[index];

                                    //find employee in employee list
                                    final employee = adminDataCtrl.employees
                                        .firstWhereOrNull((element) =>
                                            element.code ==
                                            workingEmployee.code);
                                    //check status of employee
                                    if (employee == null) {
                                      return const SizedBox();
                                    }
                                    DisplayStatus displayStatus =
                                        DisplayStatus.NOT_CHECK_IN;
                                    if ((employee.status ?? "")
                                        .toLowerCase()
                                        .contains('inactive')) {
                                      return const SizedBox();
                                    }
                                    //check current check in status
                                    final checkInInfor = adminDataCtrl
                                        .checkInTodayTimeKeeping
                                        .firstWhereOrNull((timeKeeping) =>
                                            (timeKeeping.employee ?? '-') ==
                                            (employee.code ?? ''));
                                    if (checkInInfor != null) {
                                      print(checkInInfor.checkin);
                                      if (checkInInfor.checkin != null &&
                                          checkInInfor.checkin!
                                                  .difference(DateTime.now())
                                                  .inDays ==
                                              0) {
                                        displayStatus = DisplayStatus.CHECK_IN;
                                      }
                                    }
                                    print(
                                        "Check in status ${employee.description}: $displayStatus");
                                    return Container(
                                        margin:
                                            const EdgeInsets.only(right: 4.0),
                                        child: EmployeeItem(
                                          employee: employee,
                                          displayStatus: displayStatus,
                                        ));

                                    // : Container();
                                  })
                                ],
                              ),
                            ),
                          )
                        : const SizedBox(),
                    // isManager
                    //     ? ExpandablePanel(
                    //         controller:
                    //             ExpandableController(initialExpanded: true),
                    //         header: RowDivider("Leave requests"),
                    //         theme: const ExpandableThemeData(
                    //           tapBodyToCollapse: false,
                    //           expandIcon: Icons.chevron_right,
                    //         ),
                    //         collapsed: const SizedBox(),
                    //         expanded: SingleChildScrollView(
                    //           scrollDirection: Axis.horizontal,
                    //           child: Row(
                    //             mainAxisAlignment: MainAxisAlignment.start,
                    //             children: [],
                    //           ),
                    //         ),
                    //       )
                    //     : const SizedBox(),
                  ]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ignore: non_constant_identifier_names
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
