import 'dart:developer' as developer;

import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotifications {
  static Future<void> requestPermissionAndToken() async {
    try {
      final NotificationSettings settings = await FirebaseMessaging.instance.requestPermission();
      developer.log('Push permission: ${settings.authorizationStatus}');
      final String? token = await FirebaseMessaging.instance.getToken();
      developer.log('FCM token: $token');
    } catch (e, st) {
      developer.log('Push setup failed: $e', stackTrace: st);
    }
  }
}


