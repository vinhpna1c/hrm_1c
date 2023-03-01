import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

DateTime? parseDateTimeFromStr(String dateStr,
    {String format = "M/dd/y hh:mm:ss a"}) {
  DateTime ret = DateTime.now();

  try {
    ret = DateFormat(format).parse(dateStr);
  } catch (e) {
    print("Cannot parse string!");
    return null;
  }
  return ret;
}

String formatDouble(double d) {
  double ret = d;
  double error = ret - ret.floor();
  print(error);
  if (error < 0.1) {
    return ret.toInt().toString();
  }
  return d.toStringAsFixed(1);
}
