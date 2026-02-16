import 'package:cleanby_maria/Screens/Admin/ClientScreen/Models/BookingDetailModel.dart';
import 'package:cleanby_maria/Screens/Admin/ScheduleViewScreen/ScheduleDetailsScreen.dart';
import 'package:cleanby_maria/Screens/Admin/ScheduleViewScreen/Controller/ScheduleDetailsController.dart';
import 'package:cleanby_maria/Screens/Admin/ScheduleViewScreen/Models/ScheduleItemModel.dart';
import 'package:cleanby_maria/Screens/User/new_booking/date_time_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class BottomActionBar extends StatelessWidget {
  final BookingDetailModel booking;
  final bool isStaff;
  final bool isAdmin;
  final bool isUser;
  final ScheduleItemModel? schedule;

  BottomActionBar({
    required this.booking,
    this.isStaff = false,
    this.isAdmin = false,
    this.isUser = false,
    this.schedule,
  });

  void _showChangeStatus(BuildContext context) {
    final List<Map<String, String>> allStatuses = [
      {'display': 'Scheduled', 'value': 'scheduled'},
      {'display': 'In Progress', 'value': 'in_progress'},
      {'display': 'Completed', 'value': 'completed'},
      {'display': 'Missed', 'value': 'missed'},
      {'display': 'Cancelled', 'value': 'canceled'},
      {'display': 'Payment Failed', 'value': 'payment_failed'},
      {'display': 'Refunded', 'value': 'refunded'},
      {'display': 'Rescheduled', 'value': 'rescheduled'},
      {'display': 'Payment Success', 'value': 'payment_success'},
    ];

    final List<Map<String, String>> staffStatuses = [
      {'display': 'In Progress', 'value': 'in_progress'},
      {'display': 'Completed', 'value': 'completed'},
      {'display': 'Cancelled', 'value': 'canceled'},
      {'display': 'Payment Success', 'value': 'payment_success'},
      {'display': 'Payment Failed', 'value': 'payment_failed'},
    ];

    final availableStatuses = isAdmin ? allStatuses : staffStatuses;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 36),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                      color: AppColors.divider,
                      borderRadius: BorderRadius.circular(2)),
                ),
              ),
              const SizedBox(height: 20),
              const Text('Change Status',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: AppColors.dark)),
              const SizedBox(height: 16),
              ...availableStatuses.map(
                (statusMap) {
                  final display = statusMap['display']!;
                  final value = statusMap['value']!;
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(
                      value == 'scheduled'
                          ? Icons.schedule_rounded
                          : value == 'in_progress'
                              ? Icons.autorenew_rounded
                              : value == 'completed'
                                  ? Icons.check_circle_outline_rounded
                                  : value == 'canceled'
                                      ? Icons.cancel_outlined
                                      : value == 'payment_success'
                                          ? Icons.payment_rounded
                                          : Icons.info_outline_rounded,
                      color: (value == 'canceled' || value == 'payment_failed')
                          ? AppColors.red
                          : value == 'completed'
                              ? Colors.green
                              : AppColors.teal,
                    ),
                    title: Text(display,
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600)),
                    onTap: () async {
                      if (schedule != null) {
                        Navigator.pop(ctx);

                        final ctrl = Get.find<ScheduleDetailsController>();
                        final success = await ctrl.updateScheduleStatus(
                            schedule!.id!, value);
                        if (success) {
                          Fluttertoast.showToast(
                            msg: 'Status updated to $display',
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: Colors.green,
                            textColor: Colors.white,
                          );
                        } else {
                          Fluttertoast.showToast(
                            msg: 'Failed to update status',
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: AppColors.red,
                            textColor: Colors.white,
                          );
                        }
                      }
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showCancelConfirm(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Cancel Booking?',
            style:
                TextStyle(fontWeight: FontWeight.w800, color: AppColors.dark)),
        content: const Text(
          'Are you sure you want to cancel this booking? This action cannot be undone.',
          style: TextStyle(color: AppColors.grey, height: 1.5),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
            },
            child: const Text('Keep Booking',
                style: TextStyle(
                    color: AppColors.teal, fontWeight: FontWeight.w700)),
          ),
          TextButton(
            onPressed: () {
              ScheduleDetailsController ctrl = Get.find();
              ctrl.cancelBooking(booking.id!);
              Navigator.pop(ctx);
            },
            child: const Text('Cancel',
                style: TextStyle(
                    color: AppColors.red, fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: AppColors.divider)),
        ),
        child: Row(
          children: [
            // Change Status (only show if schedule exists)
            if (schedule != null)
              Expanded(
                child: _ActionButton(
                  label: 'Change Status',
                  icon: Icons.swap_horiz_rounded,
                  textColor: AppColors.teal,
                  borderColor: AppColors.teal,
                  onTap: () => _showChangeStatus(context),
                ),
              ),
            if (schedule != null) const SizedBox(width: 10),

            // Reschedule
            Expanded(
              child: _ActionButton(
                label: 'Reschedule',
                icon: Icons.calendar_month_outlined,
                textColor: AppColors.dark,
                borderColor: AppColors.divider,
                onTap: () {
                  String duration =
                      ((booking!.areaSize! * booking!.service!.duration!) / 500)
                          .round()
                          .toString();
                  Get.to(
                    () => DateTimeScreen(
                      bookingID: booking.id!,
                      isForReschedule: true,
                      zipcode: booking.bookingAddress!.address!.zip!,
                      serviceID: booking!.service!.id!,
                      duration: duration,
                      maxDays: (booking.reccuingType == "Bi-Weekly") ? 15 : 7,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(width: 10),

            // Cancel Booking
            Expanded(
              child: _ActionButton(
                label: 'Cancel',
                icon: Icons.close_rounded,
                textColor: AppColors.red,
                borderColor: AppColors.red.withOpacity(0.3),
                onTap: () => _showCancelConfirm(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color textColor;
  final Color borderColor;
  final VoidCallback onTap;

  const _ActionButton({
    required this.label,
    required this.icon,
    required this.textColor,
    required this.borderColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(color: borderColor),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 18, color: textColor),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                  fontSize: 10, fontWeight: FontWeight.w600, color: textColor),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
