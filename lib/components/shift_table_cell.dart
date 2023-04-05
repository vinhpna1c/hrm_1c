import 'package:flutter/material.dart';

//define color cell status

class ShiftTableCell extends StatelessWidget {
  Widget? child;
  Alignment aligment;
  Color cellColor;
  Function? onTap;

  static Color NONE_COLOR = Colors.white;
  static Color WORKING_COLOR = Colors.green.shade100;
  static Color PENDING_REQ_COLOR = Colors.yellow.shade100;
  static Color ACCEPT_REQ_COLOR = Colors.green.shade200;
  static Color DENY_REQ_COLOR = Colors.red.shade100;

  ShiftTableCell(
      {this.child,
      this.aligment = Alignment.center,
      this.cellColor = Colors.white,
      this.onTap,
      super.key});

  @override
  Widget build(BuildContext context) {
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
