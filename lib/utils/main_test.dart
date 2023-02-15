//this main is using for test function
import 'dart:convert';

import 'package:mongo_dart/mongo_dart.dart';

void main(List<String> args) async {
  var db = await Db.create(
      "mongodb+srv://admin:admin@hrm.gvfmhwo.mongodb.net/HRM?retryWrites=true&w=majority");
  await db.open();
  final account = db.collection("account");
  print(await account.find().toList());
  final accColl = db.collection("account");
  print(jsonEncode(await accColl.findOne(
    where.eq("username", "manager").and(
          where.eq("password", "123456"),
        ),
  )));
  // print(await db.serverStatus());
  // if (db.isConnected) {
  //   db.close();
  // }
  // db.databaseName ?? "";
}
