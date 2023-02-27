//this main is using for test function
import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:mongo_dart/mongo_dart.dart';

void main(List<String> args) async {
  var d = DateFormat("M/dd/y hh:mm:ss a").parse("5/31/2001 12:00:00 AM");
  print(d.day);
  print(d.month);
  // print(await db.serverStatus());
  // if (db.isConnected) {
  //   db.close();
  // }
  // db.databaseName ?? "";
}
