import 'package:drift/drift.dart' show Value;
import 'package:eko_messanger/database/daos/conversations_dao.dart';
import 'package:eko_messanger/database/database.dart';
import 'package:eko_messanger/providers/database.dart';
import 'package:eko_messanger/providers/ecp.dart';
import 'package:eko_messanger/screens/chat/adaptive_chat_layout.dart';
import 'package:eko_messanger/widgets/resizable_panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class ConversationList extends ConsumerStatefulWidget {
  final bool isWideScreen;
  final List<ConversationWithContact> conversations;
  final int? selectedId;
  final ResizablePanelController? panelController;
  final Function(int) onConversationTap;

  const ConversationList({
    super.key,
    required this.conversations,
    required this.selectedId,
    required this.onConversationTap,
    required this.isWideScreen,
    this.panelController,
  });

  @override
  ConsumerState<ConversationList> createState() => _ConversationListState();
}

class SettingsButton extends StatelessWidget {
  const SettingsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        context.push("/settings");
      },
      iconSize: 30.0,
      padding: const EdgeInsets.all(5.0),
      splashRadius: kConversationAvatarRadius,
      icon: const Icon(LucideIcons.settings),
    );
  }
}

class NewChatButton extends StatelessWidget {
  final VoidCallback onPressed;
  const NewChatButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      iconSize: 30.0,
      padding: const EdgeInsets.all(5.0),
      splashRadius: kConversationAvatarRadius,
      icon: const Icon(LucideIcons.squarePen),
    );
  }
}

class _ConversationListState extends ConsumerState<ConversationList> {
  final newMessageController = TextEditingController();
  bool newChatScreen = false;

  void onNewPressed() {
    widget.panelController?.expand();
    setState(() {
      newChatScreen = true;
    });
  }

  Future<void> onSearchGetPressed() async {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) => const PopScope(
        canPop: false,
        child: Center(child: CircularProgressIndicator()),
      ),
    );
    try {
      final person = await ref
          .read(ecpProvider)
          .getActorWithWebfinger(newMessageController.text.trim());
      final db = ref.read(appDatabaseProvider);
      await db.contactsDao.insertNewContact(person);
      final newConversationId = await db.conversationsDao.insertNewConversation(
        ConversationsCompanion(participant: Value(person.id)),
      );
      newMessageController.clear();
      if (!mounted) return;
      Navigator.of(context).pop();
      context.go('/chats/$newConversationId');
      return;
    } catch (e) {
      debugPrint(e.toString());
      if (!mounted) return;
      Navigator.of(context).pop(); // dismiss the loading
      if (context.mounted) {
        await showShadDialog(
          context: context,
          builder: (context) => ShadDialog.alert(
            title: const Text('User not found'),
            actions: [
              ShadButton(
                child: const Text('OK'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final showOnlyAvatar =
                constraints.maxWidth < (kConversationAvatarRadius * 2) + 45;
            return IndexedStack(
              index: newChatScreen ? 1 : 0,
              children: [
                /// normal view
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const SizedBox(height: 8),
                    if (!showOnlyAvatar)
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(width: 16),
                          SettingsButton(),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              'Messages',
                              style: Theme.of(context).textTheme.titleLarge
                                  ?.copyWith(
                                    color: AppBarTheme.of(
                                      context,
                                    ).foregroundColor,
                                  ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 16),
                          NewChatButton(onPressed: onNewPressed),
                          const SizedBox(width: 16),
                        ],
                      ),
                    if (showOnlyAvatar) ...[
                      SettingsButton(),
                      NewChatButton(onPressed: onNewPressed),
                    ],
                    Expanded(
                      child: ListView.builder(
                        itemCount: widget.conversations.length,
                        itemBuilder: (context, index) {
                          final conversation = widget.conversations[index];
                          final isSelected =
                              conversation.conversation.id == widget.selectedId;
                          final avatar = CircleAvatar(
                            radius: kConversationAvatarRadius,
                            child: Text(
                              conversation.contact.preferredUsername[0],
                            ),
                          );

                          if (showOnlyAvatar) {
                            return Tooltip(
                              message: conversation.contact.preferredUsername,
                              child: ListTile(
                                selected: isSelected,
                                selectedTileColor: Theme.of(
                                  context,
                                ).primaryColor.withOpacity(0.1),
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 4,
                                ),
                                title: Center(child: avatar),
                                onTap: () => widget.onConversationTap(
                                  conversation.conversation.id,
                                ),
                              ),
                            );
                          }

                          return ListTile(
                            selected: isSelected,
                            selectedTileColor: Theme.of(
                              context,
                            ).primaryColor.withOpacity(0.1),
                            leading: avatar,
                            title: Text(
                              conversation.contact.preferredUsername,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            subtitle: Text(
                              "fixme",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            onTap: () => widget.onConversationTap(
                              conversation.conversation.id,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                //New Chat
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const SizedBox(height: 8),
                    if (!showOnlyAvatar)
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(width: 16),
                          SizedBox(
                            width: kConversationAvatarRadius * 2,
                            height: kConversationAvatarRadius * 2,
                            // width: kConversationAvatarRadius * 2,
                            child: IconButton(
                              onPressed: () {
                                setState(() {
                                  newChatScreen = false;
                                });
                              },
                              iconSize: 30.0,
                              padding: const EdgeInsets.all(5.0),
                              splashRadius: kConversationAvatarRadius,
                              icon: const Icon(Icons.arrow_back_ios),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Text(
                            'New Message',
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(
                                  color: AppBarTheme.of(
                                    context,
                                  ).foregroundColor,
                                ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    Padding(
                      padding: const EdgeInsetsGeometry.symmetric(
                        vertical: 2,
                        horizontal: 5,
                      ),
                      child: ShadInput(controller: newMessageController),
                    ),
                    ValueListenableBuilder(
                      valueListenable: newMessageController,
                      builder: (context, value, child) {
                        return newMessageController.text.isEmpty
                            ? const SizedBox()
                            : ListTile(
                                leading: CircleAvatar(
                                  radius: kConversationAvatarRadius,
                                  child: Text(newMessageController.text[0]),
                                ),
                                title: Text(
                                  newMessageController.text,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                onTap: () async {
                                  await onSearchGetPressed();
                                },
                              );
                      },
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
