import 'package:addiits_technology_practical_test/features/chat_room/models/chat_models.dart';
import 'package:addiits_technology_practical_test/features/chat_room/widgets/chat_bubble.dart';
import 'package:addiits_technology_practical_test/features/chat_room/widgets/day_separator.dart';
import 'package:addiits_technology_practical_test/features/chat_room/widgets/system_chip.dart';
import 'package:flutter/material.dart';

class MessageList extends StatelessWidget {
  final List<MessageItem> items;

  const MessageList({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];

        switch (item) {
          case DayItem():
            return DaySeparator(label: item.dayLabel);

          case SystemItem():
            return SystemChip(text: item.text);

          case ChatMessage():
            final isGroupStart =
                index == 0 ||
                items[index - 1] is! ChatMessage ||
                (items[index - 1] as ChatMessage).sender != item.sender;

            final isGroupEnd =
                index == items.length - 1 ||
                items[index + 1] is! ChatMessage ||
                (items[index + 1] as ChatMessage).sender != item.sender;

            return ChatBubble(
              sender: item.sender,
              text: item.text,
              isMe: item.isMe,
              time: item.time,
              showAvatar: isGroupStart && !item.isMe,
              showSender: isGroupStart && !item.isMe,
              isFirstInGroup: isGroupStart,
              isLastInGroup: isGroupEnd,
            );
        }
      },
    );
  }
}
