// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../providers/device_name_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(deviceName)
const deviceNameProvider = DeviceNameProvider._();

final class DeviceNameProvider
    extends $FunctionalProvider<String, String, String>
    with $Provider<String> {
  const DeviceNameProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'deviceNameProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$deviceNameHash();

  @$internal
  @override
  $ProviderElement<String> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  String create(Ref ref) {
    return deviceName(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$deviceNameHash() => r'f637063181d22a42f14d45325e93fd44fb023c9b';
