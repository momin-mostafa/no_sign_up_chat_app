import 'package:addiits_technology_practical_test/features/chat_room/models/chat_models.dart';
import 'package:addiits_technology_practical_test/theme.dart';
import 'package:flutter/material.dart';

class MemberStrip extends StatelessWidget {
  final List<Member> members;

  const MemberStrip({super.key, required this.members});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        scrollDirection: Axis.horizontal,
        itemCount: members.length,
        separatorBuilder: (_, _) => const SizedBox(width: 14),
        itemBuilder: (context, index) {
          final member = members[index];
          return SizedBox(
            width: 44,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: ShapeDecoration(
                        color: member.color,
                        shape: CircleBorder(
                          side: BorderSide(
                            color: ChatAppColors.green,
                            width: 2,
                          ),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          member.initials,
                          style: const TextStyle(
                            color: ChatAppColors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: member.online
                              ? ChatAppColors.green
                              : ChatAppColors.grey,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: ChatAppColors.white,
                            width: 1.5,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  member.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
