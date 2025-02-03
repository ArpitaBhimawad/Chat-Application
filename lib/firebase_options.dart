// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
    // if (kIsWeb) {
    //   return web;
    // }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      // case TargetPlatform.iOS:
      //   return ios;
      // case TargetPlatform.macOS:
      //   return macos;
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
    apiKey: 'AIzaSyA7zeNY6Fz8186UEClbyrc9V0wJPLwp89Q',
    appId: '1:82373025622:android:1b4a61fe58ae5232fd40f7',
    messagingSenderId: '82373025622',
    projectId: 'battmobile-app',
    storageBucket: 'battmobile-app.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBzIYOka6mEtf_44T1g5zhMeNysdIcMbMs',
    appId: '1:395942901634:android:87c061b44b43e8bc8a019b',
    messagingSenderId: '395942901634',
    projectId: 'chatproject-fa1a1',
    // databaseURL: 'https://harvest3-7bgh5h-default-rtdb.firebaseio.com',
    storageBucket: 'chatproject-fa1a1.firebasestorage.app',
  );

  // static const FirebaseOptions ios = FirebaseOptions(
  //   apiKey: 'AIzaSyCUnJ-jSVDuFJiWGgbOCEXWhgE2fwn36NY',
  //   appId: '1:370280334547:ios:1c9843f76695d29faa0026',
  //   messagingSenderId: '370280334547',
  //   projectId: 'harvest3-7bgh5h',
  //   databaseURL: 'https://harvest3-7bgh5h-default-rtdb.firebaseio.com',
  //   storageBucket: 'harvest3-7bgh5h.appspot.com',
  //   iosBundleId: 'com.mycompany.harvest3',
  // );

  // static const FirebaseOptions macos = FirebaseOptions(
  //   apiKey: 'AIzaSyCUnJ-jSVDuFJiWGgbOCEXWhgE2fwn36NY',
  //   appId: '1:370280334547:ios:b821b12e0b2c5c34aa0026',
  //   messagingSenderId: '370280334547',
  //   projectId: 'harvest3-7bgh5h',
  //   databaseURL: 'https://harvest3-7bgh5h-default-rtdb.firebaseio.com',
  //   storageBucket: 'harvest3-7bgh5h.appspot.com',
  //   iosBundleId: 'com.example.fieldMarketingApp',
  // );
}
