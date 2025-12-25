// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../providers/message_polling.dart';

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

String _$messagePollingHash() => r'810579129d6908ac6353260b893b565384892e37';

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
