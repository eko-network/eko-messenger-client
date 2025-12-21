import 'package:drift/drift.dart';
import 'package:ecp/ecp.dart';

import '../../database.dart';

class DriftUserStore extends UserStore {
  final AppDatabase _db;

  DriftUserStore(this._db);

  @override
  Future<List<int>?> getUser(Uri id) async {
    final result = await (_db.select(
      _db.userDevices,
    )..where((u) => u.userId.equals(id.toString()))).get();
    if (result.isEmpty) {
      return null;
    }
    return result.map((d) => d.deviceId).toList();
  }

  @override
  Future<void> saveUser(Uri id, int did) async {
    await _db
        .into(_db.users)
        .insertOnConflictUpdate(UsersCompanion(id: Value(id.toString())));
    await _db
        .into(_db.userDevices)
        .insertOnConflictUpdate(
          UserDevicesCompanion(
            userId: Value(id.toString()),
            deviceId: Value(did),
          ),
        );
  }
}
