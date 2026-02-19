import 'package:cleanby_maria/Screens/Admin/BookingScreen/BookingScreen.dart';
import 'package:cleanby_maria/Screens/Admin/ClientScreen/ClientBookingDetailsScreen.dart';
import 'package:cleanby_maria/Screens/Admin/ClientScreen/Models/bookingModel.dart';
import 'package:cleanby_maria/Screens/Admin/ClientScreen/Service/BookingController.dart';
import 'package:cleanby_maria/Screens/Admin/ClientScreen/BookingDetailsScreen.dart';
import 'package:cleanby_maria/Screens/Admin/ScheduleViewScreen/Controller/ScheduleDetailsController.dart';
import 'package:cleanby_maria/Screens/Admin/ScheduleViewScreen/ScheduleDetailsScreen.dart';
import 'package:cleanby_maria/Screens/Admin/ServiceScreen/ServiceScreen.dart';
import 'package:cleanby_maria/Screens/User/new_booking/Controllers/CreateBookingController.dart';
import 'package:cleanby_maria/Screens/User/new_booking/service_screen.dart';
import 'package:cleanby_maria/Src/appText.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ClientScreen extends StatefulWidget {
  const ClientScreen({super.key});

  @override
  State<ClientScreen> createState() => _ClientScreenState();
}

class _ClientScreenState extends State<ClientScreen> {
  final BookingsController bookingsController = Get.put(BookingsController());
  final TextEditingController searchController = TextEditingController();

  int selectedMenu = 0;

  @override
  void initState() {
    super.initState();
    bookingsController.fetchBookings("booked", "recurring");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Bookings",
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.blue),
            onPressed: () {
              //  Get.to(() => EstimateScreen());

              Get.to(() => CreateBookingScreen(
                    isAdmin: true,
                  ));
            },
          )
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 10.h),

          /// SEARCH
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: TextField(
              controller: searchController,
              onChanged: (_) => setState(() {}),
              decoration: InputDecoration(
                hintText: "Search...",
                filled: true,
                fillColor: Colors.grey.shade100,
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          SizedBox(height: 20.h),

          /// SEGMENTS
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              children: [
                _segment("SUBSCRIPTION", selectedMenu == 0, () {
                  setState(() => selectedMenu = 0);
                  bookingsController.fetchBookings("booked", "recurring");
                }),
                SizedBox(width: 20.w),
                _segment("ONE-TIME", selectedMenu == 1, () {
                  setState(() => selectedMenu = 1);
                  bookingsController.fetchBookings("booked", "one_time");
                }),
              ],
            ),
          ),

          SizedBox(height: 10.h),

          /// LIST
          Expanded(
            child: GetBuilder<BookingsController>(
              builder: (_) {
                if (bookingsController.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (bookingsController.errorMessage.isNotEmpty) {
                  return Center(
                    child: Text(bookingsController.errorMessage),
                  );
                }

                final List<BookingModel> list = bookingsController.bookings;

                return ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    final booking = list[index];
                    final name = booking.customer?.name ?? "N/A";

                    if (searchController.text.isNotEmpty &&
                        !name
                            .toLowerCase()
                            .contains(searchController.text.toLowerCase())) {
                      return const SizedBox.shrink();
                    }

                    return _BookingListTile(
                      booking: booking,
                      onTap: () {
                        Get.to(
                            () => ScheduleDetailsScreen(
                                  bookingID: booking.id!,
                                  isAdmin: true,
                                ),
                            transition: Transition.rightToLeft);
                        // Get.to(() => BookingDetailsScreen(
                        //       bookingId: booking.id!,
                        //     ));
                      },
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

  Widget _segment(String text, bool selected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
          color: selected ? Colors.black : Colors.grey,
        ),
      ),
    );
  }
}

/// ================= LIST TILE UI =================

class _BookingListTile extends StatelessWidget {
  final BookingModel booking;
  final VoidCallback onTap;

  const _BookingListTile({
    required this.booking,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final name = booking.customer?.name ?? "N/A";
    final initials = name.isNotEmpty
        ? name.trim().split(" ").map((e) => e[0]).take(2).join()
        : "NA";

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 15.h),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(color: Colors.black.withOpacity(.05)))),
        child: Row(
          children: [
            /// AVATAR
            CircleAvatar(
              radius: 20,
              backgroundColor: Colors.grey.shade200,
              child: Text(
                initials,
                style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff99A1AF)),
              ),
            ),

            SizedBox(width: 14.w),

            /// NAME + ADDRESS
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    overflow: TextOverflow.clip,
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "${booking.bookingAddress?.address?.line1 ?? ""}",
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),

            /// PRICE + TYPE
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "\$${booking.price ?? 0}",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  booking.reccuingType ?? "ONE-TIME",
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: Colors.grey,
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
