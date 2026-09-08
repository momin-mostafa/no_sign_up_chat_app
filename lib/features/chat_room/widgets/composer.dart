import 'package:addiits_technology_practical_test/theme.dart';
import 'package:flutter/material.dart';

class Composer extends StatelessWidget {
  const Composer({super.key});

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
                maxLines: null,
                keyboardType: TextInputType.multiline,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
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
              onPressed: () {},
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
