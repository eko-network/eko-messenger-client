import 'package:drift/drift.dart';
import 'package:eko_messanger/database/tables/contacts.dart';
import 'package:eko_messanger/database/type_converters.dart';

class Conversations extends Table {
  TextColumn get participant =>
      text().map(const UriTypeConverter()).references(Contacts, #id)();
  IntColumn get id => integer().autoIncrement()();
  @override
  Set<Column> get primaryKey => {id};
}
