import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:unifiedpush/unifiedpush.dart';
import 'package:eko_messanger/services/notification_service.dart';
import 'package:eko_messanger/services/push/push_service.dart';

/// UnifiedPush implementation of MessagingProvider
/// Supports Linux and Android platforms
class UnifiedPushService implements PushService {
  static final UnifiedPushService _instance = UnifiedPushService._internal();
  factory UnifiedPushService() => _instance;
  UnifiedPushService._internal() {
    // Validate platform
    if (!Platform.isLinux && !Platform.isAndroid) {
      throw UnsupportedError(
        'UnifiedPush is only supported on Linux and Android platforms',
      );
    }
  }

  final NotificationService _notificationService = NotificationService();

  MessagingEndpoint? _endpoint;
  bool _initialized = false;
  Completer<void>? _initCompleter;

  /// Vapid public key
  String? vapid;

  @override
  Function(MessagingEndpoint endpoint)? onNewEndpoint;

  @override
  Function()? onUnregistered;

  @override
  Function(String message)? onMessageReceived;

  @override
  Function(String reason)? onRegistrationFailed;

  @override
  MessagingEndpoint? get endpoint => _endpoint;

  @override
  bool get isRegistered => _endpoint != null;

  @override
  Future<void> initialize() async {
    if (_initialized) return;

    await _notificationService.initialize();

    // Set up UnifiedPush callbacks
    // Returns true if already registered, which means onNewEndpoint will be called
    final alreadyRegistered = await UnifiedPush.initialize(
      onNewEndpoint: _handleNewEndpoint,
      onRegistrationFailed: _handleRegistrationFailed,
      onUnregistered: _handleUnregistered,
      onMessage: _handleMessage,
    );

    _initialized = true;

    // If already registered, wait for the endpoint callback to complete
    if (alreadyRegistered && _endpoint == null) {
      _initCompleter = Completer<void>();
      debugPrint('[UnifiedPush] Already registered, waiting for endpoint...');
      await _initCompleter!.future.timeout(
        const Duration(seconds: 5),
        onTimeout: () {
          debugPrint('[UnifiedPush] Timeout waiting for endpoint');
        },
      );
    }

    debugPrint('[UnifiedPush] Service initialized');
  }

  @override
  Future<void> register() async {
    if (!_initialized) {
      await initialize();
    }

    try {
      // Try to use current or default distributor
      final success = await UnifiedPush.tryUseCurrentOrDefaultDistributor();
      debugPrint('[UnifiedPush] Current or default found: $success');

      if (success) {
        // Use a unique instance identifier for this app installation
        await UnifiedPush.register(vapid: vapid);
        debugPrint('[UnifiedPush] Registration requested');
      } else {
        // No default distributor, user needs to select one
        debugPrint('[UnifiedPush] No default distributor available');
        onRegistrationFailed?.call('No default distributor available');
      }
    } catch (e) {
      debugPrint('[UnifiedPush] Registration error: $e');
      onRegistrationFailed?.call(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> unregister() async {
    if (!_initialized) return;

    try {
      const instance = 'eko-messenger';
      await UnifiedPush.unregister(instance);
      debugPrint('[UnifiedPush] Unregistered');
    } catch (e) {
      debugPrint('[UnifiedPush] Unregister error: $e');
      rethrow;
    }
  }

  /// Get list of available distributors
  Future<List<String>> getDistributors() async {
    return await UnifiedPush.getDistributors();
  }

  // Callback handlers

  void _handleNewEndpoint(PushEndpoint pushEndpoint, String instance) {
    debugPrint('[UnifiedPush] New endpoint: ${pushEndpoint.url}');

    _endpoint = MessagingEndpoint.fromUnifiedPush(
      url: pushEndpoint.url,
      pubKey: pushEndpoint.pubKeySet?.pubKey,
      auth: pushEndpoint.pubKeySet?.auth,
    );

    // Complete initialization if waiting
    if (_initCompleter != null && !_initCompleter!.isCompleted) {
      _initCompleter!.complete();
      _initCompleter = null;
    }

    // Notify callback with endpoint and encryption keys
    onNewEndpoint?.call(_endpoint!);
  }

  void _handleRegistrationFailed(FailedReason reason, String instance) {
    debugPrint(
      '[UnifiedPush] Registration failed: $reason for instance: $instance',
    );
    _endpoint = null;

    // Complete initialization if waiting
    if (_initCompleter != null && !_initCompleter!.isCompleted) {
      _initCompleter!.complete();
      _initCompleter = null;
    }

    // Notify callback
    onRegistrationFailed?.call(reason.toString());
  }

  void _handleUnregistered(String instance) {
    debugPrint('[UnifiedPush] Unregistered instance: $instance');
    _endpoint = null;

    // Notify callback
    onUnregistered?.call();
  }

  void _handleMessage(PushMessage message, String instance) {
    // Decode the message content
    String messageText;
    if (message.decrypted) {
      messageText = String.fromCharCodes(message.content);
      debugPrint('[UnifiedPush] Decrypted message received: $messageText');
    } else {
      // Message wasn't decrypted - this shouldn't happen normally
      messageText = 'Encrypted message (could not decrypt)';
      debugPrint(
        '[UnifiedPush] Encrypted message received (failed to decrypt)',
      );
    }

    // Call custom handler if provided
    onMessageReceived?.call(messageText);
  }

  @override
  Map<String, dynamic> getStatus() {
    return {
      'platform': 'unifiedpush',
      'initialized': _initialized,
      'registered': isRegistered,
      'endpoint': _endpoint?.toString(),
    };
  }
}
