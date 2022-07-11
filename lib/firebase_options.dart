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
    apiKey: 'AIzaSyBQ92e48bT2B44Zd4YdGo9qzvU6ShldB48',
    appId: '1:674799005060:web:0e57c9e459074fb473c1d1',
    messagingSenderId: '674799005060',
    projectId: 'presenceapp-be1cb',
    authDomain: 'presenceapp-be1cb.firebaseapp.com',
    storageBucket: 'presenceapp-be1cb.appspot.com',
    measurementId: 'G-KXWE70NT2Y',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCan-tJCOIHh7cZxibaXd669gNwOlaJsB8',
    appId: '1:674799005060:android:bad4d12ad69670b473c1d1',
    messagingSenderId: '674799005060',
    projectId: 'presenceapp-be1cb',
    storageBucket: 'presenceapp-be1cb.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAQIqwP1U1ycEuj9i-pnGeRuxp46cMc1DY',
    appId: '1:674799005060:ios:99fab5f5936d27ab73c1d1',
    messagingSenderId: '674799005060',
    projectId: 'presenceapp-be1cb',
    storageBucket: 'presenceapp-be1cb.appspot.com',
    iosClientId: '674799005060-2d7vah14ig79tt34och83ditm94l3sg3.apps.googleusercontent.com',
    iosBundleId: 'com.presenceApp.presence',
  );
}