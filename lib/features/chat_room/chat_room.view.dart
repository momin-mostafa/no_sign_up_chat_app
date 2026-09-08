import 'package:addiits_technology_practical_test/features/chat_room/chat_provider.dart';
import 'package:addiits_technology_practical_test/features/chat_room/data/chat_repository.dart';
import 'package:addiits_technology_practical_test/features/chat_room/models/chat_models.dart';
import 'package:addiits_technology_practical_test/features/chat_room/widgets/composer.dart';
import 'package:addiits_technology_practical_test/features/chat_room/widgets/member_strip.dart';
import 'package:addiits_technology_practical_test/features/chat_room/widgets/message_list.dart';
import 'package:addiits_technology_practical_test/features/chat_room/widgets/typing_indicator.dart';
import 'package:addiits_technology_practical_test/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatRoomView extends StatelessWidget {
  const ChatRoomView({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ChatProvider>();
    final user = provider.currentUser;

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
            StreamBuilder<List<PresenceInfo>>(
              stream: provider.presenceStream,
              builder: (context, snapshot) {
                final total = snapshot.data?.length ?? 0;
                return Row(
                  spacing: 8,
                  children: [
                    Icon(
                      Icons.fiber_manual_record,
                      size: 12,
                      color: ChatAppColors.green,
                    ),
                    Text(
                      "$total online",
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
        leading: const SizedBox(),
        leadingWidth: 0,
        actions: [
          Padding(padding: const EdgeInsets.all(8.0), child: CircleAvatar()),
        ],
      ),
      body: Column(
        children: [
          StreamBuilder<List<PresenceInfo>>(
            stream: provider.presenceStream,
            builder: (context, snapshot) {
              final presence = snapshot.data ?? const <PresenceInfo>[];
              final members = presence
                  .map(memberFromPresence)
                  .toList(growable: false);
              return MemberStrip(members: members);
            },
          ),
          const Divider(height: 1),
          Expanded(
            child: StreamBuilder<List<MessageItem>>(
              stream: provider.messagesStream,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text("Couldn't load messages"),
                  );
                }
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                return MessageList(
                  items: snapshot.data!,
                  currentUserEmail: user?.email ?? '',
                  onMarkRead: provider.markMessagesAsRead,
                );
              },
            ),
          ),
          const TypingIndicator(someoneTyping: ""),
          const Composer(),
        ],
      ),
    );
  }
}