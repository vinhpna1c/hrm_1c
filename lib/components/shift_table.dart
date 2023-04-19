import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_1c/components/shift_table_cell.dart';
import 'package:hrm_1c/controller/transfer_shift_controller.dart';
import 'package:hrm_1c/models/contract.dart';
import 'package:intl/intl.dart';

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
  final Rx<bool>? result;
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
    this.result,
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
    transferShiftCtrl.cellTypes.clear();
    for(int i=0;i<21;i++)
      {
        transferShiftCtrl.cellTypes.add(0.obs);
      }
    transferShiftCtrl.setTimeSheets(widget.timeSheets);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> tableCells = [];

    for (var day in DAYS_IN_WEEK.values) {
      //add first cell
      tableCells.add(ShiftTableCell(child: Text(day.name)));
      //add 2 sessions in day
      tableCells.add(GestureDetector(
        onTap: (){
          if (transferShiftCtrl.cellTypes[day.index*3+1].value ==0) {
            transferShiftCtrl.cellTypes[day.index*3+1].value=1;
          } else {
            transferShiftCtrl.cellTypes[day.index*3+1].value=0;
          }
          UpdateType(day.index*3+1);
        },
          child: Obx(() => (ShiftTableCell(type: transferShiftCtrl.cellTypes[day.index*3+1].value))
      )));
      tableCells.add(GestureDetector(
          onTap: (){
            if (transferShiftCtrl.cellTypes[day.index*3+2].value ==0) {
              transferShiftCtrl.cellTypes[day.index*3+2].value=1;
            } else {
              transferShiftCtrl.cellTypes[day.index*3+2].value=0;
            }
            UpdateType(day.index*3+2);
          },
          child: Obx(() => (ShiftTableCell(type: transferShiftCtrl.cellTypes[day.index*3+2].value))
      )));
    }

    //update display by timeSheets
    for (var timeSheet in widget.timeSheets ?? <TimeSheet>[]) {
      // ignore: prefer_interpolation_to_compose_strings
      int index =
          DAYS_IN_WEEK.values.byName(timeSheet.workDate ?? "").index * 3;
      //check morning or afternoon
      if ((timeSheet.section ?? "").toLowerCase().contains("morning")) {
        index += 1;
        transferShiftCtrl.cellTypes[index].value = 2;
      } else {
        index += 2;
        transferShiftCtrl.cellTypes[index].value = 2;
      }
      tableCells[index] = GestureDetector(
        onTap: (){
          if (transferShiftCtrl.cellTypes[index].value ==2) {
            transferShiftCtrl.cellTypes[index].value=3;
          } else if (transferShiftCtrl.cellTypes[index].value ==3) {
            transferShiftCtrl.cellTypes[index].value = 2;
          }
          UpdateType(index);
        },
        child: Obx( () =>
        ShiftTableCell(
              child: Icon(
                Icons.check_rounded,
              ),
              type: transferShiftCtrl.cellTypes[index].value,
          ),
        )
      );
    }


    return Container(
      width: 330,
      height: 450,
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

  int CheckPickedCell(bool send) {
    int countWorkPicked = 0;
    List<int> arrayWorkPicked = [];
    int countNonePicked = 0;
    List<int> arrayNonePicked = [];
    for (int i =0; i<transferShiftCtrl.cellTypes.length; i++) {
      if (transferShiftCtrl.cellTypes[i]==3) {
        countWorkPicked = countWorkPicked + 1;
        arrayWorkPicked.add(i);
      } else if (transferShiftCtrl.cellTypes[i]==1) {
        countNonePicked = countNonePicked + 1;
        arrayNonePicked.add(i);
      }
    }
    if (!send) {
      if (countWorkPicked > 2) {
        return 0;
      } else if (countWorkPicked == 2) {
        if (arrayWorkPicked[0] < arrayWorkPicked[1]) {
          if (!(arrayWorkPicked[0] - (arrayWorkPicked[0]~/3)*3 == 1 && arrayWorkPicked[1] == arrayWorkPicked[0]+1)) {
            return 1;
          }
        } else {
          if (!(arrayWorkPicked[1] - (arrayWorkPicked[1]~/3)*3 == 1 && arrayWorkPicked[0] == arrayWorkPicked[1]+1)) {
            return 1;
          }
        }
      }
      if (countNonePicked > 2) {
        return 2;
      }
    }
    return -1;
  }

  Future<void> UpdateType(index) async {
    int check = CheckPickedCell(false);
    if (check == -1) {
    } else if (check ==0) {
      Get.snackbar("1C:HRM",
          "You can't pick more than 2 working day");
      transferShiftCtrl.cellTypes[index].value=2;
    } else if (check ==1) {
      Get.snackbar("1C:HRM",
          "You can't pick 2 working day of 2 different days");
      transferShiftCtrl.cellTypes[index].value=2;
    } else {
      Get.snackbar("1C:HRM",
          "You can't pick more than 2 off day");
      transferShiftCtrl.cellTypes[index].value=0;
    }
  }
}
