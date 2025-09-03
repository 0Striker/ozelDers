import 'dart:developer' as developer;

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> tryInitializeFirebase() async {
  final String? apiKey = dotenv.env['FIREBASE_API_KEY'];
  final String? appId = dotenv.env['FIREBASE_APP_ID'];
  final String? messagingSenderId = dotenv.env['FIREBASE_MESSAGING_SENDER_ID'];
  final String? projectId = dotenv.env['FIREBASE_PROJECT_ID'];
  final String? authDomain = dotenv.env['FIREBASE_AUTH_DOMAIN'];
  final String? storageBucket = dotenv.env['FIREBASE_STORAGE_BUCKET'];
  final String? measurementId = dotenv.env['FIREBASE_MEASUREMENT_ID'];

  final bool hasRequired = apiKey != null && appId != null && projectId != null && messagingSenderId != null;
  if (!hasRequired) {
    developer.log('Firebase not initialized. Missing env. App will run without Firebase.');
    return;
  }

  try {
    final FirebaseOptions options = FirebaseOptions(
      apiKey: apiKey!,
      appId: appId!,
      messagingSenderId: messagingSenderId!,
      projectId: projectId!,
      authDomain: kIsWeb ? authDomain : null,
      storageBucket: storageBucket,
      measurementId: kIsWeb ? measurementId : null,
    );
    await Firebase.initializeApp(options: options);
    developer.log('Firebase initialized');
  } catch (e, st) {
    developer.log('Firebase init failed: $e', stackTrace: st);
  }
}


