import 'package:drift/drift.dart';
import 'package:eko_messanger/database/type_converters.dart';
import 'package:uuid/uuid_value.dart';

import '../database.dart';
import '../tables/messages.dart';

part '../../generated/database/daos/messages_dao.g.dart';

@DriftAccessor(tables: [Messages])
class MessagesDao extends DatabaseAccessor<AppDatabase>
    with _$MessagesDaoMixin {
  MessagesDao(super.db);

  Future<void> insertNewMessage(Message message) async {
    await into(messages).insert(message);
  }

  // Future<void> insertMessageWithStatus({
  //   required UuidValue id,
  //   required String to,
  //   required String from,
  //   required String content,
  //   String? inReplyTo,
  //   required DateTime time,
  //   required MessageStatus status,
  // }) async {
  //   await into(messages).insert(
  //     MessagesCompanion.insert(
  //       id: id.toString(),
  //       to: to,
  //       from: from,
  //       content: content,
  //       inReplyTo: Value(inReplyTo),
  //       time: time,
  //       status: Value(status),
  //     ),
  //   );
  // }

  Future<void> updateMessageStatus(
    UuidValue messageId,
    MessageStatus status,
  ) async {
    await (update(messages)
          ..where((tbl) => tbl.id.equals(messageId.toString())))
        .write(MessagesCompanion(status: Value(status)));
  }

  Future<List<Message>> getMessagesForUser(
    String userId,
    int pageSize,
    DateTime startAfter,
  ) {
    return (select(messages)
          ..orderBy([(u) => OrderingTerm.desc(u.time)])
          ..where((tbl) => tbl.to.equals(userId) | tbl.from.equals(userId))
          ..where((tbl) => tbl.time.isSmallerThan(Constant(startAfter)))
          ..limit(pageSize))
        .get();
  }

  Stream<List<Message>> watchMessagesForUser(String userId) {
    return (select(messages)
          ..where((tbl) => tbl.to.equals(userId) | tbl.from.equals(userId))
          ..orderBy([(u) => OrderingTerm.asc(u.time)]))
        .watch();
  }

  Stream<List<Message>> watchMessagesForConversation(Uri contactId, Uri myId) {
    return (select(messages)
          ..where(
            (tbl) =>
                (tbl.to.equals('$contactId') & tbl.from.equals('$myId')) |
                (tbl.from.equals('$contactId') & tbl.to.equals('$myId')),
          )
          ..orderBy([(u) => OrderingTerm.asc(u.time)]))
        .watch();
  }
}
