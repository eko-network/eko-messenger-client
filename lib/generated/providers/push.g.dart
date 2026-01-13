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

String _$pushHash() => r'0e525f64e45e1d07ebd2a88a8c0b1640597054e4';

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
