import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_1c/controller/transfer_shift_controller.dart';
import 'package:hrm_1c/models/contract.dart';

class ShiftTable extends StatefulWidget {
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
            // ...ShiftTable.DAYS_IN_WEEK.map((e) => )
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

Widget ShiftTableCell(
    {Widget? child,
    Alignment aligment = Alignment.center,
    Color cellColor = Colors.white,
    Function? onTap}) {
  return Container(
    // margin: EdgeInsets.all(2.0),
    decoration: BoxDecoration(
      color: cellColor,
      border: Border.all(color: Colors.grey.shade500, width: 0.5),
    ),
    alignment: aligment,
    width: 80,
    height: 40,
    child: child,
  );
}
