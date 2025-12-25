import 'dart:convert';

import 'package:ecp/auth.dart';
import 'package:ecp/ecp.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:eko_messanger/utils/constants.dart' as c;
import 'package:eko_messanger/database/database.dart';

class SecureAuthStore implements AuthStorage {
  final _storage = const FlutterSecureStorage();
  final _dbPasswordKey = '${c.appInstanceId}_db_password';
  final AppDatabase _db;

  SecureAuthStore(this._db);

  @override
  Future<AuthInfo?> getAuthInfo() async {
    final result = await (_db.select(
      _db.authInfoTable,
    )..where((t) => t.id.equals(1))).getSingleOrNull();

    if (result == null) {
      return null;
    }
    return AuthInfo(
      did: result.did,
      accessToken: result.accessToken,
      refreshToken: result.refreshToken,
      expiresAt: result.expiresAt,
      serverUrl: Uri.parse(result.serverUrl),
      actor: Person.fromJson(jsonDecode(result.actorJson)),
    );
  }

  @override
  Future<void> saveAuthInfo(AuthInfo tokens) async {
    await _db
        .into(_db.authInfoTable)
        .insertOnConflictUpdate(
          AuthInfoTableCompanion.insert(
            did: tokens.did,
            accessToken: tokens.accessToken,
            refreshToken: tokens.refreshToken,
            expiresAt: tokens.expiresAt,
            actorJson: jsonEncode(tokens.actor.toJson()),
            serverUrl: tokens.serverUrl.toString(),
          ),
        );
  }

  @override
  Future<void> clear() async {
    await _db.delete(_db.authInfoTable).go();
  }

  // Database password management
  Future<String?> getDatabasePassword() async {
    return await _storage.read(key: _dbPasswordKey);
  }

  Future<void> saveDatabasePassword(String password) async {
    await _storage.write(key: _dbPasswordKey, value: password);
  }

  Future<void> clearDatabasePassword() async {
    await _storage.delete(key: _dbPasswordKey);
  }
}
