import 'package:flutter/material.dart';
import 'package:hrm_1c/screens/single_body_screen.dart';
import 'package:table_calendar/table_calendar.dart';

class CheckInHistoryScreen extends StatelessWidget {
  const CheckInHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleBodyScreen(
      body: TableCalendar(
        firstDay: DateTime.now().subtract(const Duration(days: 365 * 100)),
        focusedDay: DateTime.now(),
        lastDay: DateTime.now().add(const Duration(days: 365 * 50)),
        onDaySelected: (selectedDay, focusedDay) {},
      ),
    );
  }
}
