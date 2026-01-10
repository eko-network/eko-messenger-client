import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:unifiedpush/unifiedpush.dart';
import 'package:eko_messanger/services/notification_service.dart';

class UnifiedPushService {
  static final UnifiedPushService _instance = UnifiedPushService._internal();
  factory UnifiedPushService() => _instance;
  UnifiedPushService._internal();

  final NotificationService _notificationService = NotificationService();

  PushEndpoint? _endpoint;
  bool _initialized = false;
  Completer<void>? _initCompleter;

  /// Vapid public key
  String? vapid;

  /// Callback for when a new endpoint is registered
  /// This should be used to send the endpoint to your server
  Function(PushEndpoint endpoint)? onNewEndpoint;

  /// Callback for when endpoint is unregistered
  Function()? onUnregistered;

  /// Callback for when a message is received
  /// This allows custom processing before/instead of showing notification
  Function(String message)? onMessageReceived;

  /// Callback for when registration fails
  Function(FailedReason reason)? onRegistrationFailed;

  /// Get the current push endpoint (if registered)
  PushEndpoint? get endpoint => _endpoint;

  /// Check if UnifiedPush is initialized and registered
  bool get isRegistered => _endpoint != null;

  /// Initialize UnifiedPush
  /// Must be called before registration
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

  /// Register with UnifiedPush
  /// First attempts to use current or default distributor
  /// If that fails, user needs to manually select one
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
        // Call the UI to let user choose - see selectAndRegister()
      }
    } catch (e) {
      debugPrint('[UnifiedPush] Registration error: $e');
      rethrow;
    }
  }

  /// Get list of available distributors and register with selected one
  /// This should be called if register() fails to find a default
  // Future<void> selectAndRegister(String distributor) async {
  //   if (!_initialized) {
  //     await initialize();
  //   }

  //   try {
  //     // Save the selected distributor
  //     await UnifiedPush.saveDistributor(distributor);

  //     // Register with the distributor
  //     await UnifiedPush.register();
  //     debugPrint(
  //       '[UnifiedPush] Registered with selected distributor: $distributor',
  //     );
  //   } catch (e) {
  //     debugPrint('[UnifiedPush] Error registering with distributor: $e');
  //     rethrow;
  //   }
  // }

  /// Unregister from UnifiedPush
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

  void _handleNewEndpoint(PushEndpoint endpoint, String instance) {
    debugPrint('[UnifiedPush] New endpoint: ${endpoint.url}');
    _endpoint = endpoint;

    // Complete initialization if waiting
    if (_initCompleter != null && !_initCompleter!.isCompleted) {
      _initCompleter!.complete();
      _initCompleter = null;
    }

    // Notify callback with endpoint and encryption keys
    onNewEndpoint?.call(endpoint);
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
    onRegistrationFailed?.call(reason);
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

  /// Get status information for debugging
  Map<String, dynamic> getStatus() {
    return {
      'initialized': _initialized,
      'registered': isRegistered,
      'endpoint': _endpoint,
    };
  }
}
