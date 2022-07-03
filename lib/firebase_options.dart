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
    apiKey: 'AIzaSyAnt7DYmDdhLfqjcPDSY_mTSz7847wBud4',
    appId: '1:750847474798:web:dd52c6f895f6982e027a7f',
    messagingSenderId: '750847474798',
    projectId: 'task-app-b1dc2',
    authDomain: 'task-app-b1dc2.firebaseapp.com',
    storageBucket: 'task-app-b1dc2.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBXVzMpRSMTX-6_OhzG-boJwMlhLPHC890',
    appId: '1:750847474798:android:e770ec7afdb35832027a7f',
    messagingSenderId: '750847474798',
    projectId: 'task-app-b1dc2',
    storageBucket: 'task-app-b1dc2.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDEY_NEmk82LGmOIWuSGXXsC6quMlhDdQg',
    appId: '1:750847474798:ios:b0a122f8bf2e48b7027a7f',
    messagingSenderId: '750847474798',
    projectId: 'task-app-b1dc2',
    storageBucket: 'task-app-b1dc2.appspot.com',
    iosClientId: '750847474798-t9kk11khaif8n1qbuhu91mctih649brr.apps.googleusercontent.com',
    iosBundleId: 'com.example.taskApp',
  );
}
