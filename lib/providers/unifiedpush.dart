import 'package:eko_messanger/providers/ecp.dart';
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

  service.onMessageReceived = (message) {
    debugPrint('[UnifiedPush Provider] Message: $message');

    // TODO: message processing
  };

  return service;
}

Future<void> initializeUnifiedPush(UnifiedPushService service) async {
  await service.initialize();
  await service.register();
}
