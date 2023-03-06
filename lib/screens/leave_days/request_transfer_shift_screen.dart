import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_1c/components/shift_table.dart';
import 'package:hrm_1c/controller/staff_data_controller.dart';
import 'package:hrm_1c/models/contract.dart';
import 'package:hrm_1c/screens/single_body_screen.dart';
import 'package:hrm_1c/utils/styles.dart';
import 'package:hrm_1c/utils/utils.dart';

class RequestTransferShiftScreen extends StatelessWidget {
  final Rx<DateTime> requestDay = DateTime.now().obs;
  RequestTransferShiftScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final staffDataCtrl = Get.find<StaffDataController>();
    return SingleBodyScreen(
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Container(
              padding: const EdgeInsets.all(16.0),
              color: HRMColorStyles.blueShade800Color,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          TextButton(
                            style: TextButton.styleFrom(
                                backgroundColor: Colors.grey),
                            onPressed: () {},
                            child: Text("<"),
                          ),
                          Expanded(child: Text("sss")),
                          TextButton(
                            style: TextButton.styleFrom(
                                backgroundColor: Colors.grey),
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
}
