import 'package:drift/drift.dart';
import 'package:eko_messenger/database/type_converters.dart';

class Users extends Table {
  TextColumn get id => text().map(const UriTypeConverter())();

  @override
  Set<Column> get primaryKey => {id};
}

@TableIndex(name: 'idx_device_id', columns: {#deviceId})
class UserDevices extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get userId =>
      text().references(Users, #id).map(const UriTypeConverter())();
  TextColumn get deviceId => text().unique().map(const UriTypeConverter())();
}

class AuthInfoTable extends Table {
  IntColumn get id => integer().withDefault(const Constant(1))();
  TextColumn get did => text().map(const UriTypeConverter())();
  TextColumn get accessToken => text()();
  TextColumn get refreshToken => text()();
  DateTimeColumn get expiresAt => dateTime()();
  TextColumn get actorJson => text()(); // Store actor as JSON
  TextColumn get serverUrl => text().map(const UriTypeConverter())();

  @override
  Set<Column> get primaryKey => {id};
}
