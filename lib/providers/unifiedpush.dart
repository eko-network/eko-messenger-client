import 'package:eko_messanger/providers/ecp.dart';
import 'package:eko_messanger/providers/message_polling.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:eko_messanger/services/unifiedpush_service.dart';

part '../generated/providers/unifiedpush.g.dart';

@Riverpod(keepAlive: true)
UnifiedPushService unifiedpush(Ref ref) {
  final service = UnifiedPushService();

  // Set up endpoint callback to send to server
  service.onNewEndpoint = (endpoint) async {
    debugPrint('[UnifiedPush Provider] New endpoint received: $endpoint');
    debugPrint('[UnifiedPush Provider] PubKeySet: ${endpoint.pubKeySet}');

    try {
      // Prepare bundle and send to server
      final bundle = endpoint;

      await ref
          .read(ecpProvider)
          .notifications
          .register(
            endpoint.url,
            endpoint.pubKeySet!.pubKey,
            endpoint.pubKeySet!.auth,
          );

      debugPrint('[UnifiedPush Provider] Bundle prepared: $bundle');
    } catch (e) {
      debugPrint('[UnifiedPush Provider] Error sending endpoint to server: $e');
    }
  };

  // Handle unregistration
  service.onUnregistered = () {
    debugPrint('[UnifiedPush Provider] Unregistered from push');

    // TODO: Notify server about unregistration
  };

  service.onMessageReceived = (message) async {
    debugPrint('[UnifiedPush Provider] Message: $message');
    try {
      final activities = await ref.read(ecpProvider).getMessages();
      final messagePolling = ref.read(messagePollingProvider.notifier);

      // Process each activity through the unified pipeline
      for (final activity in activities) {
        await messagePolling.processMessage(activity, notifiableOverride: true);
      }
    } catch (e) {
      debugPrint('[UnifiedPush Provider] Error processing messages: $e');
    }
  };

  return service;
}

Future<void> initializeUnifiedPush(UnifiedPushService service) async {
  await service.initialize();
  await service.register();
}
