import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:hrm_1c/controller/user_controller.dart';
import '../services/api/api_handler.dart';

class GeoController extends GetxController {
  // ignore: cast_from_null_always_fails
  Rx<Position?> currentLocation = Rx<Position?>(null);

  double checkInRadius = 0.0;
  double longitude = 0.0;
  double latitude = 0.0;

  late StreamSubscription<Position> _locationStream;

  @override
  void onClose() {
    _locationStream.cancel();
    currentLocation.value = null;
    super.onClose();
  }

  Future<bool> initLocationService() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      throw Exception("Location services are disabled.");
    }
    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      //show information about location permission
      await showLocationInformation();

      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    _locationStream = Geolocator.getPositionStream().listen((position) {
      currentLocation.value = position;
      print("New position: " + position.toString());
    }, onDone: () {
      print("Close position stream");
    });

    return true;
  }

  Future<void> getCheckInLocation() async {
    final userController = Get.find<UserController>();
    String username = userController.username;
    String password = userController.password;
    var respond = await ApiHandler.getRequest(
      username,
      password,
      "/V1/Configuration",
    );
    if (respond.statusCode == 200) {
      var data = respond.data["Configuration"] ?? [];
      for (var req in data) {
        checkInRadius = double.parse(req['CheckInRadius']);
        longitude = req['Longtitude'];
        latitude = req['Latitude'];
      }
    }
  }

  Future<void> showLocationInformation() async {
    await Get.dialog(
      AlertDialog(
        title: const Text("Location Permission request"),
        content: const Text(
            '''This app will use your location position for functionality.\nYour data will be keep secret and using internally.\nIf your decision is changed when using, please check app permission in settings on your device to change permission. Some functionality will be not usable based on your permission.'''),
        actions: [
          TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text("Ok, I understand!")),
        ],
      ),
      barrierDismissible: true,
    );
  }
}
