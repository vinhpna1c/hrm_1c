import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hrm_1c/components/hrm_appbar.dart';
import 'package:hrm_1c/components/hrm_drawer.dart';
import 'package:hrm_1c/screens/single_body_screen.dart';
import 'package:hrm_1c/utils/styles.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleBodyScreen(
      body: Container(
        padding: const EdgeInsets.all(16.0),
        color: HRMColorStyles.blueShade800Color,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              PasswordTitle(title: "Old password"),
              PasswordTextField(hintText: "Input old password"),
              PasswordTitle(title: "New password"),
              PasswordTextField(hintText: "Input new password"),
              PasswordTitle(title: "Confirm password"),
              PasswordTextField(hintText: "Input confirm password"),
            ]),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(backgroundColor: Colors.white),
                    child: Text(
                      "Save & request",
                      style: HRMTextStyles.h3Text
                          .copyWith(color: HRMColorStyles.lightBlueColor),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  flex: 2,
                  child: TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                        backgroundColor: HRMColorStyles.lightBlueColor),
                    child: Text(
                      "Cancel",
                      style: HRMTextStyles.h3Text.copyWith(color: Colors.white),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

Widget PasswordTextField({String hintText = ""}) {
  return TextField(
    decoration: InputDecoration(
      border: OutlineInputBorder(),
      hintText: hintText,
      hintStyle:
          HRMTextStyles.lightText.copyWith(color: HRMColorStyles.greyHintColor),
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      fillColor: Colors.white,
      filled: true,
    ),
    obscureText: true,
  );
}

Widget PasswordTitle({String title = ""}) {
  return RichText(
    text: TextSpan(
      text: title,
      children: [
        TextSpan(
            text: " *",
            style: HRMTextStyles.lightText
                .copyWith(color: Colors.red, fontStyle: FontStyle.italic))
      ],
      style: HRMTextStyles.lightText.copyWith(color: Colors.white),
    ),
  );
}
