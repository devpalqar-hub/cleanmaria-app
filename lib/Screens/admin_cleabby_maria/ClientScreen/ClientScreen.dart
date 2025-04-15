import 'package:cleanby_maria/Screens/admin_cleabby_maria/ClientScreen/Views/BStatusCard.dart';
import 'package:cleanby_maria/Src/appText.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'BookingDetailsScreen.dart';
import 'Service/BookingController.dart';

class ClientScreen extends StatefulWidget {
  const ClientScreen({super.key});

  @override
  State<ClientScreen> createState() => _ClientScreenState();
}

class _ClientScreenState extends State<ClientScreen> {
  final BookingsController bookingsController = Get.put(BookingsController());
  final TextEditingController searchController = TextEditingController();
  // bool _isSubscriptionSelected = true;

  int selectedMenu = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        //  elevation: 0,
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back_ios_new_outlined,
        //       color: Colors.black),
        //   onPressed: () {
        //     Navigator.pop(context);
        //   },
        // ),
        title: appText.primaryText(
          text: "Bookings",
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10.h),

          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 16.w),
            width: 360.w,
            child: CupertinoSlidingSegmentedControl(
              proportionalWidth: true,
              children: {
                0: SizedBox(
                  width: 178.w,
                  height: 46.h,
                  child: Center(child: Text("Subscription")),
                ),
                1: SizedBox(
                  width: 178.w,
                  height: 46.h,
                  child: Center(child: Text("One-Time")),
                ),
              },
              groupValue: selectedMenu,
              onValueChanged: (value) {
                if (value != null) {
                  setState(() {
                    selectedMenu = value;
                    if (value == 0) {
                      bookingsController.fetchBookings(
                          "booked", "subscription");
                    } else {
                      bookingsController.fetchBookings("booked", "instant");
                    }
                  });
                }
              },
            ),
          ),

          SizedBox(height: 10.h),
          Container(
            width: 360.w,
            height: 50.h,
            margin: EdgeInsets.only(left: 15.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              color: Colors.grey.shade200,
            ),
            child: Row(
              children: [
                SizedBox(width: 15.w),
                const Icon(Icons.search, color: Colors.black),
                SizedBox(width: 10.w),
                Expanded(
                    child: TextField(
                  controller: searchController,
                  onChanged: (value) {
                    setState(() {});
                  },
                  decoration: InputDecoration(
                      border: InputBorder.none, hintText: "Search Clients"),
                ))
              ],
            ),
          ),
          SizedBox(height: 25.h),

          // Booking List
          GetBuilder<BookingsController>(builder: (context) {
            if (bookingsController.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (bookingsController.errorMessage.isNotEmpty) {
              return Center(child: Text(bookingsController.errorMessage));
            }
            return Expanded(
              child: ListView.builder(
                  itemCount: bookingsController.bookings.length,
                  itemBuilder: (context, index) {
                    final booking = bookingsController.bookings[index];
                    return (searchController.text.isEmpty ||
                            booking.customer!.name!
                                .toLowerCase()
                                .contains(searchController.text.toLowerCase()))
                        ? GestureDetector(
                            onTap: () {
                              {
                                Get.to(() => BookingDetailsScreen(
                                    bookingId: booking.id!));
                              }
                            },
                            child: BStatusCard(booking: booking),
                          )
                        : Container();
                  }),
            );
          }),
        ],
      ),
    );
  }
}
