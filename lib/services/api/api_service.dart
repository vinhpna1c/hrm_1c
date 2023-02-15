import 'package:dio/dio.dart';

class ApiHandler {
  String baseURL = "https://63e4939c4474903105ed8123.mockapi.io/v1/";
  static late final Dio _handler;

  static get handler => _handler;

  static Future<void> init() async {
    _handler = Dio();
  }
}
