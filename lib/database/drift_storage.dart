import 'package:drift/drift.dart';
import 'package:ecp/ecp.dart';
import 'database.dart';

class DriftStorage extends TokenStorage {
  final AppDatabase _db;

  static const int _singleRowId = 1;

  DriftStorage(this._db);

  Future<AuthSession?> _getSession() async {
    return (_db.select(
      _db.authSessions,
    )..where((t) => t.id.equals(_singleRowId))).getSingleOrNull();
  }

  @override
  Future<String?> getAccessToken() async {
    final session = await _getSession();
    return session?.accessToken;
  }

  @override
  Future<String?> getRefreshToken() async {
    final session = await _getSession();
    return session?.refreshToken;
  }

  @override
  Future<DateTime?> getExpiresAt() async {
    final session = await _getSession();
    return session?.expiresAt;
  }

  @override
  Future<String?> getServerUrl() async {
    final session = await _getSession();
    return session?.serverUrl;
  }

  @override
  Future<void> saveAuthTokens({
    required String accessToken,
    required String refreshToken,
    required String serverUrl,
    DateTime? expiresAt,
  }) async {
    // insertOnConflictUpdate to handle both "create" and "update"
    await _db
        .into(_db.authSessions)
        .insertOnConflictUpdate(
          AuthSessionsCompanion(
            id: const Value(_singleRowId), // Force ID to 1
            accessToken: Value(accessToken),
            refreshToken: Value(refreshToken),
            serverUrl: Value(serverUrl),
            expiresAt: Value(expiresAt),
          ),
        );
  }

  @override
  Future<void> clearTokens() async {
    await (_db.delete(
      _db.authSessions,
    )..where((t) => t.id.equals(_singleRowId))).go();
  }
  // --- SignalProtocolStore methods (Unimplemented for now) ---

  @override
  Future<bool> containsPreKey(int preKeyId) {
    throw UnimplementedError();
  }

  @override
  Future<bool> containsSession(SignalProtocolAddress address) {
    throw UnimplementedError();
  }

  @override
  Future<bool> containsSignedPreKey(int signedPreKeyId) {
    throw UnimplementedError();
  }

  @override
  Future<void> deleteAllSessions(String name) {
    throw UnimplementedError();
  }

  @override
  Future<void> deleteSession(SignalProtocolAddress address) {
    throw UnimplementedError();
  }

  @override
  Future<IdentityKey?> getIdentity(SignalProtocolAddress address) {
    throw UnimplementedError();
  }

  @override
  Future<IdentityKeyPair> getIdentityKeyPair() {
    throw UnimplementedError();
  }

  @override
  Future<int> getLocalRegistrationId() {
    throw UnimplementedError();
  }

  @override
  Future<PreKeyRecord> loadPreKey(int preKeyId) {
    throw UnimplementedError();
  }

  @override
  Future<SessionRecord> loadSession(SignalProtocolAddress address) {
    throw UnimplementedError();
  }

  @override
  Future<SignedPreKeyRecord> loadSignedPreKey(int signedPreKeyId) {
    throw UnimplementedError();
  }

  @override
  Future<List<SignedPreKeyRecord>> loadSignedPreKeys() {
    throw UnimplementedError();
  }

  @override
  Future<void> removePreKey(int preKeyId) {
    throw UnimplementedError();
  }

  @override
  Future<void> removeSignedPreKey(int signedPreKeyId) {
    throw UnimplementedError();
  }

  @override
  Future<bool> saveIdentity(
    SignalProtocolAddress address,
    IdentityKey? identityKey,
  ) {
    throw UnimplementedError();
  }

  @override
  Future<void> storePreKey(int preKeyId, PreKeyRecord record) {
    throw UnimplementedError();
  }

  @override
  Future<void> storeSession(
    SignalProtocolAddress address,
    SessionRecord record,
  ) {
    throw UnimplementedError();
  }

  @override
  Future<void> storeSignedPreKey(
    int signedPreKeyId,
    SignedPreKeyRecord record,
  ) {
    throw UnimplementedError();
  }

  @override
  Future<List<int>> getSubDeviceSessions(String name) {
    throw UnimplementedError();
  }

  @override
  Future<bool> isTrustedIdentity(
    SignalProtocolAddress address,
    IdentityKey? identityKey,
    Direction direction,
  ) {
    throw UnimplementedError();
  }
}
