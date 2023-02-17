import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:hrm_1c/controller/geo_controller.dart';
import 'package:hrm_1c/screens/auth/login_screen.dart';
import 'package:hrm_1c/services/api/api_service.dart';
import 'package:hrm_1c/services/firebase/firebase_service.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initBeforeRun();
  runApp(const MyApp());
}

Future initBeforeRun() async {
  await ApiHandler.init();
  await FirebaseService.initFireBase();
  try {
    var location = await GeoController.initController();
    print(Geolocator.distanceBetween(
        location.latitude, location.longitude, 10.7817856, 106.6835476));
    print(location);
  } catch (e) {
    print(e);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: "Open Sans",
      ),
      debugShowCheckedModeBanner: false,
      home: const LoginScreen(),
    );
  }
}
