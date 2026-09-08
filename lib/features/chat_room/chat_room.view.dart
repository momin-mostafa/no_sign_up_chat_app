import 'package:addiits_technology_practical_test/features/chat_room/data/sample_data.dart';
import 'package:addiits_technology_practical_test/features/chat_room/widgets/composer.dart';
import 'package:addiits_technology_practical_test/features/chat_room/widgets/member_strip.dart';
import 'package:addiits_technology_practical_test/features/chat_room/widgets/message_list.dart';
import 'package:addiits_technology_practical_test/features/chat_room/widgets/typing_indicator.dart';
import 'package:addiits_technology_practical_test/theme.dart';
import 'package:flutter/material.dart';

class ChatRoomView extends StatelessWidget {
  const ChatRoomView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "# General",
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
              overflow: TextOverflow.ellipsis,
            ),
            Row(
              spacing: 8,
              children: [
                Icon(
                  Icons.fiber_manual_record,
                  size: 12,
                  color: ChatAppColors.green,
                ),
                Text(
                  "3 online",
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ],
        ),
        leading: const SizedBox(),
        leadingWidth: 0,
        actions: [
          Padding(padding: const EdgeInsets.all(8.0), child: CircleAvatar()),
        ],
      ),
      backgroundColor: ChatAppColors.white,
      body: Column(
        children: [
          MemberStrip(members: sampleMembers),
          const Divider(height: 1),
          Expanded(child: MessageList(items: sampleItems)),
          const TypingIndicator(someoneTyping: "Alice"),
          const Composer(),
        ],
      ),
    );
  }
}
