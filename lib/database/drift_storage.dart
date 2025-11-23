import 'package:drift/drift.dart';
import 'package:ecp/ecp.dart';
import 'database.dart';

class DriftAuthStore extends AuthTokenStore {
  final AppDatabase _db;

  static const int _singleRowId = 1;

  DriftAuthStore(this._db);
  @override
  Future<void> saveAuthTokens(AuthTokens tokens) async {
    await _db
        .into(_db.authSessions)
        .insertOnConflictUpdate(
          AuthSessionsCompanion(
            id: const Value(_singleRowId),
            accessToken: Value(tokens.accessToken),
            refreshToken: Value(tokens.refreshToken),
            serverUrl: Value(tokens.serverUrl.toString()),
            expiresAt: Value(tokens.expiresAt),
          ),
        );
  }

  @override
  Future<AuthTokens?> getAuthTokens() async {
    final tokens = await (_db.select(
      _db.authSessions,
    )..where((t) => t.id.equals(_singleRowId))).getSingleOrNull();

    if (tokens == null) return null;
    return AuthTokens(
      accessToken: tokens.accessToken,
      refreshToken: tokens.refreshToken,
      expiresAt: tokens.expiresAt,
      serverUrl: Uri.parse(tokens.serverUrl),
    );
  }
}

class DriftSessionStore extends SessionStore {
  final AppDatabase _db;

  DriftSessionStore(this._db);
  @override
  Future<bool> containsSession(SignalProtocolAddress address) async {
    final session =
        await (_db.select(_db.sessions)..where(
              (s) =>
                  s.name.equals(address.getName()) &
                  s.deviceId.equals(address.getDeviceId()),
            ))
            .getSingleOrNull();
    return session != null;
  }

  @override
  Future<void> deleteAllSessions(String name) async {
    await (_db.delete(_db.sessions)..where((s) => s.name.equals(name))).go();
  }

  @override
  Future<void> deleteSession(SignalProtocolAddress address) async {
    await (_db.delete(_db.sessions)..where(
          (s) =>
              s.name.equals(address.getName()) &
              s.deviceId.equals(address.getDeviceId()),
        ))
        .go();
  }

  @override
  Future<List<int>> getSubDeviceSessions(String name) async {
    final result = await (_db.select(
      _db.sessions,
    )..where((s) => s.name.equals(name))).get();
    return result.map((s) => s.deviceId).where((id) => id != 1).toList();
  }

  @override
  Future<SessionRecord> loadSession(SignalProtocolAddress address) async {
    final session =
        await (_db.select(_db.sessions)..where(
              (s) =>
                  s.name.equals(address.getName()) &
                  s.deviceId.equals(address.getDeviceId()),
            ))
            .getSingleOrNull();
    if (session == null) {
      return SessionRecord();
    }
    return SessionRecord.fromSerialized(session.record);
  }

  @override
  Future<void> storeSession(
    SignalProtocolAddress address,
    SessionRecord record,
  ) async {
    await _db
        .into(_db.sessions)
        .insertOnConflictUpdate(
          SessionsCompanion(
            name: Value(address.getName()),
            deviceId: Value(address.getDeviceId()),
            record: Value(record.serialize()),
          ),
        );
  }
}

class DriftSignedPreKeyStore extends SignedPreKeyStore {
  final AppDatabase _db;
  DriftSignedPreKeyStore(this._db);
  @override
  Future<bool> containsSignedPreKey(int signedPreKeyId) async {
    final key = await (_db.select(
      _db.signedPreKeys,
    )..where((k) => k.id.equals(signedPreKeyId))).getSingleOrNull();
    return key != null;
  }

  @override
  Future<SignedPreKeyRecord> loadSignedPreKey(int signedPreKeyId) async {
    final key = await (_db.select(
      _db.signedPreKeys,
    )..where((k) => k.id.equals(signedPreKeyId))).getSingleOrNull();
    if (key == null) {
      throw InvalidKeyIdException('Signed pre key not found: $signedPreKeyId');
    }
    return SignedPreKeyRecord.fromSerialized(key.record);
  }

  @override
  Future<List<SignedPreKeyRecord>> loadSignedPreKeys() async {
    final keys = await _db.select(_db.signedPreKeys).get();
    return keys
        .map((k) => SignedPreKeyRecord.fromSerialized(k.record))
        .toList();
  }

  @override
  Future<void> removeSignedPreKey(int signedPreKeyId) async {
    await (_db.delete(
      _db.signedPreKeys,
    )..where((k) => k.id.equals(signedPreKeyId))).go();
  }

  @override
  Future<void> storeSignedPreKey(
    int signedPreKeyId,
    SignedPreKeyRecord record,
  ) async {
    await _db
        .into(_db.signedPreKeys)
        .insertOnConflictUpdate(
          SignedPreKeysCompanion(
            id: Value(signedPreKeyId),
            record: Value(record.serialize()),
          ),
        );
  }
}

class DriftIdentityKeyStore extends IdentityKeyStore {
  final AppDatabase _db;
  DriftIdentityKeyStore(this._db);

  static const int _singleRowId = 1;

  @override
  Future<IdentityKey?> getIdentity(SignalProtocolAddress address) async {
    final identity =
        await (_db.select(_db.identities)..where(
              (i) =>
                  i.name.equals(address.getName()) &
                  i.deviceId.equals(address.getDeviceId()),
            ))
            .getSingleOrNull();
    if (identity == null) {
      return null;
    }
    // REVIEW
    return IdentityKey.fromBytes(identity.identityKey, 0);
  }

  @override
  Future<IdentityKeyPair?> getIdentityKeyPairOrNull() async {
    final identity = await (_db.select(
      _db.localIdentity,
    )..where((i) => i.id.equals(_singleRowId))).getSingleOrNull();
    if (identity == null) {
      return null;
    }
    return IdentityKeyPair.fromSerialized(identity.identityKeyPair);
  }

  @override
  Future<int> getLocalRegistrationId() async {
    final identity = await (_db.select(
      _db.localIdentity,
    )..where((i) => i.id.equals(_singleRowId))).getSingleOrNull();
    if (identity == null) {
      // This should not happen if the user is registered
      return 0;
    }
    return identity.registrationId;
  }

  @override
  Future<bool> isTrustedIdentity(
    SignalProtocolAddress address,
    IdentityKey? identityKey,
    Direction direction,
  ) async {
    final identity =
        await (_db.select(_db.identities)..where(
              (i) =>
                  i.name.equals(address.getName()) &
                  i.deviceId.equals(address.getDeviceId()),
            ))
            .getSingleOrNull();

    if (identity == null) {
      return true;
    }
    return identity.trusted &&
        (identityKey == null ||
            IdentityKey.fromBytes(identity.identityKey, 0) == identityKey);
  }

  @override
  Future<bool> saveIdentity(
    SignalProtocolAddress address,
    IdentityKey? identityKey,
  ) async {
    if (identityKey == null) {
      return false;
    }
    final existing = await getIdentity(address);

    if (existing == null) {
      await _db
          .into(_db.identities)
          .insert(
            IdentitiesCompanion(
              name: Value(address.getName()),
              deviceId: Value(address.getDeviceId()),
              identityKey: Value(identityKey.serialize()),
            ),
          );
      return true;
    } else {
      if (existing != identityKey) {
        await (_db.update(_db.identities)..where(
              (i) =>
                  i.name.equals(address.getName()) &
                  i.deviceId.equals(address.getDeviceId()),
            ))
            .write(
              IdentitiesCompanion(
                identityKey: Value(identityKey.serialize()),
                trusted: const Value(false),
              ),
            );
      }
      return false;
    }
  }

  @override
  Future<void> storeIdentityKeyPair(
    IdentityKeyPair identityKeyPair,
    int localRegistrationId,
  ) async {
    await _db
        .into(_db.localIdentity)
        .insertOnConflictUpdate(
          LocalIdentityCompanion(
            id: const Value(_singleRowId),
            registrationId: Value(localRegistrationId),
            identityKeyPair: Value(identityKeyPair.serialize()),
          ),
        );
  }
}

class DriftPreKeyStore extends PreKeyStore {
  final AppDatabase _db;
  DriftPreKeyStore(this._db);

  @override
  Future<bool> containsPreKey(int preKeyId) async {
    final key = await (_db.select(
      _db.preKeys,
    )..where((k) => k.keyId.equals(preKeyId))).getSingleOrNull();
    return key != null;
  }

  @override
  Future<PreKeyRecord> loadPreKey(int preKeyId) async {
    final key = await (_db.select(
      _db.preKeys,
    )..where((k) => k.keyId.equals(preKeyId))).getSingleOrNull();
    if (key == null) {
      throw InvalidKeyIdException('Pre key not found: $preKeyId');
    }
    return PreKeyRecord.fromBuffer(key.record);
  }

  @override
  Future<void> removePreKey(int preKeyId) async {
    await (_db.delete(
      _db.preKeys,
    )..where((k) => k.keyId.equals(preKeyId))).go();
  }

  @override
  Future<void> storePreKey(int preKeyId, PreKeyRecord record) async {
    await _db
        .into(_db.preKeys)
        .insertOnConflictUpdate(
          PreKeysCompanion(
            keyId: Value(preKeyId),
            record: Value(record.serialize()),
          ),
        );
  }
}

class DriftStorage extends TokenStorage {
  final AppDatabase _db;

  DriftStorage(this._db)
    : super(
        preKeyStore: DriftPreKeyStore(_db),
        authTokenStore: DriftAuthStore(_db),
        sessionStore: DriftSessionStore(_db),
        signedPreKeyStore: DriftSignedPreKeyStore(_db),
        identityKeyStore: DriftIdentityKeyStore(_db),
      );

  @override
  Future<void> clear() async {
    await _db.delete(_db.authSessions).go();
    await _db.delete(_db.preKeys).go();
    await _db.delete(_db.signedPreKeys).go();
    await _db.delete(_db.identities).go();
    await _db.delete(_db.localIdentity).go();
  }
}
