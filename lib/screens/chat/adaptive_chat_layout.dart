import 'package:collection/collection.dart';
import 'package:eko_messenger/database/daos/conversations_dao.dart';
import 'package:eko_messenger/providers/database.dart';
import 'package:eko_messenger/screens/chat/chat_view.dart';
import 'package:eko_messenger/screens/chat/conversation_list.dart';
import 'package:eko_messenger/utils/constants.dart' as c;
import 'package:eko_messenger/widgets/resizable_panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

const double kConversationAvatarRadius = 20.0;

final conversationsProvider = StreamProvider<List<ConversationWithContact>>((
  ref,
) {
  final db = ref.watch(appDatabaseProvider);
  return db.conversationsDao.watchConversationsWithContact();
});

class AdaptiveChat extends ConsumerWidget {
  final int? selectedConversationId;
  final controller = ResizablePanelController();

  AdaptiveChat({super.key, this.selectedConversationId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final conversationsAsync = ref.watch(conversationsProvider);

    return Scaffold(
      body: conversationsAsync.when(
        data: (conversations) => LayoutBuilder(
          builder: (context, constraints) {
            final isWideScreen = constraints.maxWidth >= c.wideScreen;
            if (isWideScreen) {
              return _buildWideLayout(context, constraints, conversations);
            } else {
              return _buildNarrowLayout(context, conversations);
            }
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) =>
            Center(child: Text('Failed to load conversations: $error')),
      ),
    );
  }

  Widget _buildWideLayout(
    BuildContext context,
    BoxConstraints constraints,
    List<ConversationWithContact> conversations,
  ) {
    const double minWidth = 200.0;
    const double maxWidth = 600.0;
    const double defaultWidth = 400.0;
    const double snapWidth = kConversationAvatarRadius * 2 + 20;

    final selectedConversation = conversations.firstWhereOrNull(
      (c) => c.conversation.id == selectedConversationId,
    );

    return ResizablePanel(
      key: ValueKey(constraints.maxWidth),
      minWidth: minWidth,
      maxWidth: maxWidth,
      defaultWidth: defaultWidth,
      snapWidth: snapWidth,
      controller: controller,
      firstPanel: ConversationList(
        isWideScreen: true,
        conversations: conversations,
        selectedId: selectedConversationId,
        panelController: controller,
        onConversationTap: (id) => context.go('/chats/$id'),
      ),
      secondPanel:
          selectedConversationId == null || selectedConversation == null
          ? const Center(
              child: Text(
                'Select a conversation to start chatting',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : ChatView(conversation: selectedConversation, onBack: null),
    );
  }

  Widget _buildNarrowLayout(
    BuildContext context,
    List<ConversationWithContact> conversations,
  ) {
    final selectedConversation = conversations.firstWhereOrNull(
      (c) => c.conversation.id == selectedConversationId,
    );

    if (selectedConversationId == null || selectedConversation == null) {
      return ConversationList(
        isWideScreen: false,
        conversations: conversations,
        selectedId: null,
        onConversationTap: (id) => context.go('/chats/$id'),
      );
    } else {
      return ChatView(
        conversation: selectedConversation,
        onBack: () => context.go('/'),
      );
    }
  }
}
