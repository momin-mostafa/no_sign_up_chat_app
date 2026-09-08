import 'package:addiits_technology_practical_test/features/chat_room/chat_provider.dart';
import 'package:addiits_technology_practical_test/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Composer extends StatefulWidget {
  const Composer({super.key});

  @override
  State<Composer> createState() => _ComposerState();
}

class _ComposerState extends State<Composer> {
  final _controller = TextEditingController();
  bool _sending = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _send() async {
    final text = _controller.text.trim();
    if (text.isEmpty || _sending) return;

    setState(() => _sending = true);
    try {
      await context.read<ChatProvider>().sendMessage(text);
      _controller.clear();
    } finally {
      if (mounted) setState(() => _sending = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 12,
        right: 8,
        top: 8,
        bottom: MediaQuery.of(context).padding.bottom + 8,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border(
          top: BorderSide(
            color: Theme.of(context).dividerColor.withValues(alpha: 0.2),
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 120),
              child: TextField(
                controller: _controller,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                textCapitalization: TextCapitalization.sentences,
                onSubmitted: (_) => _send(),
                decoration: const InputDecoration(
                  hintText: "Type a message…",
                ),
              ),
            ),
          ),
          const SizedBox(width: 6),
          Container(
            height: 40,
            width: 40,
            decoration: const BoxDecoration(
              color: ChatAppColors.indigo,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: _sending ? null : _send,
              icon: const Icon(
                Icons.arrow_upward,
                size: 18,
                color: ChatAppColors.white,
              ),
              tooltip: "Send message",
              padding: EdgeInsets.zero,
            ),
          ),
        ],
      ),
    );
  }
}