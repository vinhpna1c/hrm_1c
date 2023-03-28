import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_1c/components/hrm_drawer.dart';
import 'package:hrm_1c/controller/leave_day_controller.dart';
import 'package:hrm_1c/screens/single_body_screen.dart';

import 'package:hrm_1c/utils/styles.dart';
import 'package:intl/intl.dart';

class RequestLeaveScreen extends StatelessWidget {
  const RequestLeaveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final leaveDayCtrl = Get.find<LeaveDayController>();

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
                      TitleField(title: "Leave type"),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4.0)),
                        child: Obx(
                          () => DropdownButton(
                            hint: Text(
                              "Choose leave type",
                              style: HRMTextStyles.lightText.copyWith(
                                  color: HRMColorStyles.greyHintColor),
                            ),
                            underline: const SizedBox(),
                            value: leaveDayCtrl.leaveType.value,
                            isExpanded: true,
                            items: LeaveDayController.LEAVE_TYPES
                                .map(
                                  (e) => DropdownMenuItem<String>(
                                    value: e,
                                    child: Text(e),
                                    onTap: () {
                                      leaveDayCtrl.leaveType.value = e;
                                    },
                                  ),
                                )
                                .toList(),
                            onChanged: (String? value) {},
                          ),
                        ),
                      ),
                      Obx(
                        () => Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TitleField(title: "Fullday or Halfday:"),
                            SectionRadio(
                                value:
                                    LeaveDayController.SECTION_LEAVE_TYPES[0],
                                groupValue: leaveDayCtrl.sectionLeave.value,
                                onChanged: (value) {
                                  print(value);
                                  leaveDayCtrl.sectionLeave.value = value ?? '';
                                }),
                            Text("Fullday",
                                style: HRMTextStyles.lightText
                                    .copyWith(color: Colors.white)),
                            SectionRadio(
                              value: LeaveDayController.SECTION_LEAVE_TYPES[1],
                              groupValue: leaveDayCtrl.sectionLeave.value,
                              onChanged: (value) {
                                print(value);
                                leaveDayCtrl.sectionLeave.value = value ?? '';
                              },
                            ),
                            Text(
                              "Halfday",
                              style: HRMTextStyles.lightText
                                  .copyWith(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      Obx(() => TitleField(
                          title: leaveDayCtrl.sectionLeave.value ==
                                  LeaveDayController.SECTION_LEAVE_TYPES[0]
                              ? "Start date"
                              : "Date")),
                      PickUpDateTextField(
                          controller: leaveDayCtrl.startDateController,
                          onCalendarIconTap: () async {
                            var pickedDate = await datePicker(context);
                            if (pickedDate != null) {
                              leaveDayCtrl.startDate.value = pickedDate;
                              leaveDayCtrl.startDateController.text =
                                  DateFormat("dd-MM-yyyy").format(pickedDate);
                            } else {
                              leaveDayCtrl.startDate.value = null;
                              leaveDayCtrl.startDateController.clear();
                            }
                          }),
                      Obx(() => leaveDayCtrl.sectionLeave.value ==
                              LeaveDayController.SECTION_LEAVE_TYPES[0]
                          ? TitleField(title: "End date")
                          : const SizedBox()),
                      Obx(
                        () => leaveDayCtrl.sectionLeave.value ==
                                LeaveDayController.SECTION_LEAVE_TYPES[0]
                            ? PickUpDateTextField(
                                controller: leaveDayCtrl.endDateController,
                                onCalendarIconTap: () async {
                                  var pickedDate = await datePicker(context);
                                  if (pickedDate != null) {
                                    leaveDayCtrl.endDate.value = pickedDate;
                                    leaveDayCtrl.endDateController.text =
                                        DateFormat("dd-MM-yyyy")
                                            .format(pickedDate);
                                  } else {
                                    leaveDayCtrl.endDate.value = null;
                                    leaveDayCtrl.endDateController.clear();
                                  }
                                },
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TitleField(title: "Session:"),
                                  SectionRadio(
                                      value:
                                          LeaveDayController.SESSION_TYPES[0],
                                      groupValue: leaveDayCtrl.sessonType.value,
                                      onChanged: (value) {
                                        print(value);
                                        leaveDayCtrl.sessonType.value =
                                            value ?? '';
                                      }),
                                  Text("Morning",
                                      style: HRMTextStyles.lightText
                                          .copyWith(color: Colors.white)),
                                  SectionRadio(
                                    value: LeaveDayController.SESSION_TYPES[1],
                                    groupValue: leaveDayCtrl.sessonType.value,
                                    onChanged: (value) {
                                      print(value);
                                      leaveDayCtrl.sessonType.value =
                                          value ?? '';
                                    },
                                  ),
                                  Text(
                                    "Afternoon",
                                    style: HRMTextStyles.lightText
                                        .copyWith(color: Colors.white),
                                  ),
                                ],
                              ),
                      ),
                      TitleField(title: "Reason (optional)", isRequired: false),
                      TextFormField(
                        controller: leaveDayCtrl.reasonController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          fillColor: Colors.white,
                          filled: true,
                        ),
                        maxLines: 4,
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: TextButton(
                          onPressed: () async {
                            if (leaveDayCtrl.leaveType == Rx(null)) {
                              Get.snackbar(
                                  "1C:HRM", "Leave type is required");
                            } else if (leaveDayCtrl.startDate == Rx(null)) {
                              Get.snackbar(
                                  "1C:HRM", "Start date is required");
                            } else if (leaveDayCtrl.endDate == Rx(null)) {
                              Get.snackbar(
                                  "1C:HRM", "End date is required");
                            } else {
                              var respond = await leaveDayCtrl.requestLeaveDay();
                              if (respond) {
                                Get.snackbar(
                                    "1C:HRM", "Your request has been saved!");
                              } else {
                                Get.snackbar(
                                    "1C:HRM", "Error while sending request!");
                              }
                            }
                          },
                          style: TextButton.styleFrom(
                              backgroundColor: Colors.white),
                          child: Text(
                            "Save & request",
                            style: HRMTextStyles.h3Text
                                .copyWith(color: HRMColorStyles.lightBlueColor),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        flex: 2,
                        child: TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                              backgroundColor: HRMColorStyles.lightBlueColor),
                          child: Text(
                            "Cancel",
                            style: HRMTextStyles.h3Text
                                .copyWith(color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<DateTime?> datePicker(BuildContext context) async {
    return await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365 * 50)),
    );
  }
}

Widget PickUpDateTextField({
  TextEditingController? controller,
  Function()? onCalendarIconTap,
}) {
  return TextField(
    readOnly: true,
    enabled: true,
    controller: controller,
    decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: "DD-MM-YYYY",
        hintStyle: HRMTextStyles.lightText
            .copyWith(color: HRMColorStyles.greyHintColor),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
        fillColor: Colors.white,
        filled: true,
        suffixIcon: IconButton(
          icon: const Icon(
            Icons.calendar_month,
          ),
          onPressed: onCalendarIconTap,
        )),
  );
}

// ignore: non_constant_identifier_names
Widget TitleField({
  String title = "",
  bool isRequired = true,
}) {
  return Padding(
    padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
    child: RichText(
      text: TextSpan(
        text: title,
        style: HRMTextStyles.lightText.copyWith(color: Colors.white),
        children: [
          TextSpan(
            text: isRequired ? " *" : "",
            style: HRMTextStyles.lightText
                .copyWith(color: Colors.red, fontStyle: FontStyle.italic),
          )
        ],
      ),
    ),
  );
}

Widget SectionRadio({
  String value = "",
  String groupValue = "",
  required void Function(String?) onChanged,
}) {
  return Container(
    child: Radio(
      value: value,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      groupValue: groupValue,
      onChanged: onChanged,
      visualDensity: VisualDensity(vertical: 0, horizontal: 0),
      fillColor: MaterialStateColor.resolveWith(
          (states) => HRMColorStyles.lightBlueColor),
    ),
  );
}

class FlowTextPanel extends StatelessWidget {
  final Widget? flowWidget;
  final Widget? child;
  Decoration? backgroundDecoration;
  Decoration? flowDecoration;
  EdgeInsets? flowPadding;
  double topSpacing;
  FlowTextPanel({
    this.child,
    this.backgroundDecoration,
    this.flowDecoration,
    this.flowWidget,
    this.flowPadding = const EdgeInsets.symmetric(horizontal: 16.0),
    this.topSpacing = 8.0,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_conditional_assignment
    if (backgroundDecoration == null) {
      backgroundDecoration = BoxDecoration(
        border: Border.all(
          color: Colors.black,
        ),
      );
    }
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(top: topSpacing),
          decoration: backgroundDecoration,
          child: child,
        ),
        Positioned(
          top: 0,
          left: 16,
          child: Container(
            child: flowWidget,
          ),
        )
      ],
    );
  }
}
