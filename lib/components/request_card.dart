import 'package:flutter/material.dart';
import 'package:hrm_1c/models/leave_request.dart';

import '../utils/styles.dart';
import 'employee_avatar.dart';

class RequestCard extends StatelessWidget {
  final LeaveRequest leaveRequest;
  const RequestCard({
    required this.leaveRequest,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    print(leaveRequest.halfADay);
    bool isHalfDay = (leaveRequest.halfADay ?? "").isNotEmpty;
    var status = leaveRequest.status ?? "";
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
                            color: Colors.pink,
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
                      "1 day ago",
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
                            text: leaveRequest.fromDate.toString(),
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
                                  text: leaveRequest.toDate.toString(),
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
                                text: leaveRequest.halfADay ?? "",
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
                          onPressed: () {},
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
                            onPressed: () {},
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
