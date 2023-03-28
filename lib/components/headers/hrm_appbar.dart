import 'package:flutter/material.dart';
import 'package:hrm_1c/utils/styles.dart';

AppBar HRMAppBar({String title = "1C:HRM"}) {
  return AppBar(
    title: Text(
      title,
      style: HRMTextStyles.h3Text.copyWith(
        fontWeight: FontWeight.w600,
      ),
    ),
    backgroundColor: HRMColorStyles.darkBlueColor,
    centerTitle: true,
  );
}
