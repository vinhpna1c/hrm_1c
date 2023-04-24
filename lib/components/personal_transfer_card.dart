import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_1c/controller/admin_data_controller.dart';
import 'package:hrm_1c/controller/leave_day_controller.dart';
import 'package:hrm_1c/models/leave_request.dart';
import 'package:hrm_1c/models/transfer_shift_request.dart';
import 'package:intl/intl.dart';

import '../utils/styles.dart';
import 'employee_avatar.dart';

class PersonalTransferCard extends StatelessWidget {
  final TransferShiftRequest transferRequest;
  final Function? onPostFunction;
  const PersonalTransferCard({
    required this.transferRequest,
    this.onPostFunction,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    //bool isHalfDay = (transferRequest.halfADay ?? "").isNotEmpty;
    var status = transferRequest.status ?? "";
    final leaveCtrl = Get.find<LeaveDayController>();
    bool isPending = false;
    Color statusColor = LeaveRequest.statusColors[0];
    if (status.toLowerCase().contains("approve")) {
      statusColor = LeaveRequest.statusColors[1];
    }
    if (status.toLowerCase().contains("reject")) {
      statusColor = LeaveRequest.statusColors[2];
    }
    if (status.toLowerCase().contains("pend")) {
      isPending = true;
    }
    //var halfADayStr = transferRequest.halfADay ?? "";
    DateFormat df = DateFormat("yyyy-MM-dd");
    int dayDiff =
        DateTime.now().difference(DateTime(transferRequest.date!.year,transferRequest.date!.month, transferRequest.date!.day,0,0,0,0,0) ?? DateTime.now()).inDays;
    return Container(
      padding: EdgeInsets.all(8.0),
      margin: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.25),
                offset: Offset(0, 0),
                blurRadius: 4.0)
          ]),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Container(
                      margin: EdgeInsets.only(
                        right: 5,
                      ),
                      child: Icon(Icons.cameraswitch_outlined, color: Colors.green, size: 16,)
                  ),
                  Text(
                    "Transfer shift",
                    style: HRMTextStyles.h5Text.copyWith(
                      fontWeight: FontWeight.bold,
                      color:Colors.green,
                    ),
                  ),
                ],
              ),
              Text(
                dayDiff == 0 ? "Today" : "$dayDiff day(s) ago",
                style: HRMTextStyles.h5Text
                    .copyWith(fontWeight: FontWeight.w200),
              ),
            ],
          ),
          StatusTab(status: transferRequest.status ?? "", label: transferRequest.status!),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(
                      text: "Main shift: ",
                      style: HRMTextStyles.h5Text.copyWith(
                        color: Colors.black.withOpacity(0.6),
                      ),
                      children: [
                        TextSpan(
                            text: transferRequest.shiftMain != null
                                ? df.format(transferRequest.shiftMain!) + " - " + transferRequest.sectionMain!
                                : "",
                            style: HRMTextStyles.h5Text.copyWith(
                              fontWeight: FontWeight.w200,
                              color: Colors.black,
                            )),
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: transferRequest.transferShift2 == null ? "Transfer shift: " : "Transfer shift 1: ",
                      style: HRMTextStyles.h5Text.copyWith(
                        color: Colors.black.withOpacity(0.6),
                      ),
                      children: [
                        TextSpan(
                            text: transferRequest.transferShift != null
                                ? df.format(transferRequest.transferShift!) + " - " + transferRequest.sectionTransfer!
                                : "",
                            style: HRMTextStyles.h5Text.copyWith(
                              fontWeight: FontWeight.w200,
                              color: Colors.black,
                            )),
                      ],
                    ),
                  ),
                  transferRequest.transferShift2 != null ?
                    RichText(
                      text: TextSpan(
                        text: "Transfer shift 2: ",
                        style: HRMTextStyles.h5Text.copyWith(
                          color: Colors.black.withOpacity(0.6),
                        ),
                        children: [
                          TextSpan(
                              text: transferRequest.transferShift2 != null
                                  ? df.format(transferRequest.transferShift2!) + " - " + transferRequest.sectionTransfer2!
                                  : "",
                              style: HRMTextStyles.h5Text.copyWith(
                                fontWeight: FontWeight.w200,
                                color: Colors.black,
                              )),
                        ],
                      ),
                    )
                  : const SizedBox(),
                  // RichText(
                  //   text: TextSpan(
                  //     text: "Reason: ",
                  //     style: HRMTextStyles.h5Text.copyWith(
                  //       color: Colors.black.withOpacity(0.6),
                  //     ),
                  //     children: [
                  //       TextSpan(
                  //         text: leaveRequest.reason ?? "",
                  //         style: HRMTextStyles.h5Text.copyWith(
                  //           fontWeight: FontWeight.w200,
                  //           color: Colors.black,
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
  Widget StatusTab({
    required String status,
    Color textColor = Colors.white,
    String label = "",
  }) {
    switch (status) {
      case "Pending" :
        textColor = HRMColorStyles.pendingColor;
        break;
      case "Approve" :
        textColor = HRMColorStyles.approveColor;
        break;
      case "Reject" :
        textColor = HRMColorStyles.denyColor;
        break;

    }
    return Tab(
      child: Container(
        // alignment: Alignment.center,
        width: double.infinity,
        height: 30,
        padding: const EdgeInsets.symmetric(
          horizontal: 2.0,
        ),
        decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8.0)),
        child: Center(
          child: Text(
            label,
            style: HRMTextStyles.h5Text.copyWith(
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}
