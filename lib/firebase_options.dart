// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBPPV7rLgdUqaBjKLc_dTRsBDkkivMDRsU',
    appId: '1:11646021944:web:5c62073fb323953b1c11cd',
    messagingSenderId: '11646021944',
    projectId: 'hrm1c-792a8',
    authDomain: 'hrm1c-792a8.firebaseapp.com',
    storageBucket: 'hrm1c-792a8.appspot.com',
    measurementId: 'G-LLQGVR05GS',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCaNjbDd9CXCEMPkQiGY5-amcFqsQ7uoMw',
    appId: '1:11646021944:android:a15cd77c16be16fa1c11cd',
    messagingSenderId: '11646021944',
    projectId: 'hrm1c-792a8',
    storageBucket: 'hrm1c-792a8.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB30N8pmycr2SfmppFiPvnUEOV8vDBQPDs',
    appId: '1:11646021944:ios:9f239980dacfb0e81c11cd',
    messagingSenderId: '11646021944',
    projectId: 'hrm1c-792a8',
    storageBucket: 'hrm1c-792a8.appspot.com',
    iosClientId: '11646021944-nv8899a2nde67dul9pd2ph8eftpti42a.apps.googleusercontent.com',
    iosBundleId: 'com.example.hrm1c',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB30N8pmycr2SfmppFiPvnUEOV8vDBQPDs',
    appId: '1:11646021944:ios:9f239980dacfb0e81c11cd',
    messagingSenderId: '11646021944',
    projectId: 'hrm1c-792a8',
    storageBucket: 'hrm1c-792a8.appspot.com',
    iosClientId: '11646021944-nv8899a2nde67dul9pd2ph8eftpti42a.apps.googleusercontent.com',
    iosBundleId: 'com.example.hrm1c',
  );
}