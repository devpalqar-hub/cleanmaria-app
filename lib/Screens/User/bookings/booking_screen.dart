import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../services/booking_service.dart';
import '../booking_details/booking_details_screen.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {

  int selectedTab = 0;
  final Color primaryGreen = const Color(0xFF2F7F6F);

  late Future bookingsFuture;

  @override
  void initState() {
    super.initState();
    bookingsFuture = BookingService.getBookings();
  }

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

        /// TOP TABS
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

        /// API LIST
        Expanded(
            child: FutureBuilder(
                future: bookingsFuture,
                builder: (context, snapshot) {

                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  var bookings = snapshot.data as List;

                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: bookings.length,
                    itemBuilder: (_, i) {
                      var item = bookings[i];

                      return _bookingCard(
                        iconBg: const Color(0xFFE8F5F2),
                        icon: Icons.calendar_today,
                        title: item["service"] ?? "",
                        subtitle: item["date"] ?? "",
                        price: "\$${item["price"] ?? 0}",
                        status: item["status"] ?? "",
                        statusColor: Colors.green,
                      );
                    },
                  );
                },
            ),
        ),
            ],
        ),
    );
  }

  /// TAB BUTTON
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

  /// BOOKING CARD
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
          children: [
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
            Expanded(
              child: Text(title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 14)),
            ),
            Text(price),
          ],
        ),
      ),
    );
  }
}



