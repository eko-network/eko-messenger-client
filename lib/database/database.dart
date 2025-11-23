import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:sqlite3/sqlite3.dart';

part 'database.g.dart';

@DataClassName('AuthSession')
class AuthSessions extends Table {
  IntColumn get id => integer().withDefault(const Constant(1))();
  TextColumn get accessToken => text()();
  TextColumn get refreshToken => text()();
  TextColumn get serverUrl => text()();
  DateTimeColumn get expiresAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

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

@DriftDatabase(
  tables: [
    AuthSessions,
    Sessions,
    PreKeys,
    SignedPreKeys,
    Identities,
    LocalIdentity,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {},
      beforeOpen: (details) async {
        await customStatement('PRAGMA foreign_keys = ON');
      },
    );
  }
}

Uint8List _generateRandomBytes(int length) {
  final Random random = Random.secure();
  final Uint8List bytes = Uint8List(length);
  for (int i = 0; i < length; i++) {
    bytes[i] = random.nextInt(256);
  }
  return bytes;
}

Future<String> _getDbPassword() async {
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  final key = "eko-db-key";
  final stored = await storage.read(key: key);
  if (stored != null) {
    return stored;
  }

  final password = base64Encode(_generateRandomBytes(32));
  await storage.write(key: key, value: password);
  return password;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final password = await _getDbPassword();
    final dbFolder = await getApplicationSupportDirectory();
    final file = File(p.join(dbFolder.path, 'eko.db'));
    final rawDb = sqlite3.open(file.path);
    final result = rawDb.select('PRAGMA cipher_version;');
    if (result.isEmpty) {
      throw StateError('SQLCipher library is not available!');
    }
    rawDb.execute("PRAGMA key = '$password';");
    return NativeDatabase.opened(rawDb);
  });
}
