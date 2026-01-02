import 'dart:async';
import 'package:ecp/ecp.dart';
import 'package:eko_messanger/providers/database.dart';
import 'package:eko_messanger/providers/ecp.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:eko_messanger/providers/auth.dart';
import 'package:drift/drift.dart';
import 'package:eko_messanger/database/database.dart';
import 'package:http/http.dart' as http;

part '../generated/providers/message_polling.g.dart';

@Riverpod(keepAlive: true)
class MessagePolling extends _$MessagePolling {
  Timer? _pollingTimer;

  @override
  void build() {
    // Listen to auth state changes
    ref.listen(authProvider, (previous, next) {
      if (next.isAuthenticated) {
        _startPolling();
      } else {
        _stopPolling();
      }
    });

    if (ref.read(authProvider).isAuthenticated) {
      _startPolling();
    }

    ref.onDispose(() {
      _stopPolling();
    });
  }

  void _startPolling() {
    if (_pollingTimer?.isActive ?? false) return;

    _pollingTimer = Timer.periodic(const Duration(seconds: 3), (_) async {
      await _pollForMessages();
    });

    debugPrint('Started message polling (every 3 seconds)');
  }

  void _stopPolling() {
    _pollingTimer?.cancel();
    _pollingTimer = null;
    debugPrint('Stopped message polling');
  }

  Future<void> _pollForMessages() async {
    try {
      final response = await ref.read(ecpProvider)!.getMessages();

      if (kDebugMode) {
        debugPrint('Poll response: $response');
      }

      final db = ref.read(appDatabaseProvider);

      for (final activity in response) {
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
            continue; // Skip if we can't get actor details
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
      }
    } catch (e) {
      debugPrint('Error polling for messages: $e');
    }
  }
}
