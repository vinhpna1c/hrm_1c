import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

//define color cell status

class ShiftTableCell extends StatelessWidget {
  Widget? child;
  Alignment aligment;

  //Color cellColor;
  int type;

  Function? onTap;

  static Color NONE_COLOR = Colors.white;
  static Color WORKING_COLOR = Color(0xFFCCFFFF);
  static Color NONE_PICKED_COLOR = Color(0xFFBEBEBE);
  static Color WORKING_PICKED_COLOR = Color(0xFF006666);
  static Color PENDING_REQ_COLOR = Colors.yellow.shade100;
  static Color ACCEPT_REQ_COLOR = Colors.green.shade200;
  static Color DENY_REQ_COLOR = Colors.red.shade100;
  static Color TRANSFER_COLOR = Color(0xFFA52A2A);

  ShiftTableCell(
      {this.child,
      this.aligment = Alignment.center,
      //this.cellColor = Colors.white,
      this.type = 0,
      this.onTap,
      super.key});

  @override
  Widget build(BuildContext context) {
    print(type);
    Color cellColor = Colors.white;
    // 2=working
    // 3=working_picked
    // 0=off
    // 1=off_picked
    // 4=transfer_shift
    switch (type) {
      case 0:
        cellColor = NONE_COLOR;
        break;
      case 1:
        cellColor = NONE_PICKED_COLOR;
        break;
      case 2:
        cellColor = WORKING_COLOR;
        break;
      case 3:
        cellColor = WORKING_PICKED_COLOR;
        break;
      case 4:
        cellColor = TRANSFER_COLOR;
        break;
        default :
          cellColor = NONE_COLOR;
    }
    return Container(
      // margin: EdgeInsets.all(2.0),
      decoration: BoxDecoration(
        color: cellColor,
        border: Border.all(color: Colors.grey.shade500, width: 0.5),
      ),
      alignment: aligment,
      width: 110,
      height: 40,
      child: child,
    );
  }
}
