import 'dart:convert';

import 'package:ecp/auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureAuthStore implements AuthStorage {
  final _storage = const FlutterSecureStorage();
  final _key = 'auth_info';

  @override
  Future<AuthInfo?> getAuthInfo() async {
    final jsonString = await _storage.read(key: _key);
    if (jsonString == null) {
      return null;
    }
    return AuthInfo.fromJson(
      jsonDecode(jsonString),
      Uri.parse(jsonDecode(jsonString)['serverUrl']),
    );
  }

  @override
  Future<void> saveAuthInfo(AuthInfo tokens) async {
    await _storage.write(
      key: _key,
      value: jsonEncode({
        'did': tokens.did,
        'accessToken': tokens.accessToken,
        'refreshToken': tokens.refreshToken,
        'expiresAt': tokens.expiresAt.toIso8601String(),
        //maybe move this?
        'actor': tokens.actor.toJson(),
        'serverUrl': tokens.serverUrl.toString(),
      }),
    );
  }

  @override
  Future<void> clear() async {
    await _storage.delete(key: _key);
  }
}
