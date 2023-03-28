import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_1c/components/shift_table.dart';
import 'package:hrm_1c/controller/staff_data_controller.dart';
import 'package:hrm_1c/controller/transfer_shift_controller.dart';
import 'package:hrm_1c/models/contract.dart';
import 'package:hrm_1c/screens/single_body_screen.dart';
import 'package:hrm_1c/utils/styles.dart';
import 'package:hrm_1c/utils/utils.dart';
import 'package:intl/intl.dart';

class RequestTransferShiftScreen extends StatelessWidget {
  final Rx<DateTime> requestDay = DateTime.now().obs;
  RequestTransferShiftScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final staffDataCtrl = Get.find<StaffDataController>();
    List<DateTime> days = currentWeek();
    return SingleBodyScreen(
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Container(
              padding: const EdgeInsets.all(12.0),
              color: HRMColorStyles.blueShade800Color,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Text(
                          "Time Sheet",
                          style: HRMTextStyles.h3Text.copyWith(fontSize: 24),
                        ),
                        alignment: Alignment.center,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TextButton(
                            style: TextButton.styleFrom(
                                backgroundColor: Colors.white),
                            onPressed: () {
                              
                            },
                            child: Text("<"),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(DateFormat("dd/MM/yyyy").format(days[0])+" - "+DateFormat("dd/MM/yyyy").format(days[6]),
                              style: HRMTextStyles.lightText.copyWith(color: Colors.white),
                            ),
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                                backgroundColor: Colors.white),
                            onPressed: () {},
                            child: Text(">"),
                          )
                        ],
                      ),
                      ShiftTable(
                        timeSheets: staffDataCtrl.contract.value!.timeSheet,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<DateTime> currentWeek() {
    List<DateTime> days = [];
    int n = DateTime.now().weekday;
    for (var i = n-1; i >= 1; i-- ) {
      days.add(DateTime.now().subtract(Duration(days: i)));
    }

    days.add(DateTime.now());

    for (var i = 7; i >= n+1; i-- ) {
      days.add(DateTime.now().add(Duration(days: 8-i)));
    }

    return days;
  }
}




