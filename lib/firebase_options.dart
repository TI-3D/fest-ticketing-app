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
    apiKey: 'AIzaSyCqKnIpvOtzu2TJs6naYIbHFIOma0TIDmU',
    appId: '1:951606629690:web:aa9f09df9ca686ca4eac03',
    messagingSenderId: '951606629690',
    projectId: 'fest-ticketing1313',
    authDomain: 'fest-ticketing1313.firebaseapp.com',
    storageBucket: 'fest-ticketing1313.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA3ypfXM4cN1B1qXBGISa7LK5cYH2njtmM',
    appId: '1:951606629690:android:a64cae787d3460324eac03',
    messagingSenderId: '951606629690',
    projectId: 'fest-ticketing1313',
    storageBucket: 'fest-ticketing1313.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBQzvptyBDhAtnbfSbKU2AtaUIeG3DV1Us',
    appId: '1:951606629690:ios:3fabf3c01bea57274eac03',
    messagingSenderId: '951606629690',
    projectId: 'fest-ticketing1313',
    storageBucket: 'fest-ticketing1313.appspot.com',
    iosBundleId: 'com.festTicketing',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBQzvptyBDhAtnbfSbKU2AtaUIeG3DV1Us',
    appId: '1:951606629690:ios:3fabf3c01bea57274eac03',
    messagingSenderId: '951606629690',
    projectId: 'fest-ticketing1313',
    storageBucket: 'fest-ticketing1313.appspot.com',
    iosBundleId: 'com.festTicketing',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCqKnIpvOtzu2TJs6naYIbHFIOma0TIDmU',
    appId: '1:951606629690:web:efa4992ba210d0234eac03',
    messagingSenderId: '951606629690',
    projectId: 'fest-ticketing1313',
    authDomain: 'fest-ticketing1313.firebaseapp.com',
    storageBucket: 'fest-ticketing1313.appspot.com',
  );
}
