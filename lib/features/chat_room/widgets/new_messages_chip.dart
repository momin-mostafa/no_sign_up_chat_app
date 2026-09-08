import 'package:addiits_technology_practical_test/theme.dart';
import 'package:flutter/material.dart';

class NewMessagesChip extends StatelessWidget {
  final int count;

  const NewMessagesChip({super.key, required this.count});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          const Expanded(child: Divider(height: 1, color: ChatAppColors.green)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: ChatAppColors.green.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: ChatAppColors.green),
              ),
              child: Text(
                "$count new message${count == 1 ? '' : 's'}",
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: ChatAppColors.deepGreen,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const Expanded(child: Divider(height: 1, color: ChatAppColors.green)),
        ],
      ),
    );
  }
}
