import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_1c/utils/styles.dart';
import 'package:intl/intl.dart';
import 'package:timer_builder/timer_builder.dart';

class SlideDigitalClock extends StatelessWidget {
  SlideDigitalClock({super.key});
  final RxBool _visible = true.obs;

  @override
  Widget build(BuildContext context) {
    return TimerBuilder.periodic(Duration(milliseconds: 500),
        builder: (context) {
      var today = DateTime.now();
      _visible.value = !_visible.value;

      return Container(
        margin: EdgeInsets.only(top: 16.0),
        width: double.infinity,
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...DateFormat("hh")
                .format(today)
                .split("")
                .map((e) => NumberDigitContainer(e)),

            // NumberDigitContainer("4"),
            AnimatedOpacity(
              opacity: _visible.value ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 500),
              child: Container(
                margin: EdgeInsets.only(right: 4),
                height: 60,
                alignment: Alignment.center,
                child: Text(
                  ":",
                  style: HRMTextStyles.boldText.copyWith(fontSize: 30),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            ...DateFormat("mm")
                .format(today)
                .split("")
                .map((e) => NumberDigitContainer(e)),

            // Container(
            //   margin: EdgeInsets.only(right: 4),
            //   height: 60,
            //   alignment: Alignment.center,
            //   child: Text(
            //     ":",
            //     style: HRMTextStyles.boldText.copyWith(fontSize: 30),
            //     textAlign: TextAlign.center,
            //   ),
            // ),
            // NumberDigitContainer("0"),
            // NumberDigitContainer("1"),
            Container(
              width: 30,
              height: 60,
              alignment: Alignment.bottomLeft,
              child: Text(
                DateFormat("a").format(today).toUpperCase(),
                style: HRMTextStyles.boldText.copyWith(fontFamily: "Open-sans"),
              ),
            )
          ],
        ),
      );
    });
  }

  Widget NumberDigitContainer(String char) {
    return Container(
      width: 40,
      height: 60,
      padding: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      alignment: Alignment.center,
      margin: const EdgeInsets.only(right: 4.0),
      child: Text(
        char,
        style: HRMTextStyles.clockText,
      ),
    );
  }
}
