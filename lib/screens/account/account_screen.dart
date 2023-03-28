import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_1c/components/employee_avatar.dart';
import 'package:hrm_1c/components/leave_widget.dart';
import 'package:hrm_1c/controller/user_controller.dart';
import 'package:hrm_1c/screens/single_body_screen.dart';
import 'package:hrm_1c/utils/styles.dart';
import 'package:hrm_1c/utils/utils.dart';
import 'package:intl/intl.dart';

class AccountScreen extends StatelessWidget {
  final isShowAppBar;
  const AccountScreen({this.isShowAppBar = true, super.key});

  final _BUTTON_SPACE = 10;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double leaveBtnWidth = (width - _BUTTON_SPACE * 2 - 16 * 2) / 3;
    final userController = Get.find<UserController>();
    var personalInformation = userController.userInformation;
    return SingleBodyScreen(
      showAppBar: isShowAppBar,
      body: Container(
        color: HRMColorStyles.greyBackgroundColor,
        child: ListView(
          children: [
            ClipPath(
              clipper: const ArcClipper(arcHeight: 50.0),
              child: Container(
                height: 250,
                color: HRMColorStyles.blueShade500Color,
                alignment: Alignment.center,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    EmployeeAvatar(
                      backgroundRadius: 70,
                      paddingSpace: 8.0,
                      imageURL: personalInformation!.URL,
                    ),
                    Text(
                      personalInformation.description!,
                      style: HRMTextStyles.boldText.copyWith(fontSize: 20),
                    ),
                    Text(
                      personalInformation.position!,
                      style: HRMTextStyles.normalText.copyWith(fontSize: 20),
                    )
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        LeaveWidget(
                          width: leaveBtnWidth,
                          icon: Icon(
                            Icons.cases_rounded,
                            color: HRMColorStyles.darkBlueColor,
                          ),
                          content:
                              "${formatDouble(userController.userInformation!.paidDay ?? 0.0)}/7",
                          leaveType: "Annual leave",
                        ),
                        LeaveWidget(
                          width: leaveBtnWidth,
                          icon: Icon(
                            Icons.sick,
                            color: HRMColorStyles.darkBlueColor,
                          ),
                          content:
                              "${formatDouble(userController.userInformation!.sickLeave ?? 0.0)}/30",
                          leaveType: "Sick leave",
                        ),
                        LeaveWidget(
                          width: leaveBtnWidth,
                          icon: Icon(
                            Icons.cloud,
                            color: HRMColorStyles.darkBlueColor,
                          ),
                          content: formatDouble(
                              userController.userInformation!.unpaidDay ?? 0.0),
                          leaveType: "Unpaid leave",
                        ),
                      ],
                    ),
                  ),
                  RowInformation(
                      fieldName: "Username", content: userController.username),
                  RowInformation(
                      fieldName: "Gender",
                      content: personalInformation.gender!),
                  RowInformation(
                      fieldName: "Positon", content: personalInformation.position!),
                  RowInformation(
                      fieldName: "Email", content: personalInformation.email!),
                  RowInformation(
                      fieldName: "Phone",
                      content: personalInformation!.numberPhone ?? ""),
                  RowInformation(
                      fieldName: "Date of birth",
                      content: DateFormat("dd-MM-yyyy").format(
                          personalInformation.dateOfBirth ?? DateTime.now())),
                  RowInformation(
                      fieldName: "Working year", content: "0.4 year"),
                  RowInformation(
                      fieldName: "Status",
                      content: personalInformation.status!),
                  RowInformation(fieldName: "Contact", content: personalInformation.contractType!),
                  RowInformation(fieldName: "Salary", content: "************"),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget RowInformation({String fieldName = "", String content = ""}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      margin: const EdgeInsets.only(bottom: 4.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(fieldName, style: HRMTextStyles.h4Text),
        Text(content,
            style: HRMTextStyles.h4Text.copyWith(fontWeight: FontWeight.w100)),
      ]),
    );
  }
}

class ArcClipper extends CustomClipper<Path> {
  final double arcHeight;
  const ArcClipper({this.arcHeight = 0});
  @override
  Path getClip(Size size) {
    double height = size.height;
    double width = size.width;
    var path = Path();
    path.lineTo(0, height - arcHeight);

    path.quadraticBezierTo(
        width * 0.5, height + arcHeight, width, height - arcHeight);
    path.lineTo(width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
