import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_1c/components/shift_table_cell.dart';
import 'package:hrm_1c/controller/transfer_shift_controller.dart';
import 'package:hrm_1c/models/contract.dart';

enum DAYS_IN_WEEK {
  Monday,
  Tuesday,
  Wednesday,
  Thursday,
  Friday,
  Saturday,
  Sunday
}

class ShiftTable extends StatefulWidget {
  final List<TimeSheet>? timeSheets;
  // static final DAYS_IN_WEEK = [
  //   "Monday",
  //   "Tuesday",
  //   "Wednesday",
  //   "Thursday",
  //   "Friday",
  //   "Saturday",
  //   "Sunday"
  // ];
  const ShiftTable({
    super.key,
    this.timeSheets,
  });

  @override
  State<ShiftTable> createState() => _ShiftTableState();
}

class _ShiftTableState extends State<ShiftTable> {
  final transferShiftCtrl = Get.put(TransferShiftController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    transferShiftCtrl.setTimeSheets(widget.timeSheets);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> tableCells = [];
    //add row by row in table

    for (var day in DAYS_IN_WEEK.values) {
      //add first cell
      tableCells.add(ShiftTableCell(child: Text(day.name)));
      //add 2 sessions in day
      tableCells.add(ShiftTableCell());
      tableCells.add(ShiftTableCell());
    }

    //update display by timeSheets
    for (var timeSheet in widget.timeSheets ?? <TimeSheet>[]) {
      // ignore: prefer_interpolation_to_compose_strings
      int index =
          DAYS_IN_WEEK.values.byName(timeSheet.workDate ?? "").index * 3;
      //check morning or afternoon
      if ((timeSheet.section ?? "").toLowerCase().contains("morning")) {
        index += 1;
      } else {
        index += 2;
      }
      //update display in timesheet
      tableCells[index] = ShiftTableCell(
          child: Icon(
            Icons.check_rounded,
          ),
          cellColor: ShiftTableCell.WORKING_COLOR);
    }

    return GestureDetector(
      onTap: () {
        print("Success");
      },
      child: Container(
        width: 240,
        height: 500,
        child: GridView.count(
          childAspectRatio: 2,
          shrinkWrap: true,
          crossAxisCount: 3, // number of columns
          children: [
            ShiftTableCell(),
            ShiftTableCell(child: Text("Morning")),
            ShiftTableCell(child: Text("Afternoon")),
            ...tableCells,
          ],
        ),
      ),
    );

    // DataTable(
    //   // border: TableBorder.all(color: Colors.grey),
    //   columnSpacing: 1.0,
    //   dataRowHeight: 40,

    //   columns: [
    //     DataColumn(
    //       label: Center(child: Text("")),
    //     ),
    //     DataColumn(
    //       label: Text("Morning"),
    //     ),
    //     DataColumn(
    //       label: Text("Afternoon"),
    //     ),
    //   ],
    //   rows: [
    //     ...transferShiftCtrl.requestMap.keys.map(
    //       (e) => DataRow(cells: [
    //         ShiftTableCell(child: Text(e)),
    //         ...List.generate(
    //           transferShiftCtrl.requestMap[e]!.length,
    //           (index) => ShiftTableCell(
    //               onTap: () {
    //                 transferShiftCtrl.setCellSelected(e, index);
    //               },
    //               cellColor: TransferShiftStatusColor[
    //                   transferShiftCtrl.requestMap[e]![index].index]),
    //         ),
    //       ]),
    //     )
    //   ],
    // );
  }
}
