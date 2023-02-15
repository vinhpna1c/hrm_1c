import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hrm_1c/firebase_options.dart';

class FirebaseService {
  static late final FirebaseApp _app;
  static late FirebaseFirestore _db;

  static Future<void> initFireBase() async {
    _app = await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    _db = FirebaseFirestore.instance;
  }

  static Future<Map<String, dynamic>> findOne(
      String collectionName, Map<String, dynamic> conditions) async {
    var coll = _db.collection(collectionName);

    Query? query;
    for (var field in conditions.keys.toList()) {
      if (query == null) {
        query = coll.where(field, isEqualTo: conditions[field]);
      } else {
        query = query.where(field, isEqualTo: conditions[field]);
      }
    }

    if (query != null) {
      var result = await query.get();

      if (result.docs.isNotEmpty) {
        return result.docs[0].data() as Map<String, dynamic>;
      }
    }

    return {};
  }

  static Future<String> addNewDocument(
      String collectionName, Map<String, dynamic> data) async {
    var res = await _db.collection(collectionName).add(data);
    return res.id;
  }
}
