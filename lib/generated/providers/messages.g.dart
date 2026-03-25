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

String _$messagePollingHash() => r'c989e3eda34a45d67e2862176a4ec6cfd676ce86';

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

@ProviderFor(messageStream)
const messageStreamProvider = MessageStreamFamily._();

final class MessageStreamProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<MessageWithAttachments>>,
          List<MessageWithAttachments>,
          Stream<List<MessageWithAttachments>>
        >
    with
        $FutureModifier<List<MessageWithAttachments>>,
        $StreamProvider<List<MessageWithAttachments>> {
  const MessageStreamProvider._({
    required MessageStreamFamily super.from,
    required (Uri, Uri) super.argument,
  }) : super(
         retry: null,
         name: r'messageStreamProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$messageStreamHash();

  @override
  String toString() {
    return r'messageStreamProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $StreamProviderElement<List<MessageWithAttachments>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<MessageWithAttachments>> create(Ref ref) {
    final argument = this.argument as (Uri, Uri);
    return messageStream(ref, argument.$1, argument.$2);
  }

  @override
  bool operator ==(Object other) {
    return other is MessageStreamProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$messageStreamHash() => r'8d9f3e30d14495f89a07be35a5511de805099789';

final class MessageStreamFamily extends $Family
    with
        $FunctionalFamilyOverride<
          Stream<List<MessageWithAttachments>>,
          (Uri, Uri)
        > {
  const MessageStreamFamily._()
    : super(
        retry: null,
        name: r'messageStreamProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  MessageStreamProvider call(Uri contactId, Uri actorId) =>
      MessageStreamProvider._(argument: (contactId, actorId), from: this);

  @override
  String toString() => r'messageStreamProvider';
}
