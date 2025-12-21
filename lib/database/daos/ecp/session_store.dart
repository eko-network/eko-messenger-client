import 'package:drift/drift.dart';
import 'package:ecp/ecp.dart';

import '../../database.dart';

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
