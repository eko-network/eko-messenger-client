import 'package:drift/drift.dart';
import 'package:ecp/ecp.dart';

import '../../database.dart';

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
