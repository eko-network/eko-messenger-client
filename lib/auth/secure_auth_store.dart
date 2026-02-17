import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:ecp/auth.dart';
import 'package:ecp/ecp.dart';
import 'package:eko_messenger/database/database.dart';

class SecureAuthStore implements AuthStorage {
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
      serverUrl: result.serverUrl,
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
            serverUrl: tokens.serverUrl,
          ),
        );
  }

  @override
  Future<void> clear() async {
    await _db.delete(_db.authInfoTable).go();
  }

  @override
  Future<void> handleRefresh(RefreshResponse refresh) async {
    await (_db.update(
      _db.authInfoTable,
    )..where((tbl) => tbl.id.equals(1))).write(
      AuthInfoTableCompanion(
        expiresAt: Value(refresh.expiresAt),
        accessToken: Value(refresh.accessToken),
        refreshToken: Value(refresh.refreshToken),
      ),
    );
  }
}
