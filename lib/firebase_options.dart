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
        return windows;
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
    apiKey: 'AIzaSyC8m0VVHoozVaX4YKBtT1W1r2hBl5xp5t0',
    appId: '1:893282524370:web:4a1b2c3d4e5f6g7h8i9j',
    messagingSenderId: '893282524370',
    projectId: 'my-app-project-fac51',
    authDomain: 'my-app-project-fac51.firebaseapp.com',
    storageBucket: 'my-app-project-fac51.appspot.com',
    measurementId: 'G-ABC123DEF',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC8m0VVHoozVaX4YKBtT1W1r2hBl5xp5t0',
    appId: '1:893282524370:android:a1b2c3d4e5f6g7h8i9j',
    messagingSenderId: '893282524370',
    projectId: 'my-app-project-fac51',
    storageBucket: 'my-app-project-fac51.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC8m0VVHoozVaX4YKBtT1W1r2hBl5xp5t0',
    appId: '1:893282524370:ios:a1b2c3d4e5f6g7h8i9j',
    messagingSenderId: '893282524370',
    projectId: 'my-app-project-fac51',
    storageBucket: 'my-app-project-fac51.appspot.com',
    iosBundleId: 'com.example.myApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC8m0VVHoozVaX4YKBtT1W1r2hBl5xp5t0',
    appId: '1:893282524370:macos:a1b2c3d4e5f6g7h8i9j',
    messagingSenderId: '893282524370',
    projectId: 'my-app-project-fac51',
    storageBucket: 'my-app-project-fac51.appspot.com',
    iosBundleId: 'com.example.myApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyC8m0VVHoozVaX4YKBtT1W1r2hBl5xp5t0',
    appId: '1:893282524370:windows:a1b2c3d4e5f6g7h8i9j',
    messagingSenderId: '893282524370',
    projectId: 'my-app-project-fac51',
    storageBucket: 'my-app-project-fac51.appspot.com',
    measurementId: 'G-ABC123DEF',
  );
}
