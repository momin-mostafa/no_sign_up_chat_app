import 'package:addiits_technology_practical_test/theme.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String sender;
  final String text;
  final bool isMe;
  final DateTime? time;
  final bool showAvatar;
  final bool showSender;
  final bool isFirstInGroup;
  final bool isLastInGroup;

  const ChatBubble({
    super.key,
    required this.sender,
    required this.text,
    required this.isMe,
    this.time,
    this.showAvatar = false,
    this.showSender = false,
    this.isFirstInGroup = true,
    this.isLastInGroup = true,
  });

  Color get _avatarColor => ChatAppColors.memberColor(ChatAppColors.indigo, sender);

  String get _initial => sender.isNotEmpty ? sender[0].toUpperCase() : "?";

  String _formatTime(DateTime dt) {
    final h = dt.hour.toString().padLeft(2, "0");
    final m = dt.minute.toString().padLeft(2, "0");
    return "$h:$m";
  }

  @override
  Widget build(BuildContext context) {
    final bubbleColor = isMe
        ? ChatAppColors.indigo
        : Theme.of(context).colorScheme.surfaceContainer;
    final textColor = isMe
        ? ChatAppColors.white
        : Theme.of(context).colorScheme.onSurface;
    final timeColor = isMe
        ? ChatAppColors.white.withValues(alpha: 0.7)
        : Theme.of(context).colorScheme.onSurfaceVariant;

    final bubbleRadius = BorderRadius.only(
      topLeft: const Radius.circular(16),
      topRight: const Radius.circular(16),
      bottomLeft: Radius.circular(isMe || !isLastInGroup ? 16 : 4),
      bottomRight: Radius.circular(!isMe || !isLastInGroup ? 16 : 4),
    );

    return Padding(
      padding: EdgeInsets.only(
        top: isFirstInGroup ? 10 : 2,
        bottom: isLastInGroup ? 4 : 0,
      ),
      child: Row(
        mainAxisAlignment: isMe
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isMe)
            showAvatar
                ? Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: CircleAvatar(
                      radius: 14,
                      backgroundColor: _avatarColor,
                      child: Text(
                        _initial,
                        style: const TextStyle(
                          color: ChatAppColors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  )
                : const SizedBox(width: 36),
          Flexible(
            child: Column(
              crossAxisAlignment: isMe
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                if (showSender && !isMe)
                  Padding(
                    padding: const EdgeInsets.only(left: 4, bottom: 4),
                    child: Text(
                      sender,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: bubbleColor,
                    borderRadius: bubbleRadius,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        text,
                        style: TextStyle(
                          color: textColor,
                          fontSize: 15,
                          height: 1.35,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (time != null)
                            Text(
                              _formatTime(time!),
                              style: TextStyle(
                                color: timeColor,
                                fontSize: 11,
                              ),
                            ),
                          if (isMe) ...[
                            const SizedBox(width: 4),
                            Icon(
                              Icons.done_all_rounded,
                              size: 14,
                              color: timeColor,
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
