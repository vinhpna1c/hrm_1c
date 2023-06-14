import 'package:hrm_1c/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/personal_information.dart';
import '../../utils/styles.dart';
import '../../utils/utils.dart';
import '../account/account_screen.dart';
import 'package:get/get.dart';

class NewEmployeeScreen extends StatelessWidget {
  final PersonalInformation employee;

  const NewEmployeeScreen({required this.employee, super.key});

  @override
  Widget build(BuildContext context) {
    final userController = Get.find<UserController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("1C:HRM"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Get.back(),
        ),
        centerTitle: true,
        backgroundColor: HRMColorStyles.darkBlueColor,
      ),
      body: CustomScrollView(slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 18.0, vertical: 18.0),
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
                        height: 200.0,
                        width: 140.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(6.0),
                      child: Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              employee.description!,
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontFamily: "Kanit",
                              ),
                            ),
                            Text(
                              employee.position ?? "",
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                                fontFamily: "Kanit",
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8, bottom: 6),
                              child: Text(
                                "Annual Leave",
                                style: TextStyle(
                                    color: HRMColorStyles.darkBlueColor),
                              ),
                            ),
                            (employee.contractType == "Full time")
                                ? Text(
                                    "${formatDouble(12 - (employee.paidDay! ?? 0.0))} / 12",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )
                                : Text(
                                    "0.0 / 0.0",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8, bottom: 6),
                              child: Text(
                                "Unpaid Leave",
                                style: TextStyle(
                                    color: HRMColorStyles.darkBlueColor),
                              ),
                            ),
                            Text(
                              "${formatDouble(employee.unpaidDay! ?? 0.0)}",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8, bottom: 6),
                              child: Text(
                                "Sick Leave",
                                style: TextStyle(
                                    color: HRMColorStyles.darkBlueColor),
                              ),
                            ),
                            Text(
                              "${formatDouble(30 - employee.sickLeave! ?? 0.0)} / 30",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
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
                        fieldName: "Gender", content: employee.gender ?? ""),
                    RowInformation(
                        fieldName: "Date of birth",
                        content: DateFormat("dd-MM-yyyy")
                            .format(employee.dateOfBirth ?? DateTime.now())),
                    RowInformation(
                        fieldName: "Email", content: employee.email ?? ""),
                    RowInformation(
                        fieldName: "Phone",
                        content: employee!.numberPhone ?? ""),
                    RowInformation(
                        fieldName: "Address", content: employee!.address ?? ""),
                    RowInformation(
                        fieldName: "Nationality",
                        content: employee!.nationality ?? ""),
                    // RowInformation(
                    //     fieldName: "Marital Status",
                    //     content: employee!.maritalStatus ?? ""),
                  ],
                )
              ],
            ),
          ),
        )
      ]),
    );
  }
}

Widget textInformation({String field = "", String content = ""}) {
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
        margin: const EdgeInsets.fromLTRB(20, 20, 20, 10),
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFF194B5A), width: 1),
          borderRadius: BorderRadius.circular(5),
          shape: BoxShape.rectangle,
        ),
        child: Text(
          content,
          style: HRMTextStyles.h4Text.copyWith(fontWeight: FontWeight.w100),
          textAlign: TextAlign.right,
        ),
      ),
      Positioned(
        left: 50,
        top: 12,
        child: Container(
          padding: const EdgeInsets.only(left: 10, right: 10),
          color: Colors.grey.shade100,
          child: Text(
            field,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 12,
              fontWeight: FontWeight.bold,
              fontFamily: "Kanit",
            ),
          ),
        ),
      ),
    ],
  );
}
