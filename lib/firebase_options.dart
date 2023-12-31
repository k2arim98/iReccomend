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
    apiKey: 'AIzaSyAF9DSuFBxmtP4JRUHfaH7sQMtbIAsLOz8',
    appId: '1:246377220737:web:d1415ef7e742f343f89b80',
    messagingSenderId: '246377220737',
    projectId: 'irecomend',
    authDomain: 'irecomend.firebaseapp.com',
    storageBucket: 'irecomend.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDcZoPsn_widv0DPm-RoFxq-wFmyUYJHo4',
    appId: '1:246377220737:android:afaba64fc7e0d241f89b80',
    messagingSenderId: '246377220737',
    projectId: 'irecomend',
    storageBucket: 'irecomend.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCFx7TcgEZsHmLIWsXH7OPpBo5raTU1lLY',
    appId: '1:246377220737:ios:24a14e468e5f9e1ff89b80',
    messagingSenderId: '246377220737',
    projectId: 'irecomend',
    storageBucket: 'irecomend.appspot.com',
    iosClientId: '246377220737-ous91lrajkl9tpno5s4l01ppdb13fjfq.apps.googleusercontent.com',
    iosBundleId: 'com.example.irecommend',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCFx7TcgEZsHmLIWsXH7OPpBo5raTU1lLY',
    appId: '1:246377220737:ios:24a14e468e5f9e1ff89b80',
    messagingSenderId: '246377220737',
    projectId: 'irecomend',
    storageBucket: 'irecomend.appspot.com',
    iosClientId: '246377220737-ous91lrajkl9tpno5s4l01ppdb13fjfq.apps.googleusercontent.com',
    iosBundleId: 'com.example.irecommend',
  );
}
