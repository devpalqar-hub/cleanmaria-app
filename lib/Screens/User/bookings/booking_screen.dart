import 'package:cleanby_maria/Screens/User/bookings/Controller/UserBookingController.dart';
import 'package:cleanby_maria/Screens/User/bookings/Views/UserBookingCard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  int selectedTab = 0;
  final Color primaryGreen = const Color(0xFF2F7F6F);

  UserBookingcontroller ctrl = Get.put(UserBookingcontroller());

  @override
  Widget build(BuildContext context) {
    ctrl.fetchUserBooking();
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "My Bookings",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w600, fontSize: 18),
        ),
        // centerTitle: true,
      ),
      body: SafeArea(
        child: GetBuilder<UserBookingcontroller>(builder: (context) {
          return (ctrl.isLoading)
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  children: [
                    const SizedBox(height: 12),

                    /// TOP TABS
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 16),
                    //   child: Row(
                    //     children: [
                    //       _tabButton("Upcoming", 0),
                    //       _tabButton("Completed", 1),
                    //       _tabButton("Cancelled", 2),
                    //     ],
                    //   ),
                    // ),

                    /// API LIST
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: ctrl.myBookings.length,
                        itemBuilder: (_, i) {
                          var item = ctrl.myBookings[i];

                          return UserBookingCard(
                            booking: item,
                          );
                          //  _bookingCard(
                          //   iconBg: const Color(0xFFE8F5F2),
                          //   icon: Icons.calendar_today,
                          //   title: item.service!.name ?? "",
                          //   subtitle: DateFormat("yyyy-MM-dd")
                          //           .format(DateTime.parse(item.date!)) ??
                          //       "",
                          //   price: "\$${item.price ?? 0}",
                          //   status:
                          //       item.status!.replaceAll("_", " ").toUpperCase() ?? "",
                          //   statusColor: Colors.green,
                          // );
                        },
                      ),
                    )
                  ],
                );
        }),
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
  }}