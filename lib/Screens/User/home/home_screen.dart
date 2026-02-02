import 'package:flutter/material.dart';
import 'package:get/get.dart';

// 👉 ADD THESE IMPORTS
import '../new_booking/service_screen.dart';
import '../booking_details/booking_details_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const Color primaryGreen = Color(0xFF2F7F6F);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// 🔹 HEADER
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Good morning,", style: TextStyle(color: Colors.grey)),
                    SizedBox(height: 4),
                    Text(
                      "Maria",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: const [
                    Icon(Icons.notifications_none),
                    SizedBox(width: 12),
                    CircleAvatar(radius: 18),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 24),

            /// 🔹 BOOK A CLEANING CARD
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF2F7F6F),
                    Color(0xFF3B9A8B),
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Book a cleaning",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Schedule your next\nprofessional home cleaning in seconds.",
                    style: TextStyle(color: Colors.white70),
                  ),
                  const SizedBox(height: 16),

                  /// ✅ CLICKABLE NEW BOOKING BUTTON
                  GestureDetector(
                    onTap: () {
                      Get.to(() =>  ServiceScreen());
                    },
                    child: Container(
                      height: 46,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        "+ New Booking",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            /// 🔹 UPCOMING HEADER
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "Upcoming",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  "See all",
                  style: TextStyle(color: primaryGreen),
                ),
              ],
            ),

            const SizedBox(height: 12),

            /// ✅ CLICKABLE UPCOMING CARD
            GestureDetector(
              onTap: () {
                Get.to(() =>  BookingDetailsScreen());
              },
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        color: Color(0xFFE8F5F2),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.star, color: primaryGreen),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Standard Cleaning",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "Today, 2:00 PM",
                            style: TextStyle(color: Colors.grey),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "123 Main St, Apt 4B",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE8F5F2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        "Confirmed",
                        style: TextStyle(
                          color: primaryGreen,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 28),

            /// 🔹 YOUR STATUS
            const Text(
              "Your Status",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 12),

            Row(
              children: [
                _statusCard(
                  value: "12",
                  label: "Total Hours Saved",
                  bgColor: Color(0xFFF3F5FF),
                  icon: Icons.access_time,
                  iconColor: Colors.blue,
                ),
                const SizedBox(width: 12),
                _statusCard(
                  value: "4.9",
                  label: "Average Rating",
                  bgColor: Color(0xFFF1FBF6),
                  icon: Icons.star,
                  iconColor: primaryGreen,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _statusCard({
    required String value,
    required String label,
    required Color bgColor,
    required IconData icon,
    required Color iconColor,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: iconColor),
            const SizedBox(height: 12),
            Text(
              value,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
