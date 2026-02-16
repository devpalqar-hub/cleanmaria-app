import 'package:cleanby_maria/Screens/Admin/ScheduleViewScreen/ScheduleDetailsScreen.dart';
import 'package:flutter/material.dart';

class ProfessionalCard extends StatelessWidget {
  String name;
  String subname;
  String id;
  ProfessionalCard(
      {super.key, required this.name, required this.subname, required this.id});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.divider),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          // Avatar
          CircleAvatar(
              radius: 28,
              backgroundColor: AppColors.greyLight,
              child: Text(
                name[0],
                style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: AppColors.teal),
              )),
          const SizedBox(width: 14),

          // Name + Rating
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: AppColors.dark),
                ),
                const SizedBox(height: 4),
                Text(
                  '${subname}',
                  style: const TextStyle(fontSize: 12, color: AppColors.grey),
                ),
              ],
            ),
          ),

          // Chat Button
          GestureDetector(
            onTap: () {},
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.divider),
              ),
              child: const Icon(Icons.chat_bubble_outline_rounded,
                  size: 20, color: AppColors.teal),
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════
// PAYMENT SUMMARY CARD
// ═══════════════════════════════════════════════════════
