//this main is using for test function
import 'dart:convert';

import 'package:mongo_dart/mongo_dart.dart';

void main(List<String> args) async {
  print(num.tryParse("0.0").toString());
  print(num.tryParse("0.5").toString());
  // print(await db.serverStatus());
  // if (db.isConnected) {
  //   db.close();
  // }
  // db.databaseName ?? "";
}
