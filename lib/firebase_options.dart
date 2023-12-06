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
    apiKey: 'AIzaSyBZo_7T5q3XWaHX9p8eKviowy8DHcarrlE',
    appId: '1:486591466410:android:50b8e21a470123f3d9f9d3',
    messagingSenderId: '486591466410',
    projectId: 'todo-list-provider-3214a',
    storageBucket: 'todo-list-provider-3214a.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBmpb1o3YKjvAAH8GjQYM5hvikIMEQrfvY',
    appId: '1:486591466410:ios:e05d84ec26303117d9f9d3',
    messagingSenderId: '486591466410',
    projectId: 'todo-list-provider-3214a',
    storageBucket: 'todo-list-provider-3214a.appspot.com',
    androidClientId: '486591466410-4248g6cq5amtecc6gbvhlej1u7eflsh3.apps.googleusercontent.com',
    iosClientId: '486591466410-kqfbskgp5887l603mma087tcmccqre13.apps.googleusercontent.com',
    iosBundleId: 'br.com.academiadoflutter.todoList',
  );
}