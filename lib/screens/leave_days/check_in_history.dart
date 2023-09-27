import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:get/get.dart';
import 'package:hrm_1c/screens/single_body_screen.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../controller/leave_day_controller.dart';
import '../../controller/time_keeping_controller.dart';
import '../../controller/user_controller.dart';

final checkInDayColorMap = {
  CheckInDateType.WORK_DATE: const Color(0xFF698B22),
  CheckInDateType.LEAVE_DATE: const Color(0xFFDDC488),
  CheckInDateType.ABSENT_DATE: const Color(0xFFEE7942),
};

class CheckInHistoryScreen extends StatefulWidget {
  const CheckInHistoryScreen({super.key});

  @override
  State<CheckInHistoryScreen> createState() => _CheckInHistoryScreenState();
}

class _CheckInHistoryScreenState extends State<CheckInHistoryScreen> {
  final tkCtrl = Get.put(TimeKeepingController());

  final leaveDayCtrl = Get.find<LeaveDayController>();

  CheckInDateType getDateType(DateTime date) {
    var res = tkCtrl.checkInDays
        .firstWhereOrNull((d) => DateUtils.isSameDay(d, date));

    // weekend is off day and not in month
    if (date.weekday == DateTime.saturday ||
        date.weekday == DateTime.sunday ||
        date.isAfter(DateTime.now())) {
      return CheckInDateType.OFF_DATE;
    }

    // is work day
    if (res != null) {
      return CheckInDateType.WORK_DATE;
    }
    // check if is part time day off
    if (tkCtrl.workPartTimeDays.isNotEmpty) {
      int? res =
          tkCtrl.workPartTimeDays.firstWhereOrNull((d) => date.weekday != d);
      if (res != null) {
        return CheckInDateType.OFF_DATE;
      }
    }
    // check if is leave day
    if (leaveDayCtrl.leaveDays.isNotEmpty) {
      var res = leaveDayCtrl.leaveDays
          .firstWhereOrNull((d) => DateUtils.isSameDay(d, date));
      if (res != null) {
        return CheckInDateType.LEAVE_DATE;
      }
    }

    return CheckInDateType.ABSENT_DATE;
  }

  @override
  void initState() {
    super.initState();
    tkCtrl.getPersonalCheckInDays().then((value) {
      tkCtrl.checkInDays.clear();
      tkCtrl.checkInDays.addAll(value);
    });
    tkCtrl.getWorkPartTimeDays();
    leaveDayCtrl.getPersonalLeaveDay();
  }

  Rx<DateTime> selectedMonth = DateTime.now().copyWith(day: 1).obs;
  @override
  Widget build(BuildContext context) {
    return SingleBodyScreen(
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16.0),
            child: CalendarCarousel<Event>(
              weekendTextStyle: const TextStyle(
                color: Color(0xFF0B5D76),
                fontFamily: "Kanit",
              ),
              daysTextStyle: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontFamily: "Kanit",
              ),
              selectedDayButtonColor: Colors.red,
              selectedDayBorderColor: Colors.grey,
              selectedDayTextStyle: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontFamily: "Kanit",
              ),
              disableDayPressed: true,
              headerTextStyle: const TextStyle(
                color: Color(0xFF194B5A),
                fontSize: 22,
                fontFamily: "Kanit",
              ),
              onLeftArrowPressed: () {
                selectedMonth.value = selectedMonth.value
                    .subtract(Duration(days: 30))
                    .copyWith(day: 1);
              },
              onRightArrowPressed: () {
                selectedMonth.value = selectedMonth.value
                    .add(Duration(days: 30))
                    .copyWith(day: 1);
              },
              iconColor: Colors.black,
              weekdayTextStyle: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontFamily: "Kanit",
              ),
              todayBorderColor: Colors.blue,
              thisMonthDayBorderColor: Colors.grey,
              customDayBuilder: (
                bool isSelectable,
                int index,
                bool isSelectedDay,
                bool isToday,
                bool isPrevMonthDay,
                TextStyle textStyle,
                bool isNextMonthDay,
                bool isThisMonthDay,
                DateTime day,
              ) {
                CheckInDateType dateType = getDateType(day);
                return Container(
                  alignment: Alignment.center,
                  color: isToday
                      ? Colors.blue
                      : (checkInDayColorMap[dateType] ?? Colors.transparent),
                  child: Text(
                    day.day.toString(),
                    style: TextStyle(
                      color: isToday ? Colors.white : Colors.black,
                      fontFamily: "Kanit",
                    ),
                    textAlign: TextAlign.center,
                  ),
                );
              },
              weekFormat: false,
              height: 420.0,
              daysHaveCircularBorder: false,
            ),
          ),
          Stack(
            children: <Widget>[
              Container(
                  width: double.infinity,
                  height: 130,
                  margin: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border:
                        Border.all(color: const Color(0xFF194B5A), width: 1),
                    borderRadius: BorderRadius.circular(5),
                    shape: BoxShape.rectangle,
                  ),
                  child: Column(
                    children: [
                      Note(const Color(0xFF698B22), "Work day"),
                      Note(const Color(0xFFDDC488), "Leave day"),
                      Note(const Color(0xFFEE7942), "Absent day"),
                      Note(Colors.blue, "Today"),
                    ],
                  )),
              Positioned(
                left: 50,
                top: 12,
                child: Container(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  color: Colors.white,
                  child: const Text(
                    'Note',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Kanit",
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget Note(Color color, String text) {
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.only(
            left: 20,
            right: 20,
            top: 5,
            bottom: 5,
          ),
          height: 15,
          width: 15,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        Text(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
            fontFamily: "Kanit",
          ),
        ),
      ],
    );
  }
}
