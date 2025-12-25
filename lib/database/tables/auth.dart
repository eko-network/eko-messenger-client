import 'package:drift/drift.dart';

class Users extends Table {
  TextColumn get id => text()();

  @override
  Set<Column> get primaryKey => {id};
}

class UserDevices extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get userId => text().references(Users, #id)();
  IntColumn get deviceId => integer()();
}

class AuthInfoTable extends Table {
  IntColumn get id => integer().withDefault(const Constant(1))();
  IntColumn get did => integer()();
  TextColumn get accessToken => text()();
  TextColumn get refreshToken => text()();
  DateTimeColumn get expiresAt => dateTime()();
  TextColumn get actorJson => text()(); // Store actor as JSON
  TextColumn get serverUrl => text()();

  @override
  Set<Column> get primaryKey => {id};
}
