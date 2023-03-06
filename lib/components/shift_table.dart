import 'package:flutter/material.dart';
import 'package:hrm_1c/models/contract.dart';

class ShiftTable extends StatelessWidget {
  final List<TimeSheet>? timeSheets;
  static final DAYS_IN_WEEK = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday"
  ];
  const ShiftTable({
    super.key,
    this.timeSheets,
  });

  @override
  Widget build(BuildContext context) {
    Map<String, List<Widget>> shiftsInWeek = {};
    //generate map
    for (var day in DAYS_IN_WEEK) {
      shiftsInWeek[day] = [
        ShiftTableCell(child: Text(day), aligment: Alignment.centerLeft),
        ShiftTableCell(),
        ShiftTableCell(),
      ];
    }

    if (timeSheets != null) {
      for (var timeSheet in timeSheets!) {
        if (shiftsInWeek[timeSheet.workDate ?? ""] != null) {
          if ((timeSheet.section ?? "").toLowerCase().contains('morning')) {
            shiftsInWeek[timeSheet.workDate ?? ""]![1] =
                ShiftTableCell(cellColor: Colors.green);
          } else if ((timeSheet.section ?? "")
              .toLowerCase()
              .contains('afternoon')) {
            shiftsInWeek[timeSheet.workDate ?? ""]![2] =
                ShiftTableCell(cellColor: Colors.green);
          }
        }
      }
    }
    return Table(
      border: TableBorder.all(color: Colors.grey),
      defaultColumnWidth: FixedColumnWidth(80),
      children: [
        TableRow(
          children: [
            ShiftTableCell(),
            ShiftTableCell(child: Text("Morning")),
            ShiftTableCell(child: Text("Afternoon")),
          ],
        ),
        ...shiftsInWeek.keys.map(
          (e) => TableRow(
            children: shiftsInWeek[e],
          ),
        )
      ],
    );
  }
}

Widget ShiftTableCell(
    {Widget? child,
    Alignment aligment = Alignment.center,
    Color cellColor = Colors.white}) {
  return TableCell(
    child: Container(
      alignment: aligment,
      color: cellColor,
      height: 40,
      child: child,
    ),
  );
}
