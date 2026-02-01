// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../providers/messages.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(MessagePolling)
const messagePollingProvider = MessagePollingProvider._();

final class MessagePollingProvider
    extends $NotifierProvider<MessagePolling, void> {
  const MessagePollingProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'messagePollingProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$messagePollingHash();

  @$internal
  @override
  MessagePolling create() => MessagePolling();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$messagePollingHash() => r'3bae2409bc6604628a013e0c4401e43222752b72';

abstract class _$MessagePolling extends $Notifier<void> {
  void build();
  @$mustCallSuper
  @override
  void runBuild() {
    build();
    final ref = this.ref as $Ref<void, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<void, void>,
              void,
              Object?,
              Object?
            >;
    element.handleValue(ref, null);
  }
}
