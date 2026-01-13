import 'package:drift/drift.dart';
import 'package:ecp/ecp.dart';

import '../../database.dart';

class DriftCapabilitiesStore extends CapabilitiesStore {
  final AppDatabase _db;
  DriftCapabilitiesStore(this._db);

  static const int _singleRowId = 1;

  @override
  Future<CapabilitiesWithTime?> getCapabilities() async {
    final capabilites = await (_db.select(
      _db.capabilities,
    )..where((i) => i.id.equals(_singleRowId))).getSingleOrNull();
    if (capabilites == null) return null;
    return (capabilites: capabilites.capabilities, timestamp: capabilites.time);
  }

  @override
  Future<void> saveCapabilities(Map<String, dynamic> capabilites) async {
    await _db
        .into(_db.capabilities)
        .insert(CapabilitiesCompanion(capabilities: Value(capabilites)));
  }
}
