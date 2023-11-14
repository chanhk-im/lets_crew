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
    apiKey: 'AIzaSyA8cK78QeIH9svXUhWIcfQEgVWMT34egfo',
    appId: '1:123459918085:web:69d62505922c9058b07f6c',
    messagingSenderId: '123459918085',
    projectId: 'lets-crew',
    authDomain: 'lets-crew.firebaseapp.com',
    storageBucket: 'lets-crew.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAIWD7-8vsABPgCUtDO2rssqC6upP85gqg',
    appId: '1:123459918085:android:130a6e0338ae9145b07f6c',
    messagingSenderId: '123459918085',
    projectId: 'lets-crew',
    storageBucket: 'lets-crew.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB7dakyYdkw-FrXkzqEpxumBAUUMcJ-kgk',
    appId: '1:123459918085:ios:db54c2353355f337b07f6c',
    messagingSenderId: '123459918085',
    projectId: 'lets-crew',
    storageBucket: 'lets-crew.appspot.com',
    iosBundleId: 'com.example.letsCrew',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB7dakyYdkw-FrXkzqEpxumBAUUMcJ-kgk',
    appId: '1:123459918085:ios:741fde1b777091e3b07f6c',
    messagingSenderId: '123459918085',
    projectId: 'lets-crew',
    storageBucket: 'lets-crew.appspot.com',
    iosBundleId: 'com.example.letsCrew.RunnerTests',
  );
}
