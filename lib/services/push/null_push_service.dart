import 'dart:io';
import 'package:eko_messenger/services/push/push_service.dart';

/// Null implementation of MessagingProvider for unsupported platforms
/// Used on macOS and Windows where push notifications are not implemented
class NullPushService implements PushService {
  static final NullPushService _instance = NullPushService._internal();
  factory NullPushService() => _instance;
  NullPushService._internal() {
    // Validate platform
    if (!Platform.isMacOS && !Platform.isWindows) {
      throw UnsupportedError(
        'NullMessagingService is only for macOS and Windows platforms',
      );
    }
  }

  @override
  Function(MessagingEndpoint endpoint)? onNewEndpoint;

  @override
  Function()? onUnregistered;

  @override
  Function(String message)? onMessageReceived;

  @override
  Function(String reason)? onRegistrationFailed;

  @override
  MessagingEndpoint? get endpoint => null;

  @override
  bool get isRegistered => false;

  @override
  Future<void> initialize() async {
    // No-op: notifications not supported on this platform
    return;
  }

  @override
  Future<void> register() async {
    // No-op: notifications not supported on this platform
    return;
  }

  @override
  Future<void> unregister() async {
    // No-op: notifications not supported on this platform
    return;
  }

  @override
  Map<String, dynamic> getStatus() {
    return {
      'platform': Platform.isMacOS ? 'macos' : 'windows',
      'initialized': false,
      'registered': false,
      'supported': false,
      'message': 'Push notifications are not supported on this platform',
    };
  }
}
