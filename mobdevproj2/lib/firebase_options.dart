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
    apiKey: 'AIzaSyBhgLEBl3MI5KAdyUD4zP18BWtB0Z-AUeY',
    appId: '1:817748902704:web:5dd182cf4f8e474a8dfef5',
    messagingSenderId: '817748902704',
    projectId: 'expresseats-12d21',
    authDomain: 'expresseats-12d21.firebaseapp.com',
    storageBucket: 'expresseats-12d21.appspot.com',
    measurementId: 'G-D2LFT0H02L',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCnM0fOG28r-ky_wFpKqnrKLcrEEnDvFIs',
    appId: '1:817748902704:android:9aae316c4389e70b8dfef5',
    messagingSenderId: '817748902704',
    projectId: 'expresseats-12d21',
    storageBucket: 'expresseats-12d21.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBnh1IP0c0AYJzobI_XqKe9Z2efaXTgGm4',
    appId: '1:817748902704:ios:502d697430c7b1ef8dfef5',
    messagingSenderId: '817748902704',
    projectId: 'expresseats-12d21',
    storageBucket: 'expresseats-12d21.appspot.com',
    iosBundleId: 'com.example.mobdevproj2',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBnh1IP0c0AYJzobI_XqKe9Z2efaXTgGm4',
    appId: '1:817748902704:ios:9a699e177d9d63158dfef5',
    messagingSenderId: '817748902704',
    projectId: 'expresseats-12d21',
    storageBucket: 'expresseats-12d21.appspot.com',
    iosBundleId: 'com.example.mobdevproj2.RunnerTests',
  );
}
