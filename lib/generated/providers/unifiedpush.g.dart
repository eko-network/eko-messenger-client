// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../providers/unifiedpush.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(unifiedpush)
const unifiedpushProvider = UnifiedpushProvider._();

final class UnifiedpushProvider
    extends
        $FunctionalProvider<
          UnifiedPushService,
          UnifiedPushService,
          UnifiedPushService
        >
    with $Provider<UnifiedPushService> {
  const UnifiedpushProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'unifiedpushProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$unifiedpushHash();

  @$internal
  @override
  $ProviderElement<UnifiedPushService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  UnifiedPushService create(Ref ref) {
    return unifiedpush(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UnifiedPushService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UnifiedPushService>(value),
    );
  }
}

String _$unifiedpushHash() => r'fdc2d5e956f1210d3a76f1709d83481cb6a27aa7';
