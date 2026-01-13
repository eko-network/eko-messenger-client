import 'dart:io';
import 'package:eko_messanger/providers/ecp.dart';
import 'package:eko_messanger/providers/messages.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:eko_messanger/services/push/push_service.dart';
import 'package:eko_messanger/services/push/unifiedpush_service.dart';
import 'package:eko_messanger/services/push/apn_service.dart';
import 'package:eko_messanger/services/push/null_push_service.dart';

part '../generated/providers/push.g.dart';

@Riverpod(keepAlive: true)
class Push extends _$Push {
  @override
  PushService build() {
    // Create platform-specific messaging service
    final service = _createPlatformService();

    service.onNewEndpoint = (MessagingEndpoint endpoint) async {
      debugPrint('[Messaging Provider] New endpoint received: $endpoint');

      try {
        // Only send to server if we have encryption keys (UnifiedPush)
        if (endpoint.pubKey != null && endpoint.auth != null) {
          await ref
              .read(ecpProvider)
              .notifications
              .register(endpoint.url, endpoint.pubKey!, endpoint.auth!);

          debugPrint('[Messaging Provider] Endpoint registered with server');
        } else {
          debugPrint(
            '[Messaging Provider] Endpoint lacks encryption keys, '
            'skipping server registration',
          );
        }
      } catch (e) {
        debugPrint('[Messaging Provider] Error sending endpoint to server: $e');
      }
    };

    service.onUnregistered = () {
      debugPrint('[Messaging Provider] Unregistered from push');

      // TODO: Notify server about unregistration
    };

    service.onMessageReceived = (message) async {
      debugPrint('[Messaging Provider] Message: $message');
      try {
        final activities = await ref.read(ecpProvider).getMessages();
        final messagePolling = ref.read(messagePollingProvider.notifier);

        // Process each activity through the unified pipeline
        for (final activity in activities) {
          // Notifications will be displayed here if appropriate.
          await messagePolling.processMessage(
            activity,
            notifiableOverride: true,
          );
        }
      } catch (e) {
        debugPrint('[Messaging Provider] Error processing messages: $e');
      }
    };

    service.onRegistrationFailed = (reason) {
      debugPrint('[Messaging Provider] Registration failed: $reason');
    };

    service.initialize().then((_) => service.register()).catchError((e) {
      debugPrint('[Messaging Provider] Initialization error: $e');
    });

    return service;
  }
}

/// Create the appropriate messaging service for the current platform
PushService _createPlatformService() {
  if (Platform.isLinux || Platform.isAndroid) {
    debugPrint('[Messaging Provider] Using UnifiedPush service');
    return UnifiedPushService();
  } else if (Platform.isIOS) {
    debugPrint('[Messaging Provider] Using APN service (not implemented)');
    return ApnService();
  } else if (Platform.isMacOS || Platform.isWindows) {
    debugPrint(
      '[Messaging Provider] Using Null service '
      '(notifications not supported)',
    );
    return NullPushService();
  } else {
    throw UnsupportedError('Platform not supported for notifications');
  }
}
