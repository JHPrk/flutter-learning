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
    apiKey: 'AIzaSyB-yt-B8twLsDt5aUeeWRG1CqtYzBDLscU',
    appId: '1:895494186706:web:5b21ce9fc2fd77b0baaf0b',
    messagingSenderId: '895494186706',
    projectId: 'myauthproviderproject',
    authDomain: 'myauthproviderproject.firebaseapp.com',
    storageBucket: 'myauthproviderproject.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCdr56IopgifEdiAKPaDi2OZpbymXQa7t4',
    appId: '1:895494186706:android:e1e079988d30e9c3baaf0b',
    messagingSenderId: '895494186706',
    projectId: 'myauthproviderproject',
    storageBucket: 'myauthproviderproject.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB7ICUkHzJ0u43W3isSQtpJ1S2CaW3jKwk',
    appId: '1:895494186706:ios:2ee1b009256a29efbaaf0b',
    messagingSenderId: '895494186706',
    projectId: 'myauthproviderproject',
    storageBucket: 'myauthproviderproject.firebasestorage.app',
    iosBundleId: 'com.example.fbAuthProvider',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB7ICUkHzJ0u43W3isSQtpJ1S2CaW3jKwk',
    appId: '1:895494186706:ios:2ee1b009256a29efbaaf0b',
    messagingSenderId: '895494186706',
    projectId: 'myauthproviderproject',
    storageBucket: 'myauthproviderproject.firebasestorage.app',
    iosBundleId: 'com.example.fbAuthProvider',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyB-yt-B8twLsDt5aUeeWRG1CqtYzBDLscU',
    appId: '1:895494186706:web:ce66f3dc730cb282baaf0b',
    messagingSenderId: '895494186706',
    projectId: 'myauthproviderproject',
    authDomain: 'myauthproviderproject.firebaseapp.com',
    storageBucket: 'myauthproviderproject.firebasestorage.app',
  );
}
