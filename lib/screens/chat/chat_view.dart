import 'dart:io';
import 'package:drift/drift.dart' show Value;
import 'package:ecp/ecp.dart' as ecp;
import 'package:eko_messenger/database/daos/conversations_dao.dart';
import 'package:eko_messenger/database/database.dart';
import 'package:eko_messenger/database/models/message_with_attachments.dart';
import 'package:eko_messenger/database/type_converters.dart';
import 'package:eko_messenger/providers/auth.dart';
import 'package:eko_messenger/providers/database.dart';
import 'package:eko_messenger/providers/ecp.dart';
import 'package:eko_messenger/utils/constants.dart' as c;
import 'package:eko_messenger/utils/emoji_text_style.dart';
import 'package:eko_messenger/widgets/avatar.dart';
import 'package:eko_messenger/widgets/media_picker.dart';
import 'package:eko_messenger/widgets/message.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:klipy_dart/klipy_dart.dart';
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
  final ShadPopoverController _popoverController = ShadPopoverController();
  final FocusNode _focusNode = FocusNode();
  final _uuid = Uuid();
  Stream<List<MessageWithAttachments>>? _messagesStream;
  Uri? _lastActorId;
  Uri? _lastContactId;
  AppDatabase? _lastDb;
  bool _showMediaPicker = false;
  Map<Uri, ecp.Image> _selectedGifs = {};

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        setState(() {
          _showMediaPicker = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _messageController.dispose();
    _popoverController.dispose();
    super.dispose();
  }

  void _onGifSelected(KlipyResultObject gif) {
    final obj = gif.media.tinyGif ?? gif.media.gif;
    if (obj == null) {
      return;
    }
    setState(() {
      final url = Uri.parse(obj.url);
      _selectedGifs[url] = ecp.Image(
        base: ecp.ObjectBase(id: _uuid.v4obj()),
        url: url,
        height: obj.dimensions.height.round(),
        width: obj.dimensions.width.round(),
        mediaType: "image/gif",
        name: gif.title,
      );
    });
  }

  Future<void> _sendMessage() async {
    final text = _messageController.text.trim();
    final gifs = _selectedGifs.values;
    if (text.isEmpty && gifs.isEmpty) return;
    _messageController.clear();
    setState(() {
      _selectedGifs = {};
    });

    if (text.isEmpty && gifs.length == 1) {
      await _dispatchMessage(gifs.first);
    }
    await _dispatchMessage(
      ecp.Note(
        content: text,
        base: ecp.ObjectBase(id: _uuid.v4obj()),
        attachments: gifs.isEmpty ? null : gifs.toList(),
      ),
    );
  }

  Future<void> _dispatchMessage(ecp.ActivityPubObject object) async {
    final db = ref.read(appDatabaseProvider);
    final authInfo = ref.read(authProvider).info;
    if (authInfo == null) return;
    final activity = ecp.Create(
      base: ecp.ActivityBase(
        id: _uuid.v4obj(),
        to: widget.conversation.contact.id,
      ),
      object: object,
    );

    final from = authInfo.actor.id;
    final to = widget.conversation.contact.id;

    await db.messagesDao.insertNewMessage(
      object,
      MessageStatus.sending,
      from: from,
      to: to,
    );

    try {
      final id = await ref
          .read(ecpProvider)
          .sendMessage(person: widget.conversation.contact, message: activity);
      if (from == to) {
        await db.messagesDao.updateMessageStatusFromId(
          activity.object.base.id,
          MessageStatus.delivered,
        );
      } else if (id != null) {
        await db.messagesDao.markMessageSent(activity.object.base.id, id);
      } else {
        debugPrint('[chat_view] Warning: send did not return id');
        await db.messagesDao.updateMessageStatusFromId(
          activity.object.base.id,
          MessageStatus.sent,
        );
      }
    } catch (e) {
      //TODO
      debugPrint('Failed to send message: $e');
      await db.messagesDao.updateMessageStatusFromId(
        activity.object.base.id,
        MessageStatus.failed,
      );
    }
  }

  Widget _buildInputRow(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: ShadTheme.of(
                context,
              ).colorScheme.custom[c.grayMessageColorKey],
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (_selectedGifs.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 16,
                      right: 16,
                      top: 12,
                      bottom: 4,
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: _selectedGifs.entries.map((entry) {
                          final url = entry.key;
                          return Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: SizedBox(
                                    height: 80,
                                    width: 80,
                                    child: Image.network(
                                      url.toString(),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: IconButton(
                                    padding: EdgeInsets.zero,
                                    constraints: const BoxConstraints(),
                                    onPressed: () {
                                      setState(() {
                                        _selectedGifs.remove(url);
                                      });
                                    },
                                    icon: Container(
                                      padding: const EdgeInsets.all(2),
                                      decoration: const BoxDecoration(
                                        color: Colors.black54,
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        LucideIcons.x,
                                        size: 14,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxHeight: 12 * 24.0, // 12 lines * approximate line height
                  ),
                  child: CallbackShortcuts(
                    bindings: {
                      const SingleActivator(LogicalKeyboardKey.enter): () =>
                          _sendMessage(),
                    },
                    child: TextField(
                      focusNode: _focusNode,
                      style: emojiTextStyle(TextStyle()),
                      controller: _messageController,
                      maxLines: null,
                      minLines: 1,
                      textCapitalization: TextCapitalization.sentences,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        prefixIcon: IconButton(
                          icon: const Icon(LucideIcons.smile, size: 24),
                          onPressed: () {
                            if (Platform.isAndroid || Platform.isIOS) {
                              FocusScope.of(context).unfocus();
                              setState(() {
                                _showMediaPicker = !_showMediaPicker;
                              });
                            } else {
                              _popoverController.toggle();
                            }
                          },
                        ),
                        hintText: 'Type a message...',
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 8),
        CircleAvatar(
          backgroundColor: ShadTheme.of(
            context,
          ).colorScheme.custom[c.primaryColorKey],
          child: IconButton(
            icon: const Icon(LucideIcons.send, color: Colors.white, size: 20),
            onPressed: () => _sendMessage(),
          ),
        ),
      ],
    );
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
      _messagesStream = db.messagesDao
          .watchMessagesWithAttachmentForConversation(contactId, actorId);
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
            Avatar(person: widget.conversation.contact),
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
            child: StreamBuilder<List<MessageWithAttachments>>(
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
                    final message = messages[chronoIndex].message;
                    final isReceived = message.from != authInfo.actor.id;

                    final prevMsg = messages
                        .getOrNull(chronoIndex - 1)
                        ?.message;
                    final nextMsg = messages
                        .getOrNull(chronoIndex + 1)
                        ?.message;

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
                      messageWithAttachments: messages[chronoIndex],
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
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: c.isMobile
                      ? _buildInputRow(context)
                      : ShadPopover(
                          decoration: ShadDecoration(
                            border: ShadBorder.all(color: Colors.transparent),
                          ),
                          controller: _popoverController,
                          anchor: const ShadAnchor(
                            childAlignment: Alignment.bottomLeft,
                            overlayAlignment: Alignment.topLeft,
                            offset: Offset(0, -4),
                          ),
                          popover: (context) => SizedBox(
                            width: 380,
                            height: 450,
                            child: MediaPicker(
                              textController: _messageController,
                              onGifSelected: _onGifSelected,
                            ),
                          ),
                          child: _buildInputRow(context),
                        ),
                ),
                if ((c.isMobile) && _showMediaPicker)
                  SizedBox(
                    height: 400,
                    child: MediaPicker(
                      textController: _messageController,
                      onGifSelected: _onGifSelected,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
