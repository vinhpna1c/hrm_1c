import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hrm_1c/screens/root_screen.dart';
import 'package:intl/intl.dart';

import '../../components/employee_avatar.dart';
import '../../models/personal_information.dart';
import '../../utils/styles.dart';
import '../account/account_screen.dart';
import '../leave_days/request_information_transfer_shift_screen.dart';
import '../single_body_screen.dart';

class NewEmployeeScreen extends StatelessWidget {
  final PersonalInformation employee;
  const NewEmployeeScreen({required this.employee, super.key});

  @override
  Widget build(BuildContext context) {
    DateFormat df = new DateFormat('dd-MM-yyyy');
    return SingleBodyScreen(
      body: CustomScrollView(

        slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            margin: const EdgeInsets.only(bottom: 4.0),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // EmployeeAvatar(
                //   backgroundRadius: 60,
                //   paddingSpace: 4.0,
                //   imageURL: employee!.URL,
                //   displayActive: false,
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        employee!.URL ?? "",
                        height: 150.0,
                        width: 100.0,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          employee.description!,
                          style: TextStyle
                            (
                              fontSize: 20,
                              color: Colors.black,
                              fontFamily: "Kanit",
                            ),
                        ),
                        Text(
                          employee.position ?? "",
                          style: TextStyle
                            (
                            fontSize: 14,
                            color: Colors.grey,
                            fontFamily: "Kanit",
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    RowInformation(
                        fieldName: "Code", content: employee.code ?? ""),
                    RowInformation(
                        fieldName: "Name", content: employee.description ?? ""),
                    RowInformation(
                        fieldName: "Gender",
                        content: employee.gender ?? ""),
                    RowInformation(
                        fieldName: "Date of birth",
                        content: DateFormat("dd-MM-yyyy").format(
                            employee.dateOfBirth ?? DateTime.now())),
                    RowInformation(
                        fieldName: "Email", content: employee.email ?? ""),
                    RowInformation(
                        fieldName: "Phone",
                        content: employee!.numberPhone ?? ""),
                    RowInformation(
                        fieldName: "Address",
                        content: employee!.address ?? ""),
                    RowInformation(
                        fieldName: "Nationality",
                        content: employee!.nationality ?? ""),
                    RowInformation(
                        fieldName: "Marital Status",
                        content: employee!.maritalStatus ?? ""),
                  ],
                )
              ],
            ),
          ),
        )
          ]
      ),
    );
  }
}

Widget TextInformation({String field = "", String content = ""}) {
  // return Row(
  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //     children: [
  //       Text(field, style: HRMTextStyles.h4Text),
  //       Container(
  //         padding: EdgeInsets.only(
  //             left: 8,
  //             right: 8,
  //             bottom: 4,
  //             top: 4
  //         ),
  //         // decoration: BoxDecoration(
  //         //   border: Border.all(color: Colors.black),
  //         // ),
  //         child: Text(content,
  //             style: HRMTextStyles.h4Text.copyWith(fontWeight: FontWeight.w100)),
  //       ),
  //     ]
  // );
  return Stack(
    children: <Widget>[
      Container(
          width: double.infinity,
          margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            border: Border.all(
                color: Color(0xFF194B5A), width: 1),
            borderRadius: BorderRadius.circular(5),
            shape: BoxShape.rectangle,
          ),
          child: Text(content,
              style: HRMTextStyles.h4Text.copyWith(fontWeight: FontWeight.w100),
            textAlign: TextAlign.right,
          ),
      ),
      Positioned(
        left: 50,
        top: 12,
        child: Container(
          padding: EdgeInsets.only( left: 10, right: 10),
          color: Colors.grey.shade100,
          child: Text(
            field,
            style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold, fontFamily: "Kanit",),
          ),
        ),
      ),
    ],
  );
}
