import 'package:mongo_dart/mongo_dart.dart';

class DBService {
  static late final Db _database;
  static Future<void> initDB() async {
    _database = Db("mongodb+srv://user:user@hrm.lmf1ugj.mongodb.net/HRM");
    await _database.open();
  }
}
