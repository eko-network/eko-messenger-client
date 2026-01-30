import 'package:ecp/ecp.dart';
import 'package:eko_messenger/database/daos/conversations_dao.dart';
import 'package:eko_messenger/database/database.dart';
import 'package:eko_messenger/database/type_converters.dart';
import 'package:eko_messenger/providers/auth.dart';
import 'package:eko_messenger/providers/database.dart';
import 'package:eko_messenger/providers/ecp.dart';
import 'package:eko_messenger/utils/constants.dart' as c;
import 'package:eko_messenger/widgets/message.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:uuid/uuid.dart';

extension SafeLookup<T> on List<T> {
  T? getOrNull(int index) {
    if (index < 0 || index >= length) return null;
    return this[index];
  }
}

class ChatView extends ConsumerStatefulWidget {
  final ConversationWithContact conversation;
  final VoidCallback? onBack;

  const ChatView({super.key, required this.conversation, this.onBack});

  @override
  ConsumerState<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends ConsumerState<ChatView> {
  final TextEditingController _messageController = TextEditingController();
  final _uuid = Uuid();
  Stream<List<Message>>? _messagesStream;
  Uri? _lastActorId;
  Uri? _lastContactId;
  AppDatabase? _lastDb;

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _sendMessage() async {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    final db = ref.read(appDatabaseProvider);
    final authInfo = ref.read(authProvider).info;
    if (authInfo == null) return;
    final activity = Create(
      base: ActivityBase(id: _uuid.v4obj(), to: widget.conversation.contact.id),
      object: Note(
        content: text,
        base: ObjectBase(id: _uuid.v4obj()),
      ),
    );

    // Insert message to database with 'sending' status
    await db.messagesDao.insertNewMessage(
      Message(
        id: activity.object.base.id,
        to: widget.conversation.contact.id,
        from: authInfo.actor.id,
        content: text,
        time: DateTime.now(),
        status: MessageStatus.sending,
      ),
    );

    _messageController.clear();
    try {
      await ref
          .read(ecpProvider)
          .sendMessage(person: widget.conversation.contact, message: activity);
      await db.messagesDao.updateMessageStatus(
        activity.object.base.id,
        MessageStatus.sent,
      );
    } catch (e) {
      //TODO
      debugPrint('Failed to send message: $e');
    }
  }

  MessagePosition _determinePosition(
    DateTime? prev,
    DateTime me,
    DateTime? next,
  ) {
    final tolerance = Duration(minutes: 1);

    bool hasPrev = prev != null && me.difference(prev).abs() <= tolerance;

    bool hasNext = next != null && next.difference(me).abs() <= tolerance;

    if (hasPrev && hasNext) {
      return MessagePosition.middle;
    } else if (hasPrev) {
      return MessagePosition.bottom;
    } else if (hasNext) {
      return MessagePosition.top;
    } else {
      return MessagePosition.single;
    }
  }

  @override
  Widget build(BuildContext context) {
    final db = ref.watch(appDatabaseProvider);
    final authInfo = ref.watch(authProvider).info;

    if (authInfo == null) {
      return Scaffold(
        appBar: AppBar(
          leading: widget.onBack != null
              ? IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: widget.onBack,
                )
              : null,
          title: Text(widget.conversation.contact.preferredUsername),
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    final actorId = authInfo.actor.id;
    final contactId = widget.conversation.contact.id;

    if (_messagesStream == null ||
        _lastActorId != actorId ||
        _lastContactId != contactId ||
        _lastDb != db) {
      _lastActorId = actorId;
      _lastContactId = contactId;
      _lastDb = db;
      _messagesStream = db.messagesDao.watchMessagesForConversation(
        contactId,
        actorId,
      );
    }

    return Scaffold(
      appBar: AppBar(
        leading: widget.onBack != null
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: widget.onBack,
              )
            : null,
        title: Row(
          children: [
            CircleAvatar(
              radius: 16,
              child: Text(
                widget.conversation.contact.preferredUsername[0],
                style: const TextStyle(fontSize: 14),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                widget.conversation.contact.preferredUsername,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<Message>>(
              stream: _messagesStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(
                    child: Text(
                      'No messages yet. Start the conversation!',
                      style: TextStyle(color: Colors.grey[600], fontSize: 16),
                    ),
                  );
                }

                final messages = snapshot.data!;
                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  reverse: true,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final int chronoIndex = messages.length - 1 - index;
                    final message = messages[chronoIndex];
                    final isReceived = message.from != authInfo.actor.id;

                    final prevMsg = messages.getOrNull(chronoIndex - 1);
                    final nextMsg = messages.getOrNull(chronoIndex + 1);

                    // These are only for grouping
                    final DateTime? prevTime = (prevMsg?.from == message.from)
                        ? prevMsg?.time
                        : null;
                    final DateTime? nextTime = (nextMsg?.from == message.from)
                        ? nextMsg?.time
                        : null;

                    bool isFirstOfDate = false;

                    if (prevMsg == null) {
                      isFirstOfDate = true;
                    } else {
                      final d1 = message.time;
                      final d2 = prevMsg.time;
                      isFirstOfDate =
                          d1.year != d2.year ||
                          d1.month != d2.month ||
                          d1.day != d2.day;
                    }

                    final messageWidget = MessageWidget(
                      isReceived: isReceived,
                      message: message,
                      position: _determinePosition(
                        prevTime,
                        message.time,
                        nextTime,
                      ),
                    );

                    if (isFirstOfDate) {
                      return Column(
                        children: [
                          DateChip(time: message.time),
                          messageWidget,
                        ],
                      );
                    }
                    return messageWidget;
                  },
                );
              },
            ),
          ),
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  Expanded(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxHeight:
                            12 * 24.0, // 12 lines * approximate line height
                      ),
                      child: CallbackShortcuts(
                        bindings: {
                          const SingleActivator(LogicalKeyboardKey.enter):
                              _sendMessage,
                        },
                        child: TextField(
                          controller: _messageController,
                          maxLines: null,
                          minLines: 1,
                          textCapitalization: TextCapitalization.sentences,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                            hintText: 'Type a message...',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(24),
                              borderSide: BorderSide.none,
                            ),
                            fillColor: ShadTheme.of(
                              context,
                            ).colorScheme.custom[c.grayMessageColorKey],
                            filled: true,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  CircleAvatar(
                    backgroundColor: ShadTheme.of(
                      context,
                    ).colorScheme.custom[c.primaryColorKey],
                    child: IconButton(
                      icon: const Icon(
                        LucideIcons.send,
                        color: Colors.white,
                        size: 20,
                      ),
                      onPressed: _sendMessage,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
