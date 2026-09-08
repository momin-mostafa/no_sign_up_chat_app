import 'package:addiits_technology_practical_test/features/chat_room/models/chat_models.dart';
import 'package:addiits_technology_practical_test/features/chat_room/widgets/chat_bubble.dart';
import 'package:addiits_technology_practical_test/features/chat_room/widgets/day_separator.dart';
import 'package:addiits_technology_practical_test/features/chat_room/widgets/system_chip.dart';
import 'package:flutter/material.dart';

class MessageList extends StatelessWidget {
  final List<MessageItem> items;
  final String currentUserEmail;

  const MessageList({
    super.key,
    required this.items,
    required this.currentUserEmail,
  });

  List<MessageItem> _withDaySeparators() {
    if (items.isEmpty) return items;
    final result = <MessageItem>[];

    MessageItem? previous;
    for (final item in items) {
      if (item is ChatMessage && previous is ChatMessage) {
        final prevDate = _dateKey(previous.time);
        final currDate = _dateKey(item.time);
        if (prevDate != currDate) {
          result.add(DayItem(_dayLabel(item.time)));
        }
      }
      result.add(item);
      previous = item;
    }
    return result;
  }

  static String _dateKey(DateTime dt) =>
      '${dt.year}-${dt.month}-${dt.day}';

  static String _dayLabel(DateTime dt) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final that = DateTime(dt.year, dt.month, dt.day);
    final diff = today.difference(that).inDays;
    if (diff == 0) return "Today";
    if (diff == 1) return "Yesterday";
    const months = [
      "Jan", "Feb", "Mar", "Apr", "May", "Jun",
      "Jul", "Aug", "Sep", "Oct", "Nov", "Dec",
    ];
    return "${months[dt.month - 1]} ${dt.day}";
  }

  @override
  Widget build(BuildContext context) {
    final display = _withDaySeparators();

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: display.length,
      itemBuilder: (context, index) {
        final item = display[index];

        switch (item) {
          case DayItem():
            return DaySeparator(label: item.dayLabel);

          case SystemItem():
            return SystemChip(text: item.text);

          case ChatMessage():
            final bool isMe = item.isSentBy(currentUserEmail);
            final bool isGroupStart =
                index == 0 ||
                display[index - 1] is! ChatMessage ||
                (display[index - 1] as ChatMessage).senderEmail !=
                    item.senderEmail;

            final bool isGroupEnd =
                index == display.length - 1 ||
                display[index + 1] is! ChatMessage ||
                (display[index + 1] as ChatMessage).senderEmail !=
                    item.senderEmail;

            return ChatBubble(
              sender: item.sender,
              text: item.text,
              isMe: isMe,
              time: item.time,
              showAvatar: isGroupStart && !isMe,
              showSender: isGroupStart && !isMe,
              isFirstInGroup: isGroupStart,
              isLastInGroup: isGroupEnd,
            );
        }
      },
    );
  }
}