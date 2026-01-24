import 'dart:async';
import 'dart:io';
import 'package:ecp/ecp.dart';
import 'package:eko_messenger/database/type_converters.dart';
import 'package:eko_messenger/providers/database.dart';
import 'package:eko_messenger/providers/ecp.dart';
import 'package:eko_messenger/services/notification_service.dart';
import 'package:eko_messenger/utils/constants.dart' as c;
import 'package:flutter/widgets.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:eko_messenger/providers/auth.dart';
import 'package:drift/drift.dart';
import 'package:eko_messenger/database/database.dart';

part '../generated/providers/messages.g.dart';

@Riverpod(keepAlive: true)
class MessagePolling extends _$MessagePolling with WidgetsBindingObserver {
  StreamSubscription? _messageStreamSubscription;
  bool _isStreamActive = false;
  // notify desktop platforms when app is not focused. Mobile should rely on service rather than polling
  bool isDesktopNotifiyEligiable = true;

  final _notificationService = NotificationService();

  @override
  void build() {
    // Add lifecycle observer
    WidgetsBinding.instance.addObserver(this);

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
      WidgetsBinding.instance.removeObserver(this);
      authNotifier.removeListener(authListener);
      _stopStreaming();
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    debugPrint('App lifecycle state changed to: $state');

    // Only pause/resume on mobile platforms
    final isMobile = Platform.isAndroid || Platform.isIOS;
    if (!isMobile) return;

    switch (state) {
      case AppLifecycleState.resumed:
        _resumeStream();
        isDesktopNotifiyEligiable = true;
        break;
      case AppLifecycleState.paused:
        // It is unlikely the OS will close the socket in the other states.
        _pauseStream();
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
        // app is not focused, user may want notification
        isDesktopNotifiyEligiable = false;
    }
  }

  void _pauseStream() {
    if (!_isStreamActive) return;

    final ecpClient = ref.read(ecpProvider);
    ecpClient.messageStreamController.pause();
    debugPrint('Message stream paused (app in background)');
  }

  void _resumeStream() {
    if (!_isStreamActive) return;
    final ecpClient = ref.read(ecpProvider);
    ecpClient.messageStreamController.resume();
    debugPrint('Message stream resumed (app in foreground)');
  }

  void _startStreaming() {
    if (_messageStreamSubscription != null) return;

    final ecpClient = ref.read(ecpProvider);

    debugPrint('Starting message stream');
    _isStreamActive = true;

    _messageStreamSubscription = ecpClient.messageStreamController
        .getMessageStream()
        .listen(
          processMessage,
          onError: (error) {
            debugPrint('Error in message stream: $error');
          },
          cancelOnError: false,
        );
  }

  void _stopStreaming() {
    _messageStreamSubscription?.cancel();
    _messageStreamSubscription = null;
    _isStreamActive = false;
    debugPrint('Stopped message stream');
  }

  /// Unified pipeline for processing all incoming messages
  /// Handles messages from both stream interface and getMessages calls
  /// notifiableOverride ensures the pipeline will notifiy on any notifiable event regardles of isDesktopNotifiable
  Future<void> processMessage(
    ActivityWithRecipients activity, {
    bool notifiableOverride = false,
  }) async {
    debugPrint('Processing message: ${activity.toString()}');

    final notifiable =
        c.isDesktop && isDesktopNotifiyEligiable || notifiableOverride;

    // Only handle Create StableActivity for now
    switch (activity.activity) {
      case Create create:
        switch (create.object) {
          case Note note:
            final db = ref.read(appDatabaseProvider);
            final from = activity.from;

            // Ensure contact exists
            var contact = await db.contactsDao.getContactById(from);
            if (contact == null) {
              try {
                final person = await ref.read(ecpProvider).getActor(from);
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
            debugPrint("Processed message, notifiable: $notifiable");
            if (notifiable) {
              // TODO discard malformed objects
              _notificationService.showNewMessageNotification(
                from: contact.preferredUsername,
                message: note.content ?? 'message',
              );
            }
            await db.messagesDao.insertNewMessage(
              Message(
                id: note.base.id,
                to: activity.to.first,
                from: activity.from,
                time: DateTime.now(),
                content: note.content,
                status: MessageStatus.delivered,
                inReplyTo: note.base.inReplyTo,
              ),
            );
            break;
          default:
            debugPrint('Unknown object: ${create.object.type}}');
        }
        break;
      default:
        debugPrint('Skipping non-Create activity: ${activity.activity.type}}');
    }
  }
}
