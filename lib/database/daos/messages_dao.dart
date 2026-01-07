import 'package:drift/drift.dart';
import 'package:ecp/ecp.dart';
import 'package:eko_messanger/database/type_converters.dart';
import 'package:flutter/foundation.dart';
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

  Future<void> handleActivity(
    ActivityWithRecipients activityWithRecipiants,
  ) async {
    final activity = activityWithRecipiants.activity;
    switch (activity) {
      case TransientActivity():
        {
          debugPrint("Not Implemented: transient activity");
        }
      case StableActivity():
        {
          if (activity is Create) {
            // TODO might not be a note
            final message = activity.object as Note;
            await insertNewMessage(
              Message(
                id: message.base.id,
                to: activityWithRecipiants.to.first,
                from: activityWithRecipiants.from,
                time: DateTime.now(),
                content: message.content,
                status: MessageStatus.delivered,
                inReplyTo: message.base.inReplyTo,
              ),
            );
          } else {
            debugPrint("Not Implemented: Non-Create");
          }
        }
    }
  }

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
