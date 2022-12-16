// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members

// Package imports:
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
    apiKey: 'AIzaSyB06QeH3g1MULv693yfMfTUSWvifU3fllc',
    appId: '1:153049248445:web:3081711229f8e2a1b3fdd4',
    messagingSenderId: '153049248445',
    projectId: 'book-a-rabbit',
    authDomain: 'book-a-rabbit.firebaseapp.com',
    storageBucket: 'book-a-rabbit.appspot.com',
    measurementId: 'G-8N24J2GTP2',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBcWncBcJOmQJ7DYiJCTZg8sjNRL4oPJ3E',
    appId: '1:153049248445:android:bfb2f7a472e4bdaeb3fdd4',
    messagingSenderId: '153049248445',
    projectId: 'book-a-rabbit',
    storageBucket: 'book-a-rabbit.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCAbEjuM5OSSFVExYQFwc4CqJiYWxKArxc',
    appId: '1:153049248445:ios:5cf127b6aa455433b3fdd4',
    messagingSenderId: '153049248445',
    projectId: 'book-a-rabbit',
    storageBucket: 'book-a-rabbit.appspot.com',
    iosClientId: '153049248445-3fhuu7jmni30h15la5b4picsf40pc9f5.apps.googleusercontent.com',
    iosBundleId: 'com.dchainconnect.bookrabbit',
  );
}
