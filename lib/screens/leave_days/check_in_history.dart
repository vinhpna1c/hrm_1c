
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:get/get.dart';
import 'package:hrm_1c/screens/single_body_screen.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../controller/leave_day_controller.dart';
import '../../controller/time_keeping_controller.dart';
import '../../controller/user_controller.dart';

class CheckInHistoryScreen extends StatelessWidget {
   CheckInHistoryScreen({super.key});
  final timeKeepingController = Get.put(TimeKeepingController());
  final leaveDayCtrl = Get.find<LeaveDayController>();
  bool checkWorkDay(DateTime checkDay) {
    for (var day in timeKeepingController.checkInDays) {
      if (day.year == checkDay.year && day.month == checkDay.month && day.day == checkDay.day) {
        return true;
      }
    }
    return false;
  }

  bool checkOffDay(DateTime checkDay) {
    for (var day in timeKeepingController.workPartTimeDays) {
      if (checkDay.weekday == day) {
        return false;
      }
    }
    return true;
  }

   bool checkLeaveDay(DateTime checkDay) {
     for (var day in leaveDayCtrl.leaveDays) {
       if (day.year == checkDay.year && day.month == checkDay.month && day.day == checkDay.day) {
         return true;
       }
     }
     return false;
   }

  @override
  Widget build(BuildContext context) {
    timeKeepingController.getPersonalCheckInDays();
    timeKeepingController.getWorkPartTimeDays();
    leaveDayCtrl.getPersonalLeaveDay();
    Rx<DateTime> today = DateTime.now().obs;
    return SingleBodyScreen(
      // body: Obx(
      //   ()=> TableCalendar(
      //     firstDay: DateTime.now().subtract(const Duration(days: 365 * 100)),
      //     focusedDay: today.value,
      //     lastDay: DateTime.now().add(const Duration(days: 365 * 50)),
      //     onDaySelected: _onDaySelected,
      //     selectedDayPredicate: (day) => isSameDay(day, today.value),
      //     //currentDay: today.value,
      //     headerStyle: HeaderStyle(
      //       formatButtonVisible: false,
      //       titleCentered: true,
      //     ),
      //     availableGestures: AvailableGestures.all,
      //     calendarStyle: CalendarStyle(
      //       markerDecoration: BoxDecoration(
      //         color: Colors.yellow,
      //         borderRadius: BorderRadius.circular(20)
      //       ),
      //
      //     ),
      //     eventLoader: ,
      //   ),
      // ),
      body: Column(
        children: [
          Obx(
              ()=> Container(
              margin: EdgeInsets.symmetric(horizontal: 16.0),
              child: CalendarCarousel<Event>(
                onDayPressed: (DateTime date, List<Event> events) {
                  today.value = date;
                },
                weekendTextStyle: TextStyle(
                  color: Color(0xFF0B5D76),
                  fontFamily: "Kanit",
                ),
                daysTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: "Kanit",
                ),
                selectedDayButtonColor: Colors.red,
                selectedDayBorderColor: Colors.grey,
                selectedDayTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: "Kanit",
                ),
                disableDayPressed: true,
                headerTextStyle: TextStyle(
                  color: Color(0xFF194B5A),
                  fontSize: 22,
                  fontFamily: "Kanit",
                ),
                iconColor: Colors.black,
                weekdayTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: "Kanit",
                ),
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
                  if (checkWorkDay(day)) {
                    return Center(
                      child: Container(
                        // decoration: BoxDecoration(
                        //   border: Border(
                        //     top: BorderSide(color: Color(0xFF698B22), width: 8),
                        //     left: BorderSide(color: Color(0xFF698B22)),
                        //     right: BorderSide(color: Color(0xFF698B22)),
                        //     bottom: BorderSide(color: Color(0xFF698B22)),
                        //   )
                        // ),
                        color: Color(0xFF698B22),
                        width: double.infinity,
                        height: double.infinity,
                        alignment: Alignment.center,
                        child: Text(day.day.toString(),
                          style: const TextStyle(
                            color: Colors.black,
                            fontFamily: "Kanit",
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  } else if (day.isBefore(DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day,0,0,0,0,0))) {
                      if (checkLeaveDay(day)) {
                        return Center(
                          child: Container(
                            // decoration: BoxDecoration(
                            //     border: Border(
                            //       top: BorderSide(color: Color(0xFF8B25006), width: 8),
                            //       left: BorderSide(color: Color(0xFF8B25006)),
                            //       right: BorderSide(color: Color(0xFF8B25006)),
                            //       bottom: BorderSide(color: Color(0xFF8B25006)),
                            //     )
                            // ),
                            color: Color(0xFFDDC488),
                            width: double.infinity,
                            height: double.infinity,
                            alignment: Alignment.center,
                            child: Text(day.day.toString(),
                              style: const TextStyle(
                                color: Colors.black,
                                fontFamily: "Kanit",
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                      }
                      else if (!checkOffDay(day)) {
                        return Center(
                          child: Container(
                            // decoration: BoxDecoration(
                            //   border: Border(
                            //     top: BorderSide(color: Color(0xFF698B22), width: 8),
                            //     left: BorderSide(color: Color(0xFF698B22)),
                            //     right: BorderSide(color: Color(0xFF698B22)),
                            //     bottom: BorderSide(color: Color(0xFF698B22)),
                            //   )
                            // ),
                            color: Color(0xFFEE7942),
                            width: double.infinity,
                            height: double.infinity,
                            alignment: Alignment.center,
                            child: Text(day.day.toString(),
                              style: const TextStyle(
                                color: Colors.black,
                                fontFamily: "Kanit",
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                      }
                  }
                },
                weekFormat: false,
                height: 420.0,
                selectedDateTime: today.value,
                daysHaveCircularBorder: false,
              ),
            ),
          ),
          // Container(
          //     child: Column(
          //       children: [
          //         Note(Color(0xFF698B22), "Work day"),
          //         Note(Color(0xFFDDC488), "Leave day"),
          //         Note(Color(0xFFEE7942), "Absent day"),
          //         Note(Colors.red, "Today"),
          //         Note(Color(0xFF194B5A), "Selected day"),
          //       ],
          //     )
          // ),
          Stack(
            children: <Widget>[
              Container(
                width: double.infinity,
                height: 130,
                margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Color(0xFF194B5A), width: 1),
                  borderRadius: BorderRadius.circular(5),
                  shape: BoxShape.rectangle,
                ),
                  child: Column(
                    children: [
                      Note(Color(0xFF698B22), "Work day"),
                      Note(Color(0xFFDDC488), "Leave day"),
                      Note(Color(0xFFEE7942), "Absent day"),
                      Note(Colors.red, "Today"),
                    ],
                  )
              ),
              Positioned(
                left: 50,
                top: 12,
                child: Container(
                  padding: EdgeInsets.only( left: 10, right: 10),
                  color: Colors.white,
                  child: Text(
                    'Note',
                    style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold, fontFamily: "Kanit",),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
  Widget Note(Color color, String text){
    return Row(
      children: [
        Container(
          margin: EdgeInsets.only(
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
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
            fontFamily: "Kanit",
          ),
        ),
      ],
    );
  }
}
