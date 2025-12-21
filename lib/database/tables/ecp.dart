import 'package:drift/drift.dart';

class Sessions extends Table {
  TextColumn get name => text()();
  IntColumn get deviceId => integer()();
  BlobColumn get record => blob()();

  @override
  Set<Column> get primaryKey => {deviceId};
}

class PreKeys extends Table {
  IntColumn get keyId => integer()();
  BlobColumn get record => blob()();

  @override
  Set<Column> get primaryKey => {keyId};
}

class SignedPreKeys extends Table {
  IntColumn get id => integer()();
  BlobColumn get record => blob()();

  @override
  Set<Column> get primaryKey => {id};
}

class Identities extends Table {
  TextColumn get name => text()();
  IntColumn get deviceId => integer()();
  BlobColumn get identityKey => blob()();
  BoolColumn get trusted => boolean().withDefault(const Constant(true))();

  @override
  Set<Column> get primaryKey => {deviceId};
}

class LocalIdentity extends Table {
  IntColumn get id => integer().withDefault(const Constant(1))();
  BlobColumn get identityKeyPair => blob()();
  IntColumn get registrationId => integer()();

  @override
  Set<Column> get primaryKey => {id};
}
