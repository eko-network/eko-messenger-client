import 'package:ecp/ecp.dart';
import 'package:eko_messenger/database/daos/ecp/capabilities_store.dart';

import '../../database.dart';
import 'pre_key_store.dart';
import 'session_store.dart';
import 'signed_pre_key_store.dart';
import 'identity_key_store.dart';
import 'user_store.dart';

class DriftStorage implements Storage {
  final AppDatabase _db;

  @override
  final PreKeyStore preKeyStore;

  @override
  final SessionStore sessionStore;

  @override
  final SignedPreKeyStore signedPreKeyStore;

  @override
  final IdentityKeyStore identityKeyStore;

  @override
  final UserStore userStore;

  @override
  final CapabilitiesStore capabilitiesStore;

  DriftStorage(this._db)
    : preKeyStore = DriftPreKeyStore(_db),
      sessionStore = DriftSessionStore(_db),
      signedPreKeyStore = DriftSignedPreKeyStore(_db),
      identityKeyStore = DriftIdentityKeyStore(_db),
      userStore = DriftUserStore(_db),
      capabilitiesStore = DriftCapabilitiesStore(_db);

  @override
  Future<void> clear() async {
    await _db.delete(_db.capabilities).go();
    await _db.delete(_db.preKeys).go();
    await _db.delete(_db.signedPreKeys).go();
    await _db.delete(_db.identities).go();
    await _db.delete(_db.localIdentity).go();
    await _db.delete(_db.sessions).go();
    // Delete child table before parent table to avoid foreign key constraint
    await _db.delete(_db.userDevices).go();
    await _db.delete(_db.users).go();
  }
}
