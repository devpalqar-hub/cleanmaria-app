import 'package:cleanby_maria/Screens/Admin/ClientScreen/Models/BookingDetailModel.dart';
import 'package:cleanby_maria/Screens/Admin/ScheduleViewScreen/ScheduleDetailsScreen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

// Import your model and navigation screen
// import 'package:cleanby_maria/Models/BookingDetailModel.dart';
// import 'package:cleanby_maria/Screens/BookingDetailsScreen.dart';

class UserBookingCard extends StatelessWidget {
  final BookingDetailModel booking;

  const UserBookingCard({
    super.key,
    required this.booking,
  });

  // Format date and time from the booking date string
  String get _formattedDateTime {
    if (booking.date == null) return 'Date not set';
    try {
      final dateTime = DateTime.parse(booking.date!);
      return DateFormat('EEEE, h:mm a').format(dateTime);
    } catch (_) {
      return booking.date ?? 'Date not set';
    }
  }

  // Format price
  String get _formattedPrice {
    if (booking.price == null) return '\$0.00';
    try {
      final price = double.parse(booking.price!);
      return '\$${price.toStringAsFixed(2)}';
    } catch (_) {
      return '\$${booking.price}';
    }
  }

  // Format address
  String get _formattedAddress {
    final address = booking.bookingAddress?.address;
    if (address == null) return 'Address not provided';

    final parts = <String>[];
    if (address.line1 != null && address.line1!.isNotEmpty) {
      parts.add(address.line1!);
    }
    if (address.line2 != null && address.line2!.isNotEmpty) {
      parts.add(address.line2!);
    }

    if (address.city != null && address.city!.isNotEmpty) {
      parts.add(address.city!);
    }

    return parts.isEmpty ? 'Address not provided' : parts.join(', ');
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to booking details
        Get.to(() => ScheduleDetailsScreen(
              bookingID: booking.id!,
              isUser: true,
            ));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top row: Icon + Service name + Price
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Calendar icon
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE0F7F7),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.calendar_today_rounded,
                    size: 24,
                    color: Color(0xFF18B9C5),
                  ),
                ),

                const SizedBox(width: 14),

                // Service name + Date/Time
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Service name
                      Text(
                        booking.service?.name ?? 'Service',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF0D0D0D),
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 6),

                      // Date and time
                      Row(
                        children: [
                          const Icon(
                            Icons.access_time_rounded,
                            size: 14,
                            color: Color(0xFF999999),
                          ),
                          const SizedBox(width: 5),
                          Flexible(
                            child: Text(
                              _formattedDateTime,
                              style: const TextStyle(
                                fontSize: 13,
                                color: Color(0xFF999999),
                                fontWeight: FontWeight.w400,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 10),

                // Price
                Text(
                  _formattedPrice,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF0D0D0D),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 14),

            // Divider
            Container(
              height: 1,
              color: const Color(0xFFF2F2F2),
            ),

            const SizedBox(height: 14),

            // Address row
            Row(
              children: [
                const Icon(
                  Icons.location_on_outlined,
                  size: 16,
                  color: Color(0xFF999999),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    _formattedAddress,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xFF666666),
                      fontWeight: FontWeight.w400,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const Icon(
                  Icons.chevron_right_rounded,
                  size: 20,
                  color: Color(0xFFCCCCCC),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
