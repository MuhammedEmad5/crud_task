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
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyBXtR6ibXrRGK7XQYKx_7BkzpY-RXJ3hWc',
    appId: '1:840976333310:web:148a278aae9acce114e8af',
    messagingSenderId: '840976333310',
    projectId: 'crud-task-358f3',
    authDomain: 'crud-task-358f3.firebaseapp.com',
    storageBucket: 'crud-task-358f3.appspot.com',
    measurementId: 'G-TB93MJKRNE',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD_2oKzgN7wMy9keQF09ab-TqDqjp4sIYo',
    appId: '1:840976333310:android:7435d44b0fb09c5514e8af',
    messagingSenderId: '840976333310',
    projectId: 'crud-task-358f3',
    storageBucket: 'crud-task-358f3.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB5Z_lNzRRxNfJH0gsWYtnPePHoBUVJ6T4',
    appId: '1:840976333310:ios:d0612ca61b7eeb5014e8af',
    messagingSenderId: '840976333310',
    projectId: 'crud-task-358f3',
    storageBucket: 'crud-task-358f3.appspot.com',
    iosBundleId: 'com.example.crudTask',
  );
}
