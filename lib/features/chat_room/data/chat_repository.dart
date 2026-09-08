import 'dart:async';

import 'package:addiits_technology_practical_test/features/chat_room/models/chat_models.dart';
import 'package:addiits_technology_practical_test/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PresenceInfo {
  final String email;
  final String name;
  final bool online;
  final DateTime lastSeen;

  const PresenceInfo({
    required this.email,
    required this.name,
    required this.online,
    required this.lastSeen,
  });

  factory PresenceInfo.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return PresenceInfo(
      email: doc.id,
      name: data['name'] as String? ?? 'Unknown',
      online: data['online'] as bool? ?? false,
      lastSeen: (data['lastSeen'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }
}

abstract class ChatRepository {
  Stream<List<MessageItem>> watchMessages();
  Stream<List<PresenceInfo>> watchPresence();
  Future<void> sendMessage({required ChatUser user, required String text});
  Future<void> addSystemMessage(String text);
  Future<void> setPresence({required ChatUser user, required bool online});
  void startHeartbeat({
    required ChatUser user,
    Duration interval = const Duration(seconds: 30),
  });
}

class FirestoreChatRepository implements ChatRepository {
  FirestoreChatRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  static const _messagesCollection = 'messages';
  static const _presenceCollection = 'presence';

  @override
  Stream<List<MessageItem>> watchMessages() {
    return _firestore
        .collection(_messagesCollection)
        .orderBy('createdAt', descending: false)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map(_messageFromDocument)
              .toList(growable: false),
        );
  }

  MessageItem _messageFromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    if (data['isSystem'] == true) {
      return SystemItem(data['text'] as String? ?? '');
    }
    return ChatMessage(
      id: doc.id,
      sender: data['sender'] as String? ?? 'Unknown',
      senderEmail: data['senderEmail'] as String? ?? '',
      text: data['text'] as String? ?? '',
      time: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  @override
  Stream<List<PresenceInfo>> watchPresence() {
    return _firestore
        .collection(_presenceCollection)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map(PresenceInfo.fromDocument)
              .where((p) => p.online)
              .toList(growable: false),
        );
  }

  @override
  Future<void> sendMessage({
    required ChatUser user,
    required String text,
  }) {
    return _firestore.collection(_messagesCollection).add({
      'sender': user.name,
      'senderEmail': user.email,
      'text': text,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  @override
  Future<void> addSystemMessage(String text) {
    return _firestore.collection(_messagesCollection).add({
      'sender': '',
      'senderEmail': '',
      'text': text,
      'createdAt': FieldValue.serverTimestamp(),
      'isSystem': true,
    });
  }

  @override
  Future<void> setPresence({
    required ChatUser user,
    required bool online,
  }) {
    return _firestore.collection(_presenceCollection).doc(user.email).set({
      'name': user.name,
      'online': online,
      'lastSeen': FieldValue.serverTimestamp(),
    });
  }

  @override
  void startHeartbeat({
    required ChatUser user,
    Duration interval = const Duration(seconds: 30),
  }) {
    Timer.periodic(interval, (_) {
      setPresence(user: user, online: true);
    });
  }
}

Member memberFromPresence(PresenceInfo presence) {
  return Member(
    name: presence.name,
    initials: presence.name.isNotEmpty ? presence.name[0].toUpperCase() : '?',
    online: presence.online,
    color: ChatAppColors.memberColor(ChatAppColors.indigo, presence.name),
  );
}