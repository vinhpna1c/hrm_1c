import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_1c/components/hrm_drawer.dart';
import 'package:hrm_1c/controller/leave_day_controller.dart';
import 'package:hrm_1c/screens/single_body_screen.dart';

import 'package:hrm_1c/utils/styles.dart';

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
                      TitleField(title: "Start date"),
                      PickUpDateTextField(),
                      TitleField(title: "End date"),
                      PickUpDateTextField(),
                      TitleField(title: "Reason (optional)"),
                      TextFormField(
                        decoration: InputDecoration(
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
                          onPressed: () {},
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

  Widget SectionRadio({
    String value = "",
    String groupValue = "",
    required void Function(String?) onChanged,
  }) {
    return Radio(
      value: value,
      groupValue: groupValue,
      onChanged: onChanged,
      fillColor: MaterialStateColor.resolveWith(
          (states) => HRMColorStyles.lightBlueColor),
    );
  }

  Widget PickUpDateTextField() {
    return TextField(
      enabled: false,
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: "DD-MM-YYYY (hh:mm)",
          hintStyle: HRMTextStyles.lightText
              .copyWith(color: HRMColorStyles.greyHintColor),
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          fillColor: Colors.white,
          filled: true,
          suffixIcon: IconButton(
            icon: Icon(
              Icons.calendar_month,
            ),
            onPressed: () {},
          )),
    );
  }
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
