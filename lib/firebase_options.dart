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
    apiKey: 'AIzaSyBs0a7imn6G_pEsxkduMCiZlEsijk0t560',
    appId: '1:963790114670:web:4240bdf9e2b5580427bb7f',
    messagingSenderId: '963790114670',
    projectId: 'flower-app-67110',
    authDomain: 'flower-app-67110.firebaseapp.com',
    storageBucket: 'flower-app-67110.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCwERuPCgRRaLR_lyXGBKM8-psMI7EoixA',
    appId: '1:963790114670:android:c9b39ed2e70b564727bb7f',
    messagingSenderId: '963790114670',
    projectId: 'flower-app-67110',
    storageBucket: 'flower-app-67110.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyASYVS3obZ3PHdGm6E8XbDA4qPc_kIX0KU',
    appId: '1:963790114670:ios:9f9714017704063d27bb7f',
    messagingSenderId: '963790114670',
    projectId: 'flower-app-67110',
    storageBucket: 'flower-app-67110.appspot.com',
    iosBundleId: 'com.example.flowerApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyASYVS3obZ3PHdGm6E8XbDA4qPc_kIX0KU',
    appId: '1:963790114670:ios:cafbb32298f4dbd927bb7f',
    messagingSenderId: '963790114670',
    projectId: 'flower-app-67110',
    storageBucket: 'flower-app-67110.appspot.com',
    iosBundleId: 'com.example.flowerApp.RunnerTests',
  );
}
