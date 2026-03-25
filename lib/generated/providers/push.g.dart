// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../providers/push.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Push)
const pushProvider = PushProvider._();

final class PushProvider extends $NotifierProvider<Push, PushService> {
  const PushProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pushProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pushHash();

  @$internal
  @override
  Push create() => Push();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PushService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PushService>(value),
    );
  }
}

String _$pushHash() => r'2ecebd74411ce216e7da2b2cee5def60523b2a03';

abstract class _$Push extends $Notifier<PushService> {
  PushService build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<PushService, PushService>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<PushService, PushService>,
              PushService,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
