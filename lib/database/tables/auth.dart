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
