import 'package:drift/drift.dart';
import 'package:ecp/ecp.dart';

import '../../database.dart';

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
