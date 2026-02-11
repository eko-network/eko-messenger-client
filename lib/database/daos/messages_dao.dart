import 'package:drift/drift.dart';
import 'package:ecp/ecp.dart';
import 'package:eko_messenger/database/tables/conversations.dart';
import 'package:eko_messenger/database/type_converters.dart';
import 'package:uuid/uuid_value.dart';

import '../database.dart';
import '../tables/messages.dart';

part '../../generated/database/daos/messages_dao.g.dart';

@DriftAccessor(tables: [Messages, Conversations])
class MessagesDao extends DatabaseAccessor<AppDatabase>
    with _$MessagesDaoMixin {
  MessagesDao(super.db);

  Future<void> insertNewMessage(
    ActivityPubObject message,
    MessageStatus status,
  ) async {
    //FIXME
    // await into(messages).insert(message);
    // await (update(conversations)
    //       ..where((tbl) => tbl.participant.equals(message.to.value.toString())))
    //     .write(
    //       ConversationsCompanion(
    //         lastMessageTime: Value(message.time.value),
    //         // This needs to change when images are added
    //         // maybe take a substring too?
    //         lastMessageContent: Value(
    //           "${message.content.value?.replaceAll("\n", " ")}",
    //         ),
    //       ),
    //     );
  }

  Future<void> markMessageSent(UuidValue messageId, Uri envelopeId) async {
    await (update(
      messages,
    )..where((tbl) => tbl.id.equals(messageId.toString()))).write(
      MessagesCompanion(
        status: Value(MessageStatus.sent),
        envelopeId: Value(envelopeId),
      ),
    );
  }

  Future<void> updateMessageStatusFromId(
    UuidValue messageId,
    MessageStatus status,
  ) async {
    await (update(messages)
          ..where((tbl) => tbl.id.equals(messageId.toString())))
        .write(MessagesCompanion(status: Value(status)));
  }

  Future<void> updateMessageStatusFromEnvelope(
    Uri envelopeId,
    MessageStatus status,
  ) async {
    await (update(messages)
          ..where((tbl) => tbl.envelopeId.equals(envelopeId.toString())))
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
