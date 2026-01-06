// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../providers/auth.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(auth)
const authProvider = AuthProvider._();

final class AuthProvider
    extends $FunctionalProvider<AuthNotifier, AuthNotifier, AuthNotifier>
    with $Provider<AuthNotifier> {
  const AuthProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authHash();

  @$internal
  @override
  $ProviderElement<AuthNotifier> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AuthNotifier create(Ref ref) {
    return auth(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuthNotifier value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuthNotifier>(value),
    );
  }
}

String _$authHash() => r'95d54cb154b4b1a7504df1876129161b6f150e0b';
