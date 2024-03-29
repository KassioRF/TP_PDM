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
    apiKey: 'AIzaSyDE2MuzhL0KACwJ31Ttzscg-_xLzEIjtFI',
    appId: '1:1062263174096:web:2602d9c1bba2dd324dffd5',
    messagingSenderId: '1062263174096',
    projectId: 'gkfin-tp-pdm',
    authDomain: 'gkfin-tp-pdm.firebaseapp.com',
    storageBucket: 'gkfin-tp-pdm.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAb7i_VcQv7WirK5BCd6vTcF6eGZyVGLIw',
    appId: '1:1062263174096:android:7e8b98a2bec83bec4dffd5',
    messagingSenderId: '1062263174096',
    projectId: 'gkfin-tp-pdm',
    storageBucket: 'gkfin-tp-pdm.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD-mX6e3_QJx8pS1rWWrsRiASqFiOYRme8',
    appId: '1:1062263174096:ios:3eb17a6f02e16efa4dffd5',
    messagingSenderId: '1062263174096',
    projectId: 'gkfin-tp-pdm',
    storageBucket: 'gkfin-tp-pdm.appspot.com',
    iosClientId: '1062263174096-nlso84oqbq17ieseimoft4vefcf0kj5k.apps.googleusercontent.com',
    iosBundleId: 'com.example.gkfin',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD-mX6e3_QJx8pS1rWWrsRiASqFiOYRme8',
    appId: '1:1062263174096:ios:3eb17a6f02e16efa4dffd5',
    messagingSenderId: '1062263174096',
    projectId: 'gkfin-tp-pdm',
    storageBucket: 'gkfin-tp-pdm.appspot.com',
    iosClientId: '1062263174096-nlso84oqbq17ieseimoft4vefcf0kj5k.apps.googleusercontent.com',
    iosBundleId: 'com.example.gkfin',
  );
}
