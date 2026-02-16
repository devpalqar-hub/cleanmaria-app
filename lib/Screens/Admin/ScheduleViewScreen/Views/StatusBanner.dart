import 'package:cleanby_maria/Screens/Admin/ScheduleViewScreen/ScheduleDetailsScreen.dart';
import 'package:flutter/material.dart';

class StatusBanner extends StatelessWidget {
  final String status;
  final String startsIn;

  const StatusBanner({super.key, required this.status, required this.startsIn});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.tealLight,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Container(
            width: 10,
            height: 10,
            decoration:
                BoxDecoration(color: AppColors.teal, shape: BoxShape.circle),
          ),
          const SizedBox(width: 10),
          Text(
            status,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.teal,
            ),
          ),
          const Spacer(),
          Text(
            'Starts in $startsIn',
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: AppColors.teal,
            ),
          ),
        ],
      ),
    );
  }
}
