import 'package:addiits_technology_practical_test/features/chat_room/models/chat_models.dart';
import 'package:flutter/material.dart';

const List<Member> sampleMembers = [
  Member(
    name: "Alice",
    initials: "A",
    online: true,
    color: Color(0xFFE91E63),
  ),
  Member(
    name: "Bob",
    initials: "B",
    online: true,
    color: Color(0xFF2196F3),
  ),
  Member(
    name: "Charlie",
    initials: "C",
    online: true,
    color: Color(0xFFFF9800),
  ),
  Member(
    name: "Diana",
    initials: "D",
    online: false,
    color: Color(0xFF9C27B0),
  ),
  Member(
    name: "Eve",
    initials: "E",
    online: false,
    color: Color(0xFF4CAF50),
  ),
  Member(
    name: "Frank",
    initials: "F",
    online: true,
    color: Color(0xFF00BCD4),
  ),
];

final List<MessageItem> sampleItems = _buildSampleItems();

List<MessageItem> _buildSampleItems() {
  final now = DateTime.now();

  DateTime dt(int dayOffset, int hour, int minute, [int second = 0]) =>
      DateTime(
        now.year,
        now.month,
        now.day - dayOffset,
        hour,
        minute,
        second,
      );

  return [
    const DayItem("Today"),
    ChatMessage(
      sender: "Alice",
      text: "Hey everyone! Has anyone tried the new Flutter 3.22 features?",
      isMe: false,
      time: dt(0, 10, 0),
    ),
    ChatMessage(
      sender: "Alice",
      text: "The Impeller rendering engine is so much smoother now 🔥",
      isMe: false,
      time: dt(0, 10, 1),
    ),
    ChatMessage(
      sender: "You",
      text:
          "Yes! I updated my project yesterday. Performance boost is noticeable.",
      isMe: true,
      time: dt(0, 10, 3),
    ),
    ChatMessage(
      sender: "Bob",
      text: "Nice! I'm still on 3.19. Is the migration straightforward?",
      isMe: false,
      time: dt(0, 10, 5),
    ),
    ChatMessage(
      sender: "You",
      text:
          "Pretty smooth. Just bump the SDK constraint and run flutter upgrade. Had to fix two deprecation warnings but that's it.",
      isMe: true,
      time: dt(0, 10, 6),
    ),
    ChatMessage(
      sender: "You",
      text: "Also the new Dart macros are preview 🔥🔥",
      isMe: true,
      time: dt(0, 10, 6, 30),
    ),
    const SystemItem("Charlie joined the chat"),
    ChatMessage(
      sender: "Charlie",
      text: "Hey! What did I miss?",
      isMe: false,
      time: dt(0, 10, 12),
    ),
    const DayItem("Yesterday"),
    ChatMessage(
      sender: "Diana",
      text: "Can someone review my PR? It adds the new chat UI components.",
      isMe: false,
      time: dt(1, 16, 30),
    ),
    ChatMessage(
      sender: "You",
      text: "Sure, I'll take a look after lunch.",
      isMe: true,
      time: dt(1, 16, 45),
    ),
    ChatMessage(
      sender: "Alice",
      text: "I can review it too. Share the link?",
      isMe: false,
      time: dt(1, 17, 0),
    ),
    ChatMessage(
      sender: "Diana",
      text: "Thanks both! Here it is: github.com/team/app/pull/142",
      isMe: false,
      time: dt(1, 17, 5),
    ),
  ];
}
