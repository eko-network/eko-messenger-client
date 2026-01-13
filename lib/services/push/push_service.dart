
/// Platform-agnostic messaging endpoint data
/// The APN stuff is a guess for now, and probably a bad one
class MessagingEndpoint {
  /// The push notification endpoint URL
  final String url;

  /// Public key for encryption (if supported)
  final String? pubKey;

  /// Authentication secret for encryption (if supported)
  final String? auth;

  /// Platform identifier
  final String platform;

  /// Additional platform-specific data
  final Map<String, dynamic>? additionalData;

  MessagingEndpoint({
    required this.url,
    this.pubKey,
    this.auth,
    required this.platform,
    this.additionalData,
  });

  /// Create from UnifiedPush endpoint
  factory MessagingEndpoint.fromUnifiedPush({
    required String url,
    required String? pubKey,
    required String? auth,
  }) {
    return MessagingEndpoint(
      url: url,
      pubKey: pubKey,
      auth: auth,
      platform: 'unifiedpush',
    );
  }

  /// Create from APN token (future implementation)
  factory MessagingEndpoint.fromApn({
    required String token,
    Map<String, dynamic>? additionalData,
  }) {
    return MessagingEndpoint(
      url: token,
      platform: 'apn',
      additionalData: additionalData,
    );
  }

  @override
  String toString() {
    return 'MessagingEndpoint(platform: $platform, url: $url, '
        'hasPubKey: ${pubKey != null}, hasAuth: ${auth != null})';
  }
}

/// Abstract interface for platform-specific push messaging providers
///
/// Implementations:
/// - UnifiedPushMessagingService (Linux/Android)
/// - ApnMessagingService (iOS)
/// - NullMessagingService (macOS/Windows)
abstract class PushService {
  /// Callback for when a new endpoint is registered
  /// This should be used to send the endpoint to your server
  Function(MessagingEndpoint endpoint)? onNewEndpoint;

  /// Callback for when endpoint is unregistered
  Function()? onUnregistered;

  /// Callback for when a message is received
  /// This allows custom processing before/instead of showing notification
  Function(String message)? onMessageReceived;

  /// Callback for when registration fails
  Function(String reason)? onRegistrationFailed;

  /// Get the current push endpoint (if registered)
  MessagingEndpoint? get endpoint;

  /// Check if the provider is initialized and registered
  bool get isRegistered;

  /// Initialize the messaging provider
  /// Must be called before registration
  Future<void> initialize();

  /// Register with the messaging service
  Future<void> register();

  /// Unregister from the messaging service
  Future<void> unregister();

  /// Get status information for debugging
  Map<String, dynamic> getStatus();
}
