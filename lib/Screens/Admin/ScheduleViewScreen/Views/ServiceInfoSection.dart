import 'package:cleanby_maria/Screens/Admin/ScheduleViewScreen/ScheduleDetailsScreen.dart';
import 'package:flutter/material.dart';

class ServiceInfoSection extends StatelessWidget {
  final String serviceType;
  final String date;
  final String timeRange;
  final String address;
  final String entryCode;

  const ServiceInfoSection({
    super.key,
    required this.serviceType,
    required this.date,
    required this.timeRange,
    required this.address,
    required this.entryCode,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _InfoRow(
          icon: Icons.calendar_month_outlined,
          title: serviceType,
          lines: [date, timeRange],
        ),
        const _ThinDivider(),
        _InfoRow(
          icon: Icons.location_on_outlined,
          title: 'Location',
          lines: [address, 'Instruction: $entryCode'],
        ),
      ],
    );
  }
}

class _ThinDivider extends StatelessWidget {
  const _ThinDivider();

  @override
  Widget build(BuildContext context) {
    return const Divider(height: 1, color: AppColors.divider);
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final List<String> lines;

  const _InfoRow(
      {required this.icon, required this.title, required this.lines});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.greyLight,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: AppColors.dark, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: AppColors.dark,
                  ),
                ),
                const SizedBox(height: 4),
                ...lines.map(
                  (l) => Text(
                    l,
                    style: const TextStyle(
                        fontSize: 13, color: AppColors.grey, height: 1.5),
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
