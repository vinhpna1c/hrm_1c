import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_1c/controller/transfer_shift_controller.dart';
import 'package:hrm_1c/models/contract.dart';

import '../screens/leave_days/request_information_transfer_shift_screen.dart';

class ShiftTable extends StatefulWidget {
  final List<TimeSheet>? timeSheets;
  final DAYS_IN_WEEK = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday"
  ];
  ShiftTable({
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
    List<int> arr = checkShift();
    return GestureDetector(
      onTap: () {
        print("Success");
      },
      child: Container(
        width: 360,
        height: 500,
        child: GridView.count(
          childAspectRatio: 2,
          shrinkWrap: true,
          crossAxisCount: 3, // number of columns
          children: [
            ShiftTableCell(),
            ShiftTableCell(text: "Morning"),
            ShiftTableCell(text: "Afternoon"),
            ShiftTableCell(text: "Monday"),
            ShiftTableCell(check: arr[0]),
            ShiftTableCell(check: arr[1]),
            ShiftTableCell(text: "Tuesday"),
            ShiftTableCell(check: arr[2]),
            ShiftTableCell(check: arr[3]),
            ShiftTableCell(text: "Wednesday"),
            ShiftTableCell(check: arr[4]),
            ShiftTableCell(check: arr[5]),
            ShiftTableCell(text: "Thursday"),
            ShiftTableCell(check: arr[6]),
            ShiftTableCell(check: arr[7]),
            ShiftTableCell(text: "Friday"),
            ShiftTableCell(check: arr[8]),
            ShiftTableCell(check: arr[9]),

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
  List<int> checkShift() {
    List<int> arr = [0,0,0,0,0,0,0,0,0,0,0,0];
    for (var i=0; i < widget.timeSheets!.length; i++){
      int n = widget.DAYS_IN_WEEK.indexOf(widget.timeSheets![i].workDate!);
      if (widget.timeSheets![i].section! == "Morning") {
        arr[n*2] = 1;
      } else {
        arr[n * 2 + 1] = 1;
      }
    }
    return arr;
  }
}



Widget ShiftTableCell(
    {String? text,
    Alignment aligment = Alignment.center,
    Color cellColor = Colors.white,
    Function? onTap,
    int? check}) {
  return GestureDetector(
    onTap: () async {
      if (check == 1) {
        Get.to(RequestInformationTransferShiftScreen());
      }
    },
    child: Container(
      // margin: EdgeInsets.all(2.0),
      decoration: BoxDecoration(
        color: check == 1 ? Color(0xFFF0FFF0) : cellColor,
        border: Border.all(color: Colors.grey.shade500, width: 0.5),
      ),
      alignment: aligment,
      width: 120,
      height: 30,
      child: text != null ? Text(
        text ?? "",
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ) : check == 1 ? Icon(Icons.check) : null,
    ),
  );
}
