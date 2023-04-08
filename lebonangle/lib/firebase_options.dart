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
    apiKey: 'AIzaSyBkuNKdFHHbfAWx4G6KeY2IdSgr-1Bg-h0',
    appId: '1:863372390731:web:4d33b467847ec76ddf78ce',
    messagingSenderId: '863372390731',
    projectId: 'lebonangle-de73a',
    authDomain: 'lebonangle-de73a.firebaseapp.com',
    storageBucket: 'lebonangle-de73a.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCGV9acewqp_KiUOzN8e_bO6DOsdjYE-G0',
    appId: '1:863372390731:android:2f6ab21d76de35d4df78ce',
    messagingSenderId: '863372390731',
    projectId: 'lebonangle-de73a',
    storageBucket: 'lebonangle-de73a.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD0KfsnLg1m9a5FcCrbsovSR3BYdDUW_6o',
    appId: '1:863372390731:ios:bb030bced1771e03df78ce',
    messagingSenderId: '863372390731',
    projectId: 'lebonangle-de73a',
    storageBucket: 'lebonangle-de73a.appspot.com',
    iosClientId: '863372390731-dcsfqkogrveleea0hj480m58kcf6m8en.apps.googleusercontent.com',
    iosBundleId: 'com.example.lebonangle',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD0KfsnLg1m9a5FcCrbsovSR3BYdDUW_6o',
    appId: '1:863372390731:ios:3543be5c3873b3cbdf78ce',
    messagingSenderId: '863372390731',
    projectId: 'lebonangle-de73a',
    storageBucket: 'lebonangle-de73a.appspot.com',
    iosClientId: '863372390731-r3o2r68cj5bfk66irvkqq4p5dng8tcp8.apps.googleusercontent.com',
    iosBundleId: 'com.example.lebonangle.RunnerTests',
  );
}
