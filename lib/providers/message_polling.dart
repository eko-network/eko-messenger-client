import 'dart:async';
import 'package:ecp/ecp.dart';
import 'package:eko_messanger/providers/database.dart';
import 'package:eko_messanger/providers/ecp.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:eko_messanger/providers/auth.dart';
import 'package:drift/drift.dart';
import 'package:eko_messanger/database/database.dart';

part '../generated/providers/message_polling.g.dart';

@Riverpod(keepAlive: true)
class MessagePolling extends _$MessagePolling {
  StreamSubscription? _messageStreamSubscription;

  @override
  void build() {
    // Listen to auth state changes by watching the notifier
    final authNotifier = ref.watch(authProvider);

    // Add listener to the ChangeNotifier
    void authListener() {
      if (authNotifier.isAuthenticated) {
        _startStreaming();
      } else {
        _stopStreaming();
      }
    }

    authNotifier.addListener(authListener);

    // Initialize streaming state based on current auth state
    if (authNotifier.isAuthenticated) {
      _startStreaming();
    }

    ref.onDispose(() {
      authNotifier.removeListener(authListener);
      _stopStreaming();
    });
  }

  void _startStreaming() {
    if (_messageStreamSubscription != null) return;

    final ecpClient = ref.read(ecpProvider);
    if (ecpClient == null) return;

    debugPrint('Starting message stream');

    _messageStreamSubscription = ecpClient.messageStreamController
        .getMessageStream()
        .listen(
          _handleMessage,
          onError: (error) {
            debugPrint('Error in message stream: $error');
          },
          cancelOnError: false,
        );
  }

  void _stopStreaming() {
    _messageStreamSubscription?.cancel();
    _messageStreamSubscription = null;
    debugPrint('Stopped message stream');
  }

  Future<void> _handleMessage(ActivityWithRecipients activity) async {
    print(activity);
    try {
      final db = ref.read(appDatabaseProvider);
      final from = activity.from;
      // Ensure contact exists
      var contact = await db.contactsDao.getContactById(from);
      if (contact == null) {
        try {
          final person = await ref.read(ecpProvider)!.getActor(from);
          await db.contactsDao.insertNewContact(person);
          contact = person;
        } catch (e) {
          debugPrint('Could not fetch remote actor $from: $e');
          return; // Skip if we can't get actor details
        }
      }

      // Ensure conversation exists
      final conversation = await db.conversationsDao
          .getConversationByParticipant(from);
      if (conversation == null) {
        await db.conversationsDao.insertNewConversation(
          ConversationsCompanion(participant: Value(from)),
        );
      }

      await db.messagesDao.handleActivity(activity);
    } catch (e) {
      debugPrint('Error handling messages: $e');
    }
  }
}
