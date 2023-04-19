import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_1c/components/headers/hrm_drawer.dart';
import 'package:hrm_1c/controller/leave_day_controller.dart';
import 'package:hrm_1c/controller/transfer_shift_controller.dart';
import 'package:hrm_1c/screens/single_body_screen.dart';

import 'package:hrm_1c/utils/styles.dart';
import 'package:intl/intl.dart';

class RequestInformationTransferShiftScreen extends StatelessWidget {
  RequestInformationTransferShiftScreen({super.key});
  final section = ["Morning", "Afternoon", "Full day"];
  Rx<String?> check = "".obs;

  @override
  Widget build(BuildContext context) {
    final transferShiftCtrl = Get.find<TransferShiftController>();

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
                      TitleField(title: "Main shift"),
                      PickUpDateTextField(
                          controller: transferShiftCtrl.mainShiftController,
                          onCalendarIconTap: () async {
                            var pickedDate = await datePicker(context);
                            if (pickedDate != null) {
                              transferShiftCtrl.mainShift.value = pickedDate;
                              transferShiftCtrl.mainShiftController.text =
                                  DateFormat("dd-MM-yyyy").format(pickedDate);
                            } else {
                              transferShiftCtrl.mainShift.value = null;
                              transferShiftCtrl.mainShiftController.clear();
                            }
                          }),
                      Obx(
                        () => Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SectionRadio(
                                value: TransferShiftController.SECTION_TYPES[0],
                                groupValue: transferShiftCtrl.sectionMain.value,
                                onChanged: (value) {
                                  print(value);
                                  transferShiftCtrl.sectionMain.value =
                                      value ?? '';
                                }),
                            Text("Morning",
                                style: HRMTextStyles.lightText
                                    .copyWith(color: Colors.white)),
                            SectionRadio(
                                value: TransferShiftController.SECTION_TYPES[1],
                                groupValue: transferShiftCtrl.sectionMain.value,
                                onChanged: (value) {
                                  print(value);
                                  transferShiftCtrl.sectionMain.value =
                                      value ?? '';
                                }),
                            Text(
                              "Afternoon",
                              style: HRMTextStyles.lightText
                                  .copyWith(color: Colors.white),
                            ),
                            SectionRadio(
                                value: TransferShiftController.SECTION_TYPES[2],
                                groupValue: transferShiftCtrl.sectionMain.value,
                                onChanged: (value) {
                                  print(value);
                                  transferShiftCtrl.sectionMain.value =
                                      value ?? '';
                                }),
                            Text(
                              "Full day",
                              style: HRMTextStyles.lightText
                                  .copyWith(color: Colors.white),
                            ),
                          ],
                        ),
                      ),

                      TitleField(title: "Transfer shift"),
                      PickUpDateTextField(
                          controller: transferShiftCtrl.transferShiftController,
                          onCalendarIconTap: () async {
                            var pickedDate = await datePicker(context);
                            if (pickedDate != null) {
                              transferShiftCtrl.transferShift.value =
                                  pickedDate;
                              transferShiftCtrl.transferShiftController.text =
                                  DateFormat("dd-MM-yyyy").format(pickedDate);
                            } else {
                              transferShiftCtrl.transferShift.value = null;
                              transferShiftCtrl.transferShiftController.clear();
                            }
                          }),
                      Obx(
                        () => Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SectionRadio(
                                value: TransferShiftController.SECTION_TYPES[0],
                                groupValue:
                                    transferShiftCtrl.sectionTransfer.value,
                                onChanged: (value) {
                                  print(value);
                                  transferShiftCtrl.sectionTransfer.value =
                                      value ?? '';
                                  transferShiftCtrl.sectionTransfer.value =
                                      value ?? '';
                                  (transferShiftCtrl.sectionMain.value ==
                                                  "Full day" &&
                                              transferShiftCtrl
                                                      .sectionTransfer.value ==
                                                  "Morning") ||
                                          (transferShiftCtrl
                                                      .sectionMain.value ==
                                                  "Full day" &&
                                              transferShiftCtrl
                                                      .sectionTransfer.value ==
                                                  "Afternoon")
                                      ? check = "1".obs
                                      : check = "0".obs;
                                }),
                            Text("Morning",
                                style: HRMTextStyles.lightText
                                    .copyWith(color: Colors.white)),
                            SectionRadio(
                                value: TransferShiftController.SECTION_TYPES[1],
                                groupValue:
                                    transferShiftCtrl.sectionTransfer.value,
                                onChanged: (value) {
                                  print(value);
                                  transferShiftCtrl.sectionTransfer.value =
                                      value ?? '';
                                  transferShiftCtrl.sectionTransfer.value =
                                      value ?? '';
                                  (transferShiftCtrl.sectionMain.value ==
                                                  "Full day" &&
                                              transferShiftCtrl
                                                      .sectionMain.value ==
                                                  "Morning") ||
                                          (transferShiftCtrl
                                                      .sectionMain.value ==
                                                  "Full day" &&
                                              transferShiftCtrl
                                                      .sectionMain.value ==
                                                  "Afternoon")
                                      ? check = "1".obs
                                      : check = "0".obs;
                                }),
                            Text(
                              "Afternoon",
                              style: HRMTextStyles.lightText
                                  .copyWith(color: Colors.white),
                            ),
                            SectionRadio(
                                value: TransferShiftController.SECTION_TYPES[2],
                                groupValue:
                                    transferShiftCtrl.sectionTransfer.value,
                                onChanged: (value) {
                                  print(value);
                                  transferShiftCtrl.sectionTransfer.value =
                                      value ?? '';
                                  (transferShiftCtrl.sectionMain.value ==
                                                  "Full day" &&
                                              transferShiftCtrl
                                                      .sectionMain.value ==
                                                  "Morning") ||
                                          (transferShiftCtrl
                                                      .sectionMain.value ==
                                                  "Full day" &&
                                              transferShiftCtrl
                                                      .sectionMain.value ==
                                                  "Afternoon")
                                      ? check = "1".obs
                                      : check = "0".obs;
                                }),
                            Text(
                              "Full day",
                              style: HRMTextStyles.lightText
                                  .copyWith(color: Colors.white),
                            ),
                          ],
                        ),
                      ),

                      check == "1".obs
                          ? Column(
                              children: [
                                TitleField(title: "Transfer shift 2"),
                                PickUpDateTextField(
                                    controller: transferShiftCtrl
                                        .transferShiftController,
                                    onCalendarIconTap: () async {
                                      var pickedDate =
                                          await datePicker(context);
                                      if (pickedDate != null) {
                                        transferShiftCtrl.transferShift.value =
                                            pickedDate;
                                        transferShiftCtrl
                                                .transferShiftController.text =
                                            DateFormat("dd-MM-yyyy")
                                                .format(pickedDate);
                                      } else {
                                        transferShiftCtrl.transferShift.value =
                                            null;
                                        transferShiftCtrl
                                            .transferShiftController
                                            .clear();
                                      }
                                    }),
                                Obx(
                                  () => Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SectionRadio(
                                          value: TransferShiftController
                                              .SECTION_TYPES[0],
                                          groupValue: transferShiftCtrl
                                              .sectionTransfer.value,
                                          onChanged: (value) {
                                            print(value);
                                            transferShiftCtrl.sectionTransfer
                                                .value = value ?? '';
                                          }),
                                      Text("Morning",
                                          style: HRMTextStyles.lightText
                                              .copyWith(color: Colors.white)),
                                      SectionRadio(
                                          value: TransferShiftController
                                              .SECTION_TYPES[1],
                                          groupValue: transferShiftCtrl
                                              .sectionTransfer.value,
                                          onChanged: (value) {
                                            print(value);
                                            transferShiftCtrl.sectionTransfer
                                                .value = value ?? '';
                                          }),
                                      Text(
                                        "Afternoon",
                                        style: HRMTextStyles.lightText
                                            .copyWith(color: Colors.white),
                                      ),
                                      SectionRadio(
                                          value: TransferShiftController
                                              .SECTION_TYPES[2],
                                          groupValue: transferShiftCtrl
                                              .sectionMain.value,
                                          onChanged: (value) {
                                            print(value);
                                            transferShiftCtrl.sectionMain
                                                .value = value ?? '';
                                          }),
                                      Text(
                                        "Full day",
                                        style: HRMTextStyles.lightText
                                            .copyWith(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          : const SizedBox(),
                      // Container(
                      //   padding: EdgeInsets.symmetric(horizontal: 16.0),
                      //   decoration: BoxDecoration(
                      //       color: Colors.white,
                      //       borderRadius: BorderRadius.circular(4.0)),
                      //   child: Obx(
                      //         () => DropdownButton(
                      //       hint: Text(
                      //         "Choose leave type",
                      //         style: HRMTextStyles.lightText.copyWith(
                      //             color: HRMColorStyles.greyHintColor),
                      //       ),
                      //       underline: const SizedBox(),
                      //       value: leaveDayCtrl.leaveType.value,
                      //       isExpanded: true,
                      //       items: LeaveDayController.LEAVE_TYPES
                      //           .map(
                      //             (e) => DropdownMenuItem<String>(
                      //           value: e,
                      //           child: Text(e),
                      //           onTap: () {
                      //             leaveDayCtrl.leaveType.value = e;
                      //           },
                      //         ),
                      //       )
                      //           .toList(),
                      //       onChanged: (String? value) {},
                      //     ),
                      //   ),
                      // ),
                      // Obx(
                      //       () => Row(
                      //     mainAxisAlignment: MainAxisAlignment.start,
                      //     mainAxisSize: MainAxisSize.min,
                      //     children: [
                      //       TitleField(title: "Fullday or Halfday:"),
                      //       SectionRadio(
                      //           value:
                      //           LeaveDayController.SECTION_LEAVE_TYPES[0],
                      //           groupValue: leaveDayCtrl.sectionLeave.value,
                      //           onChanged: (value) {
                      //             print(value);
                      //             leaveDayCtrl.sectionLeave.value = value ?? '';
                      //           }),
                      //       Text("Fullday",
                      //           style: HRMTextStyles.lightText
                      //               .copyWith(color: Colors.white)),
                      //       SectionRadio(
                      //         value: LeaveDayController.SECTION_LEAVE_TYPES[1],
                      //         groupValue: leaveDayCtrl.sectionLeave.value,
                      //         onChanged: (value) {
                      //           print(value);
                      //           leaveDayCtrl.sectionLeave.value = value ?? '';
                      //         },
                      //       ),
                      //       Text(
                      //         "Halfday",
                      //         style: HRMTextStyles.lightText
                      //             .copyWith(color: Colors.white),
                      //       ),
                      //     ],
                      //   ),
                      // ),

                      TitleField(title: "Reason (optional)", isRequired: false),
                      TextFormField(
                        controller: transferShiftCtrl.reasonController,
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
                            // if (leaveDayCtrl.leaveType == Rx(null)) {
                            //   Get.snackbar(
                            //       "1C:HRM", "Leave type is required");
                            // } else if (leaveDayCtrl.startDate == Rx(null)) {
                            //   Get.snackbar(
                            //       "1C:HRM", "Start date is required");
                            // } else if (leaveDayCtrl.endDate == Rx(null)) {
                            //   Get.snackbar(
                            //       "1C:HRM", "End date is required");
                            // } else {
                            //   var respond = await leaveDayCtrl.requestLeaveDay();
                            //   if (respond) {
                            //     Get.snackbar(
                            //         "1C:HRM", "Your request has been saved!");
                            //   } else {
                            //     Get.snackbar(
                            //         "1C:HRM", "Error while sending request!");
                            //   }
                            // }
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
  Future<void> getTransferShiftInformation() async {
    final transferShiftCtrl = Get.find<TransferShiftController>();
    for (var day in transferShiftCtrl.cellTypes) {

    }
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
