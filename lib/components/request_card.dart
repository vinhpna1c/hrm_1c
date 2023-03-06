import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_1c/controller/admin_data_controller.dart';
import 'package:hrm_1c/controller/leave_day_controller.dart';
import 'package:hrm_1c/models/leave_request.dart';
import 'package:intl/intl.dart';

import '../utils/styles.dart';
import 'employee_avatar.dart';

class RequestCard extends StatelessWidget {
  final LeaveRequest leaveRequest;
  final Function? onPostFunction;
  const RequestCard({
    required this.leaveRequest,
    this.onPostFunction,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    bool isHalfDay = (leaveRequest.halfADay ?? "").isNotEmpty;
    var status = leaveRequest.status ?? "";
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
    var halfADayStr = leaveRequest.halfADay ?? "";
    DateFormat df = DateFormat("yyyy-MM-dd");
    int dayDiff =
        DateTime.now().difference(leaveRequest.date ?? DateTime.now()).inDays;

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
          Container(
            padding: EdgeInsets.only(bottom: 8.0),
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 8.0),
                      child: EmployeeAvatar(
                        backgroundRadius: 20,
                        paddingSpace: 2.0,
                        imageURL: leaveRequest.picture,
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          leaveRequest.employee ?? "",
                          style: HRMTextStyles.normalText
                              .copyWith(color: Colors.black),
                        ),
                        Text(
                          leaveRequest.leaveType ?? "",
                          style: HRMTextStyles.h5Text.copyWith(
                            fontWeight: FontWeight.w200,
                            color: HRMColorStyles.blueColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      dayDiff == 0 ? "Today" : "$dayDiff day(s) ago",
                      style: HRMTextStyles.h5Text
                          .copyWith(fontWeight: FontWeight.w200),
                    ),
                    Text(
                      leaveRequest.status ?? '',
                      style: HRMTextStyles.h5Text.copyWith(
                        fontWeight: FontWeight.w200,
                        color: statusColor,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          const Divider(
            thickness: 1,
            height: 1,
            color: Colors.grey,
          ),
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
                      text: isHalfDay ? "Start: " : "Date",
                      style: HRMTextStyles.h5Text.copyWith(
                        color: Colors.black.withOpacity(0.6),
                      ),
                      children: [
                        TextSpan(
                            text: leaveRequest.fromDate != null
                                ? df.format(leaveRequest.fromDate!)
                                : "",
                            style: HRMTextStyles.h5Text.copyWith(
                              fontWeight: FontWeight.w200,
                              color: Colors.black,
                            )),
                      ],
                    ),
                  ),
                  isHalfDay
                      ? RichText(
                          text: TextSpan(
                            text: "End: ",
                            style: HRMTextStyles.h5Text.copyWith(
                              color: Colors.black.withOpacity(0.6),
                            ),
                            children: [
                              TextSpan(
                                  text: leaveRequest.fromDate != null
                                      ? df.format(leaveRequest.toDate!)
                                      : "",
                                  style: HRMTextStyles.h5Text.copyWith(
                                    fontWeight: FontWeight.w200,
                                    color: Colors.black,
                                  )),
                            ],
                          ),
                        )
                      : RichText(
                          text: TextSpan(
                            text: "Section: ",
                            style: HRMTextStyles.h5Text.copyWith(
                              color: Colors.black.withOpacity(0.6),
                            ),
                            children: [
                              TextSpan(
                                text: halfADayStr.toLowerCase().contains("mor")
                                    ? "Morning"
                                    : "Afternoon",
                                style: HRMTextStyles.h5Text.copyWith(
                                  fontWeight: FontWeight.w200,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                  RichText(
                    text: TextSpan(
                      text: "Reason: ",
                      style: HRMTextStyles.h5Text.copyWith(
                        color: Colors.black.withOpacity(0.6),
                      ),
                      children: [
                        TextSpan(
                          text: leaveRequest.reason ?? "",
                          style: HRMTextStyles.h5Text.copyWith(
                            fontWeight: FontWeight.w200,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              isPending
                  ? Row(
                      children: [
                        TextButton(
                          style: TextButton.styleFrom(
                              side: BorderSide(color: Colors.grey.shade200)),
                          onPressed: () async {
                            await leaveCtrl
                                .approveLeaveDay(leaveRequest.number ?? "");

                            if (onPostFunction != null) {
                              onPostFunction!();
                            }
                          },
                          child: Text(
                            "Approve",
                            style: HRMTextStyles.normalText.copyWith(
                              color: HRMColorStyles.darkBlueColor,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 4.0),
                          child: TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: HRMColorStyles.darkBlueColor,
                              foregroundColor: Colors.white,
                            ),
                            onPressed: () async {
                              await leaveCtrl
                                  .rejectLeaveDay(leaveRequest.number ?? "");
                              if (onPostFunction != null) {
                                onPostFunction!();
                              }
                            },
                            child: Text(
                              "Deny",
                              style: HRMTextStyles.normalText,
                            ),
                          ),
                        )
                      ],
                    )
                  : TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: HRMColorStyles.darkBlueColor,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {},
                      child: Text(
                        "Details",
                        style: HRMTextStyles.normalText,
                      ),
                    ),
            ],
          )
        ],
      ),
    );
  }
}
