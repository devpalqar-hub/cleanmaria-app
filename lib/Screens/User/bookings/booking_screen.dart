import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../booking_details/booking_details_screen.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  int selectedTab = 0; // 0-upcoming, 1-completed, 2-cancelled
  final Color primaryGreen = const Color(0xFF2F7F6F);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          "My Bookings",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),

      body: Column(
        children: [
          const SizedBox(height: 12),

          /// 🔹 TOP TABS
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                _tabButton("Upcoming", 0),
                _tabButton("Completed", 1),
                _tabButton("Cancelled", 2),
              ],
            ),
          ),

          const SizedBox(height: 16),

          /// 🔹 CONTENT
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                if (selectedTab == 0)
                  _bookingCard(
                    iconBg: const Color(0xFFE8F5F2),
                    icon: Icons.calendar_today,
                    title: "Standard Cleaning",
                    subtitle: "Today, 2:00 PM",
                    price: "\$85.00",
                    status: "Upcoming",
                    statusColor: Colors.green,
                  ),

                if (selectedTab == 1)
                  _bookingCard(
                    iconBg: const Color(0xFFEAF0FF),
                    icon: Icons.check_circle,
                    title: "Deep Cleaning",
                    subtitle: "Jan 15, 10:00 AM",
                    price: "\$140.00",
                    status: "Completed",
                    statusColor: Colors.blue,
                  ),

                if (selectedTab == 2)
                  _bookingCard(
                    iconBg: const Color(0xFFFCEAEA),
                    icon: Icons.cancel,
                    title: "Standard Cleaning",
                    subtitle: "Dec 22, 2:00 PM",
                    price: "\$85.00",
                    status: "Cancelled",
                    statusColor: Colors.red,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 🔹 TAB BUTTON
  Widget _tabButton(String text, int index) {
    final bool active = selectedTab == index;

    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => selectedTab = index),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: active ? primaryGreen : Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: active ? Colors.white : Colors.grey,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  /// 🔹 COMPACT BOOKING CARD (MATCHES DESIGN)
  Widget _bookingCard({
    required Color iconBg,
    required IconData icon,
    required String title,
    required String subtitle,
    required String price,
    required String status,
    required Color statusColor,
  }) {
    return GestureDetector(
      onTap: () {
        Get.to(() => const BookingDetailsScreen());
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// ICON
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: iconBg,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 18, color: primaryGreen),
            ),

            const SizedBox(width: 12),

            /// TEXT
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 14)),
                  const SizedBox(height: 4),
                  Text(subtitle,
                      style:
                      const TextStyle(color: Colors.grey, fontSize: 12)),
                  const SizedBox(height: 6),
                  const Text("123 Main St, Apt 4B",
                      style:
                      TextStyle(color: Colors.grey, fontSize: 12)),
                ],
              ),
            ),

            /// PRICE + STATUS
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(price,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14)),
                const SizedBox(height: 6),
                Text(
                  status,
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
