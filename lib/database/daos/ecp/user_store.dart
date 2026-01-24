import 'package:drift/drift.dart';
import 'package:ecp/ecp.dart';

import '../../database.dart';

class DriftUserStore extends UserStore {
  final AppDatabase _db;

  DriftUserStore(this._db);

  @override
  Future<Map<Uri, int>?> getUser(Uri id) async {
    final result = await (_db.select(
      _db.userDevices,
    )..where((u) => u.userId.equals(id.toString()))).get();
    if (result.isEmpty) {
      return null;
    }
    return {for (final v in result) v.deviceId: v.id};
  }

  @override
  Future<int> saveDevice(Uri id, Uri did) async {
    await _db
        .into(_db.users)
        .insertOnConflictUpdate(UsersCompanion(id: Value(id)));
    return await _db
        .into(_db.userDevices)
        .insertOnConflictUpdate(
          UserDevicesCompanion(userId: Value(id), deviceId: Value(did)),
        );
  }

  @override
  Future<int?> removeDevice(Uri did) async {
    final ret = await getDevice(did);
    if (ret != null) {
      await (_db.delete(_db.userDevices)..where((u) => u.id.equals(ret))).go();
    }
    return ret;
  }

  @override
  Future<int?> getDevice(Uri did) async {
    final query = _db.select(_db.userDevices)
      ..where((u) => u.deviceId.equals(did.toString()));

    return (await query.getSingleOrNull())?.id;
  }
}
