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
    apiKey: 'AIzaSyAh7Z4aAh2Yuez3gHr8-UKhf3oxhXbKtEQ',
    appId: '1:373164720901:web:82e61e488b07a1371f2d6c',
    messagingSenderId: '373164720901',
    projectId: 'my-apps-a6f9d',
    authDomain: 'my-apps-a6f9d.firebaseapp.com',
    storageBucket: 'my-apps-a6f9d.appspot.com',
    measurementId: 'G-TPP2ZD2EZH',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyASSO67JcHhNq778UyZ_EtaI38uulxK0ns',
    appId: '1:373164720901:android:edd8b9150129be491f2d6c',
    messagingSenderId: '373164720901',
    projectId: 'my-apps-a6f9d',
    storageBucket: 'my-apps-a6f9d.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCsgn6agj19RMl92bFQdCZR0EAiPz3MRa4',
    appId: '1:373164720901:ios:43a5238420102dcf1f2d6c',
    messagingSenderId: '373164720901',
    projectId: 'my-apps-a6f9d',
    storageBucket: 'my-apps-a6f9d.appspot.com',
    iosBundleId: 'com.example.myApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCsgn6agj19RMl92bFQdCZR0EAiPz3MRa4',
    appId: '1:373164720901:ios:43a5238420102dcf1f2d6c',
    messagingSenderId: '373164720901',
    projectId: 'my-apps-a6f9d',
    storageBucket: 'my-apps-a6f9d.appspot.com',
    iosBundleId: 'com.example.myApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAh7Z4aAh2Yuez3gHr8-UKhf3oxhXbKtEQ',
    appId: '1:373164720901:web:aa245737183700381f2d6c',
    messagingSenderId: '373164720901',
    projectId: 'my-apps-a6f9d',
    authDomain: 'my-apps-a6f9d.firebaseapp.com',
    storageBucket: 'my-apps-a6f9d.appspot.com',
    measurementId: 'G-0H5LPTREGY',
  );
}
