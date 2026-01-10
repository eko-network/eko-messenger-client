// FIREBASE MESSAGING - COMMENTED OUT FOR UNIFIEDPUSH MIGRATION
// This code is preserved for reference but is no longer active

import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;

typedef AuthenticatedClientBuilder = Future<http.Client> Function();
typedef TokenHandler = Future<void> Function(String token);

/* FIREBASE BACKGROUND HANDLER - DISABLED
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await _initializeLocalNotifications();
  await _showNotification(message);
}
*/

/* FIREBASE LOCAL NOTIFICATIONS - DISABLED
late FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;

Future<void> _initializeLocalNotifications() async {
  _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  const AndroidInitializationSettings androidInitializationSettings =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  const DarwinInitializationSettings darwinInitializationSettings =
      DarwinInitializationSettings();

  const InitializationSettings initializationSettings = InitializationSettings(
    android: androidInitializationSettings,
    iOS: darwinInitializationSettings,
  );

  await _flutterLocalNotificationsPlugin.initialize(initializationSettings);

  // Ensure Android notification channel exists for heads-up notifications
  const AndroidNotificationChannel highImportanceChannel =
      AndroidNotificationChannel(
        'high_importance_channel',
        'High Importance Notifications',
        description: 'Used for important notifications.',
        importance: Importance.max,
      );

  final androidPlugin = _flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin
      >();
  if (androidPlugin != null) {
    await androidPlugin.createNotificationChannel(highImportanceChannel);
  }
}

Future<void> _showNotification(RemoteMessage message) async {
  const AndroidNotificationDetails androidNotificationDetails =
      AndroidNotificationDetails(
        'high_importance_channel',
        'High Importance Notifications',
        importance: Importance.max,
        priority: Priority.high,
      );
  const DarwinNotificationDetails darwinNotificationDetails =
      DarwinNotificationDetails();

  const NotificationDetails notificationDetails = NotificationDetails(
    android: androidNotificationDetails,
    iOS: darwinNotificationDetails,
  );

  await _flutterLocalNotificationsPlugin.show(
    message.hashCode,
    "TODO Notification",
    "",
    notificationDetails,
  );
}
*/

/* FIREBASE MESSAGING CONFIGURATION - DISABLED
Future<void> configureFirebaseMessaging({
  required AuthenticatedClientBuilder authenticatedClient,
  TokenHandler? onToken,
  bool requestPermissions = true,
}) async {
  await _initializeLocalNotifications();
  final messaging = FirebaseMessaging.instance;
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  if (requestPermissions) {
    final settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      announcement: false,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
    );

    debugPrint('FCM permission status: ${settings.authorizationStatus}');
  }

  await messaging.setForegroundNotificationPresentationOptions(
    alert: false,
    badge: false,
    sound: false,
  );

  // Get the current FCM token and notify the handler
  final token = await messaging.getToken();
  if (token != null && onToken != null) {
    await onToken(token);
  }

  messaging.onTokenRefresh.listen((refreshedToken) async {
    if (onToken != null) {
      await onToken(refreshedToken);
    }
  });
}
*/
