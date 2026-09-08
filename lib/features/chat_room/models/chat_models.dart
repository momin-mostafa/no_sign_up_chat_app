import 'package:flutter/material.dart';

class Member {
  final String name;
  final String initials;
  final bool online;
  final Color color;

  const Member({
    required this.name,
    required this.initials,
    required this.online,
    required this.color,
  });
}

sealed class MessageItem {
  const MessageItem();
}

class DayItem extends MessageItem {
  final String dayLabel;

  const DayItem(this.dayLabel);
}

class SystemItem extends MessageItem {
  final String text;

  const SystemItem(this.text);
}

class ChatMessage extends MessageItem {
  final String sender;
  final String text;
  final bool isMe;
  final DateTime time;

  const ChatMessage({
    required this.sender,
    required this.text,
    required this.isMe,
    required this.time,
  });
}
