import 'package:ecp/ecp.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class _SecureTokenStorage implements TokenStorage {
  final FlutterSecureStorage _storage;

  static const String _accessTokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';
  static const String _expiresAtKey = 'expires_at';
  static const String _serverUrlKey = 'server_url';

  _SecureTokenStorage() : _storage = FlutterSecureStorage();

  @override
  Future<String?> getAccessToken() async {
    return await _storage.read(key: _accessTokenKey);
  }

  @override
  Future<String?> getRefreshToken() async {
    return await _storage.read(key: _refreshTokenKey);
  }

  @override
  Future<String?> getServerUrl() async {
    return await _storage.read(key: _serverUrlKey);
  }

  @override
  Future<DateTime?> getExpiresAt() async {
    final expiresAtString = await _storage.read(key: _expiresAtKey);
    if (expiresAtString == null) {
      return null;
    }
    return DateTime.tryParse(expiresAtString);
  }

  @override
  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
    required String serverUrl,
    DateTime? expiresAt,
  }) async {
    // Use Future.wait to perform all writes concurrently
    await Future.wait([
      _storage.write(key: _accessTokenKey, value: accessToken),
      _storage.write(key: _refreshTokenKey, value: refreshToken),
      _storage.write(key: _serverUrlKey, value: serverUrl),
      if (expiresAt != null)
        _storage.write(key: _expiresAtKey, value: expiresAt.toIso8601String())
      else
        _storage.delete(key: _expiresAtKey),
    ]);
  }

  @override
  Future<void> clearTokens() async {
    // Use Future.wait to perform all deletions concurrently
    await Future.wait([
      _storage.delete(key: _accessTokenKey),
      _storage.delete(key: _refreshTokenKey),
      _storage.delete(key: _expiresAtKey),
      _storage.delete(key: _serverUrlKey),
    ]);
  }
}

Future<void> createEcp(Uri url) async {
  final storage = _SecureTokenStorage();
  const deviceName = "Test Device";

  ecp =
      (await ECPClient.tryRestore(
        storage: _SecureTokenStorage(),
        deviceName: deviceName,
      )) ??
      ECPClient(storage: storage, baseUrl: url, deviceName: deviceName);
}

late ECPClient ecp;

void disposeEcp() {
  ecp.dispose();
}
