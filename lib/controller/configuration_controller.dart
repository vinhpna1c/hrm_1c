import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class ConfigurationController extends GetxController {
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
}
