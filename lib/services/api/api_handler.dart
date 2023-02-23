import 'dart:convert';

import 'package:dio/dio.dart';

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

  static Future<Response> getRequest(String path,
      {Map<String, dynamic>? params}) async {
    return await _handler.get(
      baseURL + path,
      queryParameters: params,
    );
  }

  static Future<Response> postRequest(
    String path, {
    Map<String, dynamic>? params,
    Map<String, dynamic>? body,
  }) async {
    return await _handler.post(
      baseURL + path,
      data: jsonEncode(body),
      queryParameters: params,
    );
  }
}
