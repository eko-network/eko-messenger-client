import 'package:drift/drift.dart';
import 'package:eko_messenger/database/tables/contacts.dart';
import 'package:eko_messenger/database/type_converters.dart';

class Conversations extends Table {
  TextColumn get participant => text()
      .map(const UriTypeConverter())
      .references(Contacts, #id, onDelete: KeyAction.cascade)();
  IntColumn get id => integer()();
  TextColumn get lastMessageContent => text().nullable()();
  DateTimeColumn get lastMessageTime =>
      dateTime().withDefault(currentDateAndTime)();
  @override
  Set<Column> get primaryKey => {id};
}
