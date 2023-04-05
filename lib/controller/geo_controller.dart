import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:hrm_1c/controller/user_controller.dart';
import 'package:hrm_1c/models/configuration.dart';

import '../services/api/api_handler.dart';

class GeoController extends GetxController {
  // ignore: cast_from_null_always_fails
  Rx<Position?> currentLocation = Rx<Position?>(null);
  // final checkInLocation = const Position(
  //     altitude: 0.0,
  //     longitude: 106.680834,
  //     accuracy: 0.0,
  //     heading: 0.0,
  //     latitude: 10.7818393,
  //     speed: 0.0,
  //     speedAccuracy: 0.0,
  //     timestamp: null);

  double checkInRadius = 0.0;
  double longitude = 0.0;
  double latitude = 0.0;

  late StreamSubscription<Position> _locationStream;
  @override
  Future<void> onInit() async {
    initController()
        .then((value) => print("Init geo controller " + value.toString()));
    super.onInit();
  }

  @override
  void onClose() {
    _locationStream.cancel();
    currentLocation.value = null;
    super.onClose();
  }

  Future<bool> initController() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception("Location services are disabled.");
    }
    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
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

  Future<void> GetCheckInLocation() async {
    final userController = Get.find<UserController>();
    String username =  userController.username;
    String password = userController.password;
    var respond = await ApiHandler.getRequest(username, password,
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
}
