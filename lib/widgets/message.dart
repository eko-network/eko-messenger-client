import 'package:eko_messenger/database/database.dart';
import 'package:eko_messenger/database/type_converters.dart';
import 'package:eko_messenger/providers/time.dart';
import 'package:eko_messenger/utils/constants.dart' as c;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

bool _isShortEmojiString(String text) {
  const maxLen = 5;
  final glyphs = text.characters;

  if (glyphs.isEmpty || glyphs.length > maxLen) {
    return false;
  }

  if (RegExp(r'[a-zA-Z0-9\p{L}\p{N}\p{P}]', unicode: true).hasMatch(text)) {
    return false;
  }

  return text.trim().isNotEmpty;
}

class DateChip extends ConsumerWidget {
  final DateTime time;
  const DateChip({super.key, required this.time});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final now = ref.watch(currentTimeProvider);
    final yesterday = now.subtract(Duration(days: 1));

    final String text;

    if (time.year == now.year &&
        time.month == now.month &&
        time.day == now.day) {
      text = "Today";
    } else if (time.year == yesterday.year &&
        time.month == yesterday.month &&
        time.day == yesterday.day) {
      text = "Yesterday";
    } else {
      text = DateFormat('E, MMM d').format(time);
    }
    return Text(text, style: TextStyle(fontWeight: FontWeight.w300));
  }
}

class TimeWidget extends ConsumerWidget {
  final DateTime messageTime;
  const TimeWidget({super.key, required this.messageTime});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final now = ref.watch(currentTimeProvider);
    final dif = now.difference(messageTime);
    final String text;
    if (dif.inMinutes < 1) {
      text = 'now';
    } else if (dif.inHours < 1) {
      text = '${dif.inMinutes}m';
    } else {
      text = DateFormat.jm().format(messageTime);
    }
    return Text(
      text,
      style: TextStyle(fontSize: 10, fontWeight: FontWeight.w300),
    );
  }
}

class StatusWidget extends StatelessWidget {
  final Message message;
  final bool isReceived;
  const StatusWidget({
    super.key,
    required this.message,
    required this.isReceived,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 0), // Optical alignment
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          TimeWidget(messageTime: message.time),
          if (!isReceived)
            Padding(
              padding: EdgeInsetsGeometry.only(left: 4),
              child: Icon(
                message.status == MessageStatus.sending
                    ? LucideIcons.clock
                    : LucideIcons.check,
                size: 12,
                color: Colors.white70,
              ),
            ),
        ],
      ),
    );
  }
}

enum MessagePosition { top, middle, bottom, single }

BorderRadius _posToBorder(MessagePosition pos, bool isReceived) {
  const double big = 16.0;
  const double small = 4.0;

  // 1. Determine which side should have the "grouping" effect
  // Received = Left side is flat/sharp | Sent = Right side is flat/sharp
  final bool isTopFlattened =
      pos == MessagePosition.middle || pos == MessagePosition.bottom;
  final bool isBottomFlattened =
      pos == MessagePosition.middle || pos == MessagePosition.top;

  return BorderRadius.only(
    topLeft: Radius.circular(isReceived && isTopFlattened ? small : big),
    bottomLeft: Radius.circular(isReceived && isBottomFlattened ? small : big),
    topRight: Radius.circular(!isReceived && isTopFlattened ? small : big),
    bottomRight: Radius.circular(
      !isReceived && isBottomFlattened ? small : big,
    ),
  );
}

class MessageWidget extends StatelessWidget {
  final bool isReceived;
  final Message message;
  final MessagePosition position;
  const MessageWidget({
    super.key,
    required this.isReceived,
    required this.message,
    this.position = MessagePosition.single,
  });

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    final isShortEmojiString = message.content != null
        ? _isShortEmojiString(message.content!)
        : false;

    final Color backgroundColor;

    if (isShortEmojiString) {
      backgroundColor = Colors.transparent;
    } else {
      backgroundColor = isReceived
          ? theme.colorScheme.custom[c.grayMessageColorKey]!
          : theme.colorScheme.custom[c.primaryColorKey]!;
    }
    final isBottom =
        position == MessagePosition.single ||
        position == MessagePosition.bottom;

    return Align(
      alignment: isReceived ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        margin: EdgeInsets.only(bottom: isBottom ? 12 : 4),
        constraints: BoxConstraints(
          // Ensure the bubble doesn't take full width unless necessary
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: _posToBorder(position, isReceived),
        ),
        child: isShortEmojiString
            ? Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: isReceived
                    ? CrossAxisAlignment.start
                    : CrossAxisAlignment.end,
                children: [
                  Text(
                    message.content ?? "No content",
                    style: const TextStyle(fontSize: 32, color: Colors.white),
                  ),
                  if (isBottom)
                    StatusWidget(message: message, isReceived: isReceived),
                ],
              )
            : Wrap(
                alignment: WrapAlignment.end,
                crossAxisAlignment: WrapCrossAlignment.end,
                runAlignment: WrapAlignment.end,
                spacing: 8, // Horizontal space between text and icon
                runSpacing: 4, // Vertical space if the icon wraps to a new line
                children: [
                  Text(
                    message.content ?? "No content",
                    style: const TextStyle(fontSize: 14, color: Colors.white),
                  ),
                  if (isBottom)
                    StatusWidget(message: message, isReceived: isReceived),
                ],
              ),
      ),
    );
  }
}
