import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();
  bool _initialized = false;

  /// Initialize the notification service
  /// Must be called before any other methods
  Future<void> initialize() async {
    if (_initialized) return;

    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings iosSettings =
        DarwinInitializationSettings(
          requestAlertPermission: true,
          requestBadgePermission: true,
          requestSoundPermission: true,
        );

    const LinuxInitializationSettings linuxSettings =
        LinuxInitializationSettings(defaultActionName: 'Open notification');

    const WindowsInitializationSettings windowsSettings =
        WindowsInitializationSettings(
          appName: 'Eko Messenger',
          appUserModelId: 'com.eko.messenger',
          guid: "",
        );

    const InitializationSettings settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
      linux: linuxSettings,
      windows: windowsSettings,
    );

    await _plugin.initialize(
      settings,
      onDidReceiveNotificationResponse: _onNotificationTapped,
    );

    // Create Android notification channels
    await _createNotificationChannels();

    _initialized = true;
  }

  /// Create notification channels for Android
  Future<void> _createNotificationChannels() async {
    final androidPlugin = _plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();

    if (androidPlugin == null) return;

    // High priority channel for messages
    const AndroidNotificationChannel messagesChannel =
        AndroidNotificationChannel(
          'messages',
          'Messages',
          description: 'Notifications for new messages',
          importance: Importance.high,
          playSound: true,
          enableVibration: true,
        );

    // Default channel
    const AndroidNotificationChannel defaultChannel =
        AndroidNotificationChannel(
          'default',
          'Default Notifications',
          description: 'General notifications',
          importance: Importance.defaultImportance,
        );

    await androidPlugin.createNotificationChannel(messagesChannel);
    await androidPlugin.createNotificationChannel(defaultChannel);
  }

  /// Handle notification tap
  void _onNotificationTapped(NotificationResponse response) {
    // TODO: Implement navigation based on notification payload
    // This could navigate to specific conversations, etc.
  }

  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
    String channelId = 'default',
    String? payload,
  }) async {
    if (!_initialized) {
      await initialize();
    }

    final androidDetails = AndroidNotificationDetails(
      channelId,
      _getChannelName(channelId),
      importance: _getImportance(channelId),
      priority: _getPriority(channelId),
      channelDescription: _getChannelDescription(channelId),
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const linuxDetails = LinuxNotificationDetails();

    const windowsDetails = WindowsNotificationDetails();

    final details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
      linux: linuxDetails,
      windows: windowsDetails,
    );

    await _plugin.show(id, title, body, details, payload: payload);
  }

  Future<void> showNewMessageNotification({
    required String from,
    required String message,
    int? id,
  }) async {
    // Generate ID from message hash if not provided
    final notificationId = id ?? message.hashCode;
    await showNotification(
      id: notificationId,
      title: from,
      body: message,
      channelId: 'messages',
    );
  }

  /// Cancel a specific notification
  Future<void> cancelNotification(int id) async {
    await _plugin.cancel(id);
  }

  /// Cancel all notifications
  Future<void> cancelAllNotifications() async {
    await _plugin.cancelAll();
  }

  // Helper methods for channel configuration
  String _getChannelName(String channelId) {
    switch (channelId) {
      case 'messages':
        return 'Messages';
      default:
        return 'Default Notifications';
    }
  }

  String _getChannelDescription(String channelId) {
    switch (channelId) {
      case 'messages':
        return 'Notifications for new messages';
      default:
        return 'General notifications';
    }
  }

  Importance _getImportance(String channelId) {
    switch (channelId) {
      case 'messages':
        return Importance.high;
      default:
        return Importance.defaultImportance;
    }
  }

  Priority _getPriority(String channelId) {
    switch (channelId) {
      case 'messages':
        return Priority.high;
      default:
        return Priority.defaultPriority;
    }
  }
}
