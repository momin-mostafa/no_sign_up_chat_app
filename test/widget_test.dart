import 'package:addiits_technology_practical_test/features/chat_room/chat_room.view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Chat room view renders core elements', (tester) async {
    await tester.binding.setSurfaceSize(const Size(800, 1400));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      const MaterialApp(home: ChatRoomView()),
    );

    expect(find.text("# General"), findsOneWidget);
    expect(find.text("3 online"), findsOneWidget);
    expect(find.text("Alice"), findsWidgets);
    expect(find.text("Today"), findsOneWidget);
    expect(find.text("Type a message…"), findsOneWidget);
  });
}
