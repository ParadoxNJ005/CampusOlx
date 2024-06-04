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
    apiKey: 'AIzaSyAiV5lZ8Cum6yuqu8mjhi11rGy1lNWVV40',
    appId: '1:732101733877:web:1f2dc84ee8526f245644bc',
    messagingSenderId: '732101733877',
    projectId: 'campusolx-69162',
    authDomain: 'campusolx-69162.firebaseapp.com',
    storageBucket: 'campusolx-69162.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCtdVIZ0K6mP3WiDnJm337KDiwaIY3WHI4',
    appId: '1:732101733877:android:3a2fcafcb0dda7395644bc',
    messagingSenderId: '732101733877',
    projectId: 'campusolx-69162',
    storageBucket: 'campusolx-69162.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDebc9HUc33J2glF2cgrL4ERtPVY1T5QMg',
    appId: '1:732101733877:ios:90e01a95ef3a39685644bc',
    messagingSenderId: '732101733877',
    projectId: 'campusolx-69162',
    storageBucket: 'campusolx-69162.appspot.com',
    iosBundleId: 'com.example.campusOlx',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDebc9HUc33J2glF2cgrL4ERtPVY1T5QMg',
    appId: '1:732101733877:ios:90e01a95ef3a39685644bc',
    messagingSenderId: '732101733877',
    projectId: 'campusolx-69162',
    storageBucket: 'campusolx-69162.appspot.com',
    iosBundleId: 'com.example.campusOlx',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAiV5lZ8Cum6yuqu8mjhi11rGy1lNWVV40',
    appId: '1:732101733877:web:a1d99ded92f627a35644bc',
    messagingSenderId: '732101733877',
    projectId: 'campusolx-69162',
    authDomain: 'campusolx-69162.firebaseapp.com',
    storageBucket: 'campusolx-69162.appspot.com',
  );
}
