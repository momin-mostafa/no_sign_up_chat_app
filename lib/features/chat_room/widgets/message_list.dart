import 'package:addiits_technology_practical_test/features/chat_room/models/chat_models.dart';
import 'package:addiits_technology_practical_test/features/chat_room/widgets/chat_bubble.dart';
import 'package:addiits_technology_practical_test/features/chat_room/widgets/day_separator.dart';
import 'package:addiits_technology_practical_test/features/chat_room/widgets/new_messages_chip.dart';
import 'package:addiits_technology_practical_test/features/chat_room/widgets/system_chip.dart';
import 'package:addiits_technology_practical_test/theme.dart';
import 'package:flutter/material.dart';

class MessageList extends StatefulWidget {
  final List<MessageItem> items;
  final String currentUserEmail;
  final ValueChanged<List<String>> onMarkRead;

  const MessageList({
    super.key,
    required this.items,
    required this.currentUserEmail,
    required this.onMarkRead,
  });

  @override
  State<MessageList> createState() => _MessageListState();
}

class _MessageListState extends State<MessageList> {
  final GlobalKey _markerKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _markVisibleAsRead();
  }

  @override
  void didUpdateWidget(MessageList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!identical(oldWidget.items, widget.items)) {
      _markVisibleAsRead();
    }
  }

  void _markVisibleAsRead() {
    final ids = widget.items
        .whereType<ChatMessage>()
        .where((m) => m.isUnreadBy(widget.currentUserEmail))
        .map((m) => m.id)
        .toList(growable: false);
    if (ids.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget.onMarkRead(ids);
      });
    }
  }

  void _scrollToFirstUnread() {
    final context = _markerKey.currentContext;
    if (context == null) return;
    Scrollable.ensureVisible(
      context,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
      alignment: 0.5,
    );
  }

  List<MessageItem> _withDaySeparators() {
    if (widget.items.isEmpty) return widget.items;
    final result = <MessageItem>[];

    MessageItem? previous;
    for (final item in widget.items) {
      if (item is ChatMessage && previous is ChatMessage) {
        final prevDate = _dateKey(previous.time);
        final currDate = _dateKey(item.time);
        if (prevDate != currDate) {
          result.add(DayItem(_dayLabel(item.time)));
        }
      }
      result.add(item);
      previous = item;
    }
    return result;
  }

  List<_DisplayItem> _withUnreadMarker() {
    final read = _withDaySeparators();
    if (read.isEmpty) return const [];

    final firstUnreadIndex = read.indexWhere((item) {
      if (item is! ChatMessage) return false;
      return item.isUnreadBy(widget.currentUserEmail);
    });

    if (firstUnreadIndex == -1) {
      return read.map(_DisplayItem.real).toList(growable: false);
    }

    final unreadCount = read
        .whereType<ChatMessage>()
        .where((m) => m.isUnreadBy(widget.currentUserEmail))
        .length;

    final result = <_DisplayItem>[];
    for (var i = 0; i < read.length; i++) {
      if (i == firstUnreadIndex) {
        result.add(_DisplayItem.marker(unreadCount));
      }
      result.add(_DisplayItem.real(read[i]));
    }
    return result;
  }

  static String _dateKey(DateTime dt) =>
      '${dt.year}-${dt.month}-${dt.day}';

  static String _dayLabel(DateTime dt) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final that = DateTime(dt.year, dt.month, dt.day);
    final diff = today.difference(that).inDays;
    if (diff == 0) return "Today";
    if (diff == 1) return "Yesterday";
    const months = [
      "Jan", "Feb", "Mar", "Apr", "May", "Jun",
      "Jul", "Aug", "Sep", "Oct", "Nov", "Dec",
    ];
    return "${months[dt.month - 1]} ${dt.day}";
  }

  @override
  Widget build(BuildContext context) {
    final display = _withUnreadMarker();
    final hasUnread = display.any((e) => e.marker != null);

    return Stack(
      children: [
        ListView.builder(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 88),
          itemCount: display.length,
          itemBuilder: (context, index) {
            final entry = display[index];
            if (entry.marker != null) {
              return KeyedSubtree(
                key: _markerKey,
                child: NewMessagesChip(count: entry.marker!),
              );
            }

            final item = entry.item!;

            switch (item) {
              case DayItem():
                return DaySeparator(label: item.dayLabel);

              case SystemItem():
                return SystemChip(text: item.text);

              case ChatMessage():
                final bool isMe = item.isSentBy(widget.currentUserEmail);
                final prev = index > 0 ? display[index - 1] : null;
                final next = index < display.length - 1
                    ? display[index + 1]
                    : null;

                final MessageItem? prevItem =
                    (prev != null && prev.item != null) ? prev.item : null;
                final MessageItem? nextItem =
                    (next != null && next.item != null) ? next.item : null;

                final bool isGroupStart =
                    prevItem == null ||
                    prevItem is! ChatMessage ||
                    prevItem.senderEmail != item.senderEmail;

                final bool isGroupEnd =
                    nextItem == null ||
                    nextItem is! ChatMessage ||
                    nextItem.senderEmail != item.senderEmail;

                return ChatBubble(
                  sender: item.sender,
                  text: item.text,
                  isMe: isMe,
                  time: item.time,
                  showAvatar: isGroupStart && !isMe,
                  showSender: isGroupStart && !isMe,
                  isFirstInGroup: isGroupStart,
                  isLastInGroup: isGroupEnd,
                );
            }
          },
        ),
        if (hasUnread)
          Positioned(
            right: 16,
            bottom: 16,
            child: FloatingActionButton(
              mini: true,
              backgroundColor: ChatAppColors.green,
              foregroundColor: ChatAppColors.white,
              onPressed: _scrollToFirstUnread,
              tooltip: 'Jump to unread messages',
              child: const Icon(Icons.expand_more_rounded),
            ),
          ),
      ],
    );
  }
}

class _DisplayItem {
  final MessageItem? item;
  final int? marker;

  const _DisplayItem.real(MessageItem this.item) : marker = null;
  const _DisplayItem.marker(int this.marker) : item = null;
}