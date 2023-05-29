import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hrm_1c/models/personal_information.dart';

import '../screens/employees/new_employee_screen.dart';
import '../utils/styles.dart';

class InformationCard extends StatelessWidget {
  final PersonalInformation employeeInformation;
  const InformationCard({
    required this.employeeInformation,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var imageURL = employeeInformation.URL;
    return GestureDetector(
      onTap: () {
        Get.to(NewEmployeeScreen(employee: employeeInformation,));
      },
      child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.only(bottom: 10.0, left: 5, right: 5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                blurRadius: 4.0,
                offset: Offset(0, 0),
              )
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Container(
                height: 100,
                width: 100,
                child: imageURL == null
                    ? Image.asset(
                        "assets/images/person_holder.png",
                        fit: BoxFit.contain,
                      )
                    : Image.network(
                        imageURL,
                        fit: BoxFit.contain,
                        errorBuilder: ((context, error, stackTrace) =>
                            Image.asset(
                              "assets/images/person_holder.png",
                              fit: BoxFit.contain,
                            )),
                      ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(employeeInformation.description ?? ""),
                  TextInformation(field: "Position: ", content: "IT Specialist"),
                  TextInformation(
                    field: "Old: ",
                    content: (DateTime.now()
                                .difference(employeeInformation.dateOfBirth ??
                                    DateTime.now())
                                .inDays /
                            365)
                        .floor()
                        .toString(),
                  ),
                  TextInformation(
                      field: "Email: ", content: employeeInformation.email ?? ""),
                  TextInformation(
                      field: "Phone: ",
                      content: employeeInformation.numberPhone ?? ""),
                  TextInformation(
                      field: "Status: ",
                      content: employeeInformation.status ?? ""),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget TextInformation({String field = "", String content = ""}) {
    return RichText(
      text: TextSpan(
          text: field,
          style: HRMTextStyles.lightText
              .copyWith(fontSize: 12, color: HRMColorStyles.darkGreyColor),
          children: [
            TextSpan(
              text: content,
              style: HRMTextStyles.lightText.copyWith(fontSize: 12),
            ),
          ]),
    );
  }
}
