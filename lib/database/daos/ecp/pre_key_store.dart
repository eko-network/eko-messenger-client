import 'package:drift/drift.dart';
import 'package:ecp/ecp.dart';

import '../../database.dart';

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
