import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_1c/components/hrm_appbar.dart';
import 'package:hrm_1c/utils/styles.dart';

class RequestLeaveScreen extends StatelessWidget {
  RequestLeaveScreen({super.key});
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    startDateController.text = "18-02-2023";
    return Scaffold(
      drawer: BackButton(
        color: Colors.white,
        onPressed: () {
          Get.back();
        },
      ),
      appBar: AppBar(
        title: Text(
          "Request leave-day",
          style: HRMTextStyles.h3Text,
        ),
        backgroundColor: HRMColorStyles.darkBlueColor,
        centerTitle: true,
        leading: BackButton(
          color: Colors.white,
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        color: HRMColorStyles.blueShade800Color,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Leave type",
                  style: HRMTextStyles.lightText.copyWith(color: Colors.white),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4.0)),
                  child: DropdownButton(
                      hint: Text(
                        "Choose leave type",
                        style: HRMTextStyles.lightText
                            .copyWith(color: HRMColorStyles.greyHintColor),
                      ),
                      underline: const SizedBox(),
                      isExpanded: true,
                      items: [
                        DropdownMenuItem(
                          child: Text("Sick"),
                          value: "Sick",
                        ),
                        DropdownMenuItem(
                          child: Text("Sick"),
                          value: "Sick",
                        ),
                        DropdownMenuItem(
                          child: Text("Sick"),
                          value: "Sick",
                        ),
                      ],
                      onChanged: (value) {}),
                ),
                Text(
                  "Start date",
                  style: HRMTextStyles.lightText.copyWith(color: Colors.white),
                ),
                PickUpDateTextField(),
                Text(
                  "End date",
                  style: HRMTextStyles.lightText.copyWith(color: Colors.white),
                ),
                PickUpDateTextField(),
                Text(
                  "Reason (optional)",
                  style: HRMTextStyles.lightText.copyWith(color: Colors.white),
                ),
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
                    style: TextButton.styleFrom(backgroundColor: Colors.white),
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
                      style: HRMTextStyles.h3Text.copyWith(color: Colors.white),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
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
