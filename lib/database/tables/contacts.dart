import 'package:drift/drift.dart';
import 'package:ecp/ecp.dart';
import 'package:eko_messenger/database/type_converters.dart';

@UseRowClass(Person)
class Contacts extends Table {
  TextColumn get id => text().map(const UriTypeConverter())();
  TextColumn get preferredUsername => text()();
  TextColumn get inbox => text().map(const UriTypeConverter())();
  TextColumn get outbox => text().map(const UriTypeConverter())();
  TextColumn get devices => text().map(const UriTypeConverter())();

  @override
  Set<Column> get primaryKey => {id};
}
