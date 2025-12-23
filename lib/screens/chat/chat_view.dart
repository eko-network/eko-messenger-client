import 'package:ecp/ecp.dart';
import 'package:eko_messanger/database/daos/conversations_dao.dart';
import 'package:eko_messanger/database/database.dart';
import 'package:eko_messanger/database/type_converters.dart';
import 'package:eko_messanger/providers/auth.dart';
import 'package:eko_messanger/providers/database.dart';
import 'package:eko_messanger/providers/ecp.dart';
import 'package:eko_messanger/utils/constants.dart' as c;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:uuid/uuid.dart';

class ChatView extends ConsumerStatefulWidget {
  final ConversationWithContact conversation;
  final VoidCallback? onBack;

  const ChatView({super.key, required this.conversation, this.onBack});

  @override
  ConsumerState<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends ConsumerState<ChatView> {
  final TextEditingController _messageController = TextEditingController();

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
    final activity = Create.note(content: text);

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
          .read(ecpProvider)!
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

  @override
  Widget build(BuildContext context) {
    final db = ref.watch(appDatabaseProvider);
    final authInfo = ref.watch(authProvider).info;

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
            Text(widget.conversation.contact.preferredUsername),
          ],
        ),
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<Message>>(
              stream: db.messagesDao.watchMessagesForConversation(
                widget.conversation.contact.id,
                authInfo!.actor.id,
              ),
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
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    final isReceived = message.from != authInfo.actor.id;
                    return _buildMessage(
                      // FIXME
                      message.content!,
                      isReceived,
                      context,
                      message.status,
                    );
                  },
                );
              },
            ),
          ),
          Padding(
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
                        keyboardType: TextInputType.multiline,
                        // onSubmitted: (_) => _sendMessage(),
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
        ],
      ),
    );
  }

  Widget _buildMessage(
    String text,
    bool isReceived,
    BuildContext context,
    MessageStatus status,
  ) {
    return Align(
      alignment: isReceived ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: ShadTheme.of(context)
              .colorScheme
              .custom[isReceived ? c.grayMessageColorKey : c.primaryColorKey],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Text(text, style: const TextStyle(color: Colors.white)),
            ),
            if (!isReceived) ...[
              const SizedBox(width: 8),
              Icon(
                status == MessageStatus.sending
                    ? LucideIcons.clock
                    : LucideIcons.check,
                size: 14,
                color: Colors.white70,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
