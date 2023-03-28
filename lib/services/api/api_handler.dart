import 'dart:convert';

import 'package:dio/dio.dart';

import '../../models/account.dart';

class ApiHandler {
  static const String baseURL = "http://103.157.218.115/HRM/hs/HRM";
  static late Dio _handler;

  static void initHandler() {
    _handler = Dio(
      BaseOptions(
        validateStatus: (status) => (status ?? 400) < 500,
      ),
    );
  }

  static Future<Response> getRequest(String username, String password ,String path,
      {Map<String, dynamic>? params}) async {
    return await _handler.get(
      baseURL + path,
      queryParameters: params,
      options: Options(headers: <String, String>{'authorization': 'Basic '+base64Encode(utf8.encode(username!+':'+password!))}),
    );
  }

  static Future<Response> postRequest(String username, String password ,
    String path, {
    Map<String, dynamic>? params,
    Map<String, dynamic>? body,
  }) async {
    return await _handler.post(
      baseURL + path,
      data: jsonEncode(body),
      queryParameters: params,
      options: Options(headers: <String, String>{'authorization': 'Basic '+base64Encode(utf8.encode(username!+':'+password!))}),

    );
  }
}
