import 'package:cleanby_maria/Screens/Admin/ScheduleViewScreen/Models/ScheduleItemModel.dart';
import 'package:cleanby_maria/Screens/Admin/ScheduleViewScreen/ScheduleDetailsScreen.dart';
import 'package:cleanby_maria/Screens/Admin/ScheduleViewScreen/ScheduleViewScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/utils.dart';
import 'package:intl/intl.dart';

class ScheduleListCard extends StatelessWidget {
  bool makeClick = false;
  final ScheduleItemModel booking;

  ScheduleListCard({super.key, required this.booking, this.makeClick = true});

  Color get _statusColor {
    switch (booking.status!.toUpperCase()) {
      case 'COMPLETED':
        return const Color(0xFF18B9C5);
      case 'SCHEDULED':
        return const Color(0xFF0D0D0D);
      case 'CANCELLED':
        return const Color(0xFFE74C3C);
      case 'PENDING':
        return const Color(0xFFF39C12);
      default:
        return const Color(0xFF999999);
    }
  }

  Color get _statusBg {
    switch (booking.status!.toUpperCase()) {
      case 'COMPLETED':
        return const Color(0xFFE8F9FA);
      case 'SCHEDULED':
        return const Color(0xFFF0F0F0);
      case 'CANCELLED':
        return const Color(0xFFFEEEEE);
      case 'PENDING':
        return const Color(0xFFFFF8EC);
      default:
        return const Color(0xFFF5F5F5);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (!makeClick) {
          return;
        }
        Get.to(() => ScheduleDetailsScreen(
              schedule: booking,
              bookingID: booking.bookingId!,
              isAdmin: true,
            ));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 12,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            // Time Column
            SizedBox(
              width: 52,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Start',
                    style: TextStyle(
                      fontSize: 10,
                      color: Color(0xFFAAAAAA),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    DateFormat("hh:mm ")
                        .format(DateTime.parse(booking.startTime!)),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF0D0D0D),
                      letterSpacing: -0.5,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 8),

            // Divider
            Container(width: 1.5, height: 40, color: const Color(0xFFEEEEEE)),

            const SizedBox(width: 14),

            // Client Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    booking.booking!.customer!.name!,
                    maxLines: 1,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF0D0D0D),
                    ),
                  ),
                  const SizedBox(height: 3),
                  Row(
                    children: [
                      const Icon(Icons.person_outline,
                          size: 12, color: Color(0xFFAAAAAA)),
                      const SizedBox(width: 3),
                      Text(
                        '${booking.staff!.name!}',
                        maxLines: 1,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF888888),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(width: 10),

            // Status Badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: _statusBg,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                booking.status!,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  color: _statusColor,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
