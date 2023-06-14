import 'package:flutter/material.dart';
import 'package:hrm_1c/components/employee_avatar.dart';
import 'package:hrm_1c/models/personal_information.dart';
import 'package:get/get.dart';

import '../screens/employees/new_employee_screen.dart';

class EmployeeItem extends StatelessWidget {
  final PersonalInformation? employee;
  final DisplayStatus? displayStatus;
  const EmployeeItem({
    Key? key,
    this.employee,
    this.displayStatus,
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
          GestureDetector(
            onTap: () => Get.to(NewEmployeeScreen(employee: employee!,)),
            child: EmployeeAvatar(
              displayStatus: displayStatus ?? DisplayStatus.NOT_VISIBLE,
              backgroundRadius: 32,
              imageURL: employee != null ? employee!.URL : null,
            ),
          ),
          Text(
            employee != null ? employee!.description ?? "" : "",
            maxLines: 2,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
            ),
          )
        ],
      ),
    );
  }
}
