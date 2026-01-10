// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../providers/ecp.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ecp)
const ecpProvider = EcpProvider._();

final class EcpProvider
    extends $FunctionalProvider<EcpClient, EcpClient, EcpClient>
    with $Provider<EcpClient> {
  const EcpProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'ecpProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$ecpHash();

  @$internal
  @override
  $ProviderElement<EcpClient> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  EcpClient create(Ref ref) {
    return ecp(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EcpClient value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EcpClient>(value),
    );
  }
}

String _$ecpHash() => r'2bc57bdd75f3cd1a5eda5d85f9a6ff99d717154c';
