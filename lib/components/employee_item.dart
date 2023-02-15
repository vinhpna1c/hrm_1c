import 'package:flutter/material.dart';
import 'package:hrm_1c/components/employee_avatar.dart';

class EmployeeItem extends StatelessWidget {
  const EmployeeItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 96,
      width: 64,
      margin: EdgeInsets.symmetric(horizontal: 4.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          EmployeeAvatar(
            backgroundRadius: 32,
          ),
          Text(
            "Employee name",
            maxLines: 2,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
