import 'package:cloud_firestore/cloud_firestore.dart';
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

class ChatUser {
  final String name;
  final String email;

  const ChatUser({required this.name, required this.email});
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
  final String id;
  final String sender;
  final String senderEmail;
  final String text;
  final DateTime time;
  final List<String> readBy;

  const ChatMessage({
    required this.id,
    required this.sender,
    required this.senderEmail,
    required this.text,
    required this.time,
    this.readBy = const [],
  });

  factory ChatMessage.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ChatMessage(
      id: doc.id,
      sender: data['sender'] as String? ?? 'Unknown',
      senderEmail: data['senderEmail'] as String? ?? '',
      text: data['text'] as String? ?? '',
      time: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      readBy: (data['readBy'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
    );
  }

  bool isSentBy(String email) => senderEmail == email;

  bool isUnreadBy(String email) => !readBy.contains(email);
}