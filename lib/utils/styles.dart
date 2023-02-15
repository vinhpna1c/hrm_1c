import 'package:flutter/material.dart';

class HRMColorStyles {
  static Color blueColor = const Color(0xFF3498DB);
  static Color lightBlueColor = const Color(0xFF1EA3CB);
  static Color darkBlueColor = const Color(0xFF0B5D76);
  static Color selectedBlueColor = const Color(0xFF154A5A);
  static Color unselectedBlueColor = const Color(0xFF127999);
  static Color blueShade500Color = const Color(0xFF127999);
  static Color greyColor = const Color(0xFF8D8A8A);
  static Color greyBackgroundColor = const Color(0xFFE5E5E5);
}

class HRMTextStyles {
  static const btnText = TextStyle(
    color: Colors.white,
    fontFamily: "Open Sans",
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w700,
    fontSize: 24,
  );
  static const normalText = TextStyle(
    color: Colors.white,
    fontFamily: "Kanit",
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w400,
    fontSize: 16,
  );
  static const boldText = TextStyle(
    color: Colors.white,
    fontFamily: "Kanit",
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w700,
    fontSize: 16,
  );
  static TextStyle h4Text =
      boldText.copyWith(color: Colors.black, fontSize: 14);
  static TextStyle h5Text =
      boldText.copyWith(color: Colors.black, fontSize: 12);
  static TextStyle h3Text = boldText.copyWith(fontSize: 20);
}
