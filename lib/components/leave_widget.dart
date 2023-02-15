import 'package:flutter/material.dart';
import 'package:hrm_1c/utils/styles.dart';

class LeaveWidget extends StatelessWidget {
  final Icon icon;
  final double width;
  final String content;
  final String leaveType;
  final Color backgroundColor;
  final double borderRadius;
  final EdgeInsets margin;

  const LeaveWidget({
    this.width = 120,
    this.content = "",
    this.leaveType = "",
    required this.icon,
    this.backgroundColor = Colors.white,
    this.margin = EdgeInsets.zero,
    this.borderRadius = 8.0,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      margin: margin,
      width: width,
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon,
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2.0),
            child: Text(
              content,
              style: HRMTextStyles.normalText.copyWith(color: Colors.black),
            ),
          ),
          Text(
            leaveType,
            style: HRMTextStyles.h5Text.copyWith(
                color: HRMColorStyles.darkBlueColor,
                fontWeight: FontWeight.w100),
          )
        ],
      ),
    );
  }
}
