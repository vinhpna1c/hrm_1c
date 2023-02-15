import 'package:flutter/material.dart';
import 'package:hrm_1c/components/employee_avatar.dart';
import 'package:hrm_1c/components/leave_widget.dart';
import 'package:hrm_1c/utils/styles.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  final _BUTTON_SPACE = 10;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double leaveBtnWidth = (width - _BUTTON_SPACE * 2 - 16 * 2) / 3;
    return Container(
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
                  ),
                  Text(
                    "Firstname Lastname",
                    style: HRMTextStyles.boldText.copyWith(fontSize: 20),
                  ),
                  Text(
                    "Job title",
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
                        content: "1/7",
                        leaveType: "Annual leave",
                      ),
                      LeaveWidget(
                        width: leaveBtnWidth,
                        icon: Icon(
                          Icons.sick,
                          color: HRMColorStyles.darkBlueColor,
                        ),
                        content: "2/30",
                        leaveType: "Sick leave",
                      ),
                      LeaveWidget(
                        width: leaveBtnWidth,
                        icon: Icon(
                          Icons.cloud,
                          color: HRMColorStyles.darkBlueColor,
                        ),
                        content: "0",
                        leaveType: "Unpaid leave",
                      ),
                    ],
                  ),
                ),
                RowInformation(fieldName: "Username", content: "manager"),
                RowInformation(fieldName: "Positon", content: "IT Specialist"),
                RowInformation(
                    fieldName: "Email", content: "manager@1cinnovation.com"),
                RowInformation(fieldName: "Phone", content: "(+84) 9 1123456"),
                RowInformation(fieldName: "Date start", content: "19-09-2022"),
                RowInformation(fieldName: "Working year", content: "0.4 year"),
                RowInformation(fieldName: "Status", content: "Working"),
                RowInformation(fieldName: "Contact", content: "Full-time"),
                RowInformation(fieldName: "Salary", content: "************"),
              ],
            ),
          )
        ],
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
