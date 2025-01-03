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
    apiKey: 'AIzaSyDb-DA_X0k9kh2Hvf9F-pLgsK_TefemjJQ',
    appId: '1:585464944769:android:f444172100b84c10981580',
    messagingSenderId: '585464944769',
    projectId: 'movie-app-eeb10',
    storageBucket: 'movie-app-eeb10.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB6apozJPK9JJOrqx3Kq_qpP6HueGCAmzw',
    appId: '1:585464944769:ios:46c74d6220b5a77d981580',
    messagingSenderId: '585464944769',
    projectId: 'movie-app-eeb10',
    storageBucket: 'movie-app-eeb10.appspot.com',
    androidClientId: '585464944769-3hj50u7mj5abh8js3nulnigbvrha3o0d.apps.googleusercontent.com',
    iosClientId: '585464944769-ni7pslhu8jgjd9fm45388nqminpd0reh.apps.googleusercontent.com',
    iosBundleId: 'com.example.coffsyMovieApp',
  );
}
