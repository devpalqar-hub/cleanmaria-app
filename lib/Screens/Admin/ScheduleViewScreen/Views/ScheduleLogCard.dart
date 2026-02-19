import 'package:cleanby_maria/Screens/Admin/ScheduleViewScreen/Models/ScheduleItemModel.dart';
import 'package:cleanby_maria/Screens/Admin/ScheduleViewScreen/ScheduleDetailsScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:intl/intl.dart';

enum CardRole { admin, staff, user }

class Schedulelogcard extends StatelessWidget {
  final ScheduleItemModel booking;
  final CardRole role;
  final bool makeClick;

  const Schedulelogcard({
    super.key,
    required this.booking,
    this.role = CardRole.admin,
    this.makeClick = true,
  });

  // ── Role-derived display values ────────────────────────────────────────────

  /// Main title shown on the card
  String get _title {
    switch (role) {
      case CardRole.user:
        // User sees who is coming → Staff name
        return booking.staff?.name ?? '—';
      case CardRole.staff:
        // Staff sees whose home → Customer name
        return booking.booking?.customer?.name ?? '—';
      case CardRole.admin:
        // Admin sees the customer
        return booking.booking?.customer?.name ?? '—';
    }
  }

  /// Subtitle shown below the title
  String get _subtitle {
    switch (role) {
      case CardRole.user:
        // User sees what service they booked
        return booking.booking?.service?.name ?? '—';
      case CardRole.staff:
        // Staff sees what service they will do
        return booking.booking?.service?.name ?? '—';
      case CardRole.admin:
        // Admin sees which staff member is assigned
        return booking.staff?.name ?? '—';
    }
  }

  /// Icon paired with the subtitle
  IconData get _subtitleIcon {
    switch (role) {
      case CardRole.user:
      case CardRole.staff:
        return Icons.cleaning_services_outlined;
      case CardRole.admin:
        return Icons.person_outline;
    }
  }

  // ── Status styling ─────────────────────────────────────────────────────────

  Color get _statusColor {
    switch ((booking.status ?? '').toUpperCase()) {
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
    switch ((booking.status ?? '').toUpperCase()) {
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

  // ── Time / date helpers ────────────────────────────────────────────────────

  String _formatTime(String? raw) {
    if (raw == null) return '—';
    try {
      return DateFormat('hh:mm a').format(DateTime.parse(raw));
    } catch (_) {
      return '—';
    }
  }

  String get _formattedDate {
    if (booking.startTime == null) return '—';
    try {
      return DateFormat('EEE, d MMM yyyy')
          .format(DateTime.parse(booking.startTime!));
    } catch (_) {
      return '—';
    }
  }

  // ── Navigation ─────────────────────────────────────────────────────────────

  void _onTap() {
    // if (!makeClick) return;
    // Get.to(() => ScheduleDetailsScreen(
    //       schedule: booking,
    //       bookingID: booking.bookingId ?? '',
    //       isAdmin: role == CardRole.admin,
    //       isStaff: role == CardRole.staff,
    //       isUser: role == CardRole.user,
    //     ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // ── Row 1 : Date  ←→  Status badge ─────────────────────────────
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.calendar_today_outlined,
                      size: 12, color: Color(0xFFAAAAAA)),
                  const SizedBox(width: 5),
                  Text(
                    _formattedDate,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF888888),
                    ),
                  ),
                ],
              ),
              // Status badge
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: _statusBg,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  booking.status ?? '—',
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

          const SizedBox(height: 12),
          const Divider(height: 1, thickness: 1, color: Color(0xFFF2F2F2)),
          const SizedBox(height: 12),

          // ── Row 2 : Time block | Title + Subtitle ───────────────────────
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Start / End time column
              _TimeBlock(
                startTime: _formatTime(booking.startTime),
                endTime: _formatTime(booking.endTime),
              ),

              // Vertical rule
              Container(
                width: 1.5,
                height: 50,
                margin: const EdgeInsets.symmetric(horizontal: 14),
                color: const Color(0xFFEEEEEE),
              ),

              // Title + Subtitle
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF0D0D0D),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Icon(_subtitleIcon,
                            size: 12, color: const Color(0xFFAAAAAA)),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            _subtitle,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color(0xFF888888),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Chevron
              if (makeClick)
                const Icon(Icons.chevron_right_rounded,
                    size: 18, color: Color(0xFFCCCCCC)),
            ],
          ),
        ],
      ),
    );
  }
}

// ── _TimeBlock ─────────────────────────────────────────────────────────────────

class _TimeBlock extends StatelessWidget {
  final String startTime;
  final String endTime;

  const _TimeBlock({required this.startTime, required this.endTime});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _timeChip(label: 'Start', time: startTime, isPrimary: true),
        const SizedBox(height: 5),
        Container(width: 1, height: 8, color: const Color(0xFFDDDDDD)),
        const SizedBox(height: 5),
        _timeChip(label: 'End', time: endTime, isPrimary: false),
      ],
    );
  }

  Widget _timeChip({
    required String label,
    required String time,
    required bool isPrimary,
  }) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 9,
            color: Color(0xFFBBBBBB),
            fontWeight: FontWeight.w500,
            letterSpacing: 0.4,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          time,
          style: TextStyle(
            fontSize: 12,
            fontWeight: isPrimary ? FontWeight.w700 : FontWeight.w500,
            color:
                isPrimary ? const Color(0xFF0D0D0D) : const Color(0xFF888888),
            letterSpacing: -0.3,
          ),
        ),
      ],
    );
  }
}
