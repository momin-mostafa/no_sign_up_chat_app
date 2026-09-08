import 'package:addiits_technology_practical_test/features/chat_room/data/chat_repository.dart';
import 'package:addiits_technology_practical_test/features/chat_room/models/chat_models.dart';
import 'package:flutter/foundation.dart';

class ChatProvider extends ChangeNotifier {
  ChatProvider({required this._repository});

  final ChatRepository _repository;

  ChatUser? _currentUser;
  ChatUser? get currentUser => _currentUser;

  Stream<List<MessageItem>>? _messagesStream;
  Stream<List<PresenceInfo>>? _presenceStream;

  Stream<List<MessageItem>>? get messagesStream => _messagesStream;
  Stream<List<PresenceInfo>>? get presenceStream => _presenceStream;

  Future<void> joinRoom(ChatUser user) async {
    _currentUser = user;
    await _repository.setPresence(user: user, online: true);
    _repository.addSystemMessage('${user.name} joined the chat');
    _messagesStream = _repository.watchMessages();
    _presenceStream = _repository.watchPresence();
    _repository.startHeartbeat(user: user);
    notifyListeners();
  }

  Future<void> leaveRoom() async {
    final user = _currentUser;
    if (user != null) {
      await _repository.setPresence(user: user, online: false);
    }
  }

  Future<void> sendMessage(String text) async {
    final user = _currentUser;
    if (user == null || text.trim().isEmpty) return;
    await _repository.sendMessage(user: user, text: text.trim());
  }

  Future<void> markMessagesAsRead(List<String> messageIds) async {
    final user = _currentUser;
    if (user == null || messageIds.isEmpty) return;
    await _repository.markMessagesAsRead(
      user: user,
      messageIds: messageIds,
    );
  }

  @override
  void dispose() {
    leaveRoom();
    super.dispose();
  }
}