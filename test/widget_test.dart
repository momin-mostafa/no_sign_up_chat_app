import 'dart:async';

import 'package:addiits_technology_practical_test/features/chat_room/chat_provider.dart';
import 'package:addiits_technology_practical_test/features/chat_room/chat_room.view.dart';
import 'package:addiits_technology_practical_test/features/chat_room/data/chat_repository.dart';
import 'package:addiits_technology_practical_test/features/chat_room/models/chat_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

class _FakeChatRepository implements ChatRepository {
  final controller = StreamController<List<MessageItem>>.broadcast();
  final presenceController = StreamController<List<PresenceInfo>>.broadcast();

  @override
  Stream<List<MessageItem>> watchMessages() => controller.stream;

  @override
  Stream<List<PresenceInfo>> watchPresence() => presenceController.stream;

  @override
  Future<void> addSystemMessage(String text) async {}

  @override
  Future<void> markMessagesAsRead({
    required ChatUser user,
    required List<String> messageIds,
  }) async {}

  @override
  Future<void> sendMessage({
    required ChatUser user,
    required String text,
  }) async {}

  @override
  Future<void> setPresence({
    required ChatUser user,
    required bool online,
  }) async {
    if (online) {
      presenceController.add([
        PresenceInfo(
          email: user.email,
          name: user.name,
          online: true,
          lastSeen: DateTime.now(),
        ),
      ]);
    }
  }

  @override
  void startHeartbeat({
    required ChatUser user,
    Duration interval = const Duration(seconds: 30),
  }) {}

  void close() {
    controller.close();
    presenceController.close();
  }
}

void main() {
  testWidgets('Chat room view renders messages from provider', (tester) async {
    await tester.binding.setSurfaceSize(const Size(800, 1400));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    final repo = _FakeChatRepository();
    addTearDown(repo.close);

    final provider = ChatProvider(repository: repo);

    await tester.pumpWidget(
      ChangeNotifierProvider.value(
        value: provider,
        child: const MaterialApp(home: ChatRoomView()),
      ),
    );

    final user = ChatUser(name: "Alice", email: "alice@example.com");
    await provider.joinRoom(user);
    await tester.pump();

    await repo.setPresence(user: user, online: true);
    repo.controller.add([
      ChatMessage(
        id: '1',
        sender: 'Alice',
        senderEmail: 'alice@example.com',
        text: 'Hello world',
        time: DateTime.now(),
      ),
    ]);

    await tester.pump();

    expect(find.text("# General"), findsOneWidget);
    expect(find.text("1 online"), findsOneWidget);
    expect(find.text("Alice"), findsOneWidget);
    expect(find.text("Hello world"), findsOneWidget);
    expect(find.text("Type a message…"), findsOneWidget);
  });
}