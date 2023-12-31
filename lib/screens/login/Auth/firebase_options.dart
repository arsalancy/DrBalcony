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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCPqO5j0mjYb5ktoG26AxQdjoiotqpJbLw',
    appId: '1:979647511982:android:7c11b13449079a1c09dc3f',
    messagingSenderId: '979647511982',
    projectId: 'drbalcony-24e1d',
    storageBucket: 'drbalcony-24e1d.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCUtEYS3SRmvVCzhk_x3lzMgfkJhdScDBA',
    appId: '1:979647511982:ios:20f45286ba683ea609dc3f',
    messagingSenderId: '979647511982',
    projectId: 'drbalcony-24e1d',
    storageBucket: 'drbalcony-24e1d.appspot.com',
    androidClientId:
        '979647511982-8lqmhatuvtg8ug3s6omvb801m8o5fgsu.apps.googleusercontent.com',
    iosClientId:
        '979647511982-7e86hqg93hsap7fgg22nb1dgki0tupn1.apps.googleusercontent.com',
    iosBundleId: 'com.drbalcony.drbalcony',
  );
}
//--------------------------------------------------Doc--------------------------------------------------\\
/*
This code defines a class called `DefaultFirebaseOptions` that provides default configurations for Firebase options based on the current platform.

Here's a breakdown of what the code does:

- The code imports necessary dependencies, including `firebase_core.dart` from the `firebase_core` package and `defaultTargetPlatform` and `kIsWeb` from `flutter/foundation`.

- The `DefaultFirebaseOptions` class is defined, which contains static methods and constants.

- The `currentPlatform` static getter method is defined. It checks the current platform using `kIsWeb` and `defaultTargetPlatform` variables.

  - If the current platform is web (`kIsWeb` is true), it throws an `UnsupportedError` because default Firebase options have not been configured for web.

  - If the current platform is Android, iOS, or macOS, it returns the corresponding Firebase options (`android` or `ios`).

  - If the current platform is Windows, Linux, or any other platform, it throws an `UnsupportedError` because default Firebase options have not been configured for those platforms.

- The `android` and `ios` constants are defined as instances of the `FirebaseOptions` class. These constants contain the default Firebase configuration options for Android and iOS platforms, respectively. They include properties such as `apiKey`, `appId`, `messagingSenderId`, `projectId`, `storageBucket`, `androidClientId`, `iosClientId`, and `iosBundleId`. These values are specific to the Firebase project being used.

The purpose of this code is to provide a convenient way to access default Firebase options based on the current platform in a Flutter application. It allows developers to initialize Firebase with the appropriate options without manually specifying them for each platform.
*/