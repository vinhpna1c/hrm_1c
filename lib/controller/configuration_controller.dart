// ignore_for_file: prefer_const_declarations, non_constant_identifier_names

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class ConfigurationController extends GetxController {
  //config for email service

  static final EMAIL_SERVICE_ID = "service_hrm_send_email";
  static final EMAIL_TEMPLATE_ID = "template_kqq9iti";
  static final EMAIL_USER_ID = "5cEgzwv63tQBPylAw";

  late Rx<Position> checkInPosition;

  @override
  void onInit() {
    print("Init configuration Controller");
    // ignore: prefer_const_constructors
    checkInPosition = Position(
            longitude: 0,
            latitude: 0,
            timestamp: DateTime.now(),
            accuracy: 0,
            altitude: 0,
            heading: 0,
            speed: 0,
            speedAccuracy: 0)
        .obs;
    super.onInit();
  }

  bool handlePostionFromUrl(String url) {
    List<String> elements = url.split("/");
    for (String e in elements) {
      //find String startWith @
      if (e.startsWith("@")) {
        //remove @ character
        e = e.substring(1);
        double longtitude = 0.0;
        double latitude = 0.0;
        List<String> coordinates = e.split(",");
        //hanle coordinate in String
        if (double.tryParse(coordinates[0]) != null) {
          longtitude = double.tryParse(coordinates[0])!;
        } else {
          return false;
        }
        if (double.tryParse(coordinates[1]) != null) {
          latitude = double.tryParse(coordinates[1])!;
        } else {
          return false;
        }
        print("New long: " + longtitude.toString());
        print("New lat: " + latitude.toString());
        //update in Position
        checkInPosition.value = Position(
            longitude: longtitude,
            latitude: latitude,
            timestamp: DateTime.now(),
            accuracy: 0,
            altitude: 0,
            heading: 0,
            speed: 0,
            speedAccuracy: 0);

        return true;
      }
    }

    return false;
  }
}
