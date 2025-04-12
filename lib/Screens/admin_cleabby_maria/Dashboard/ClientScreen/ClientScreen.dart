import 'package:cleanby_maria/Screens/admin_cleabby_maria/Dashboard/ClientScreen/BookingDetailsScreen.dart';
import 'package:cleanby_maria/Screens/admin_cleabby_maria/Dashboard/ClientScreen/Service/BookingController.dart';
import 'package:cleanby_maria/Screens/admin_cleabby_maria/Dashboard/ClientScreen/Views/BStatusCard.dart';
import 'package:cleanby_maria/Src/appText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
class ClientScreen extends StatefulWidget {
  const ClientScreen({super.key});

  @override
  State<ClientScreen> createState() => _ClientScreenState();
}


class _ClientScreenState extends State <ClientScreen> {
  final BookingsController bookingsController = Get.put(BookingsController());
  bool _isSubscriptionSelected = true; 

  @override
  void initState() {
    super.initState();
    _fetchBookings();
  }

  void _fetchBookings() {
    final type = _isSubscriptionSelected ? 'subscription' : 'instant';
    bookingsController.fetchBookings('booked', type);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.h),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_outlined, color: Colors.black),
            onPressed: () {},
          ),
          title: appText.primaryText(
            text: "Clients",
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10.h),
          // Toggle Subscription and One-Time Buttons
          Container(
            width: 343.w,
            height: 50.h,
            margin: EdgeInsets.only(left: 15.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              color: Colors.grey.shade400,
            ),
            child: Row(
              children: [
                // Subscriptions Button
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isSubscriptionSelected = true;
                    });
                  },
                  child: Container(
                    width: 169.w,
                    height: 46.h,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: _isSubscriptionSelected ? Colors.white : Colors.transparent,
                      border: Border.all(
                        color: Colors.grey.shade400,
                        width: 2.w,
                      ),
                    ),
                    child: appText.primaryText(
                      text: "Subscriptions",
                      color: _isSubscriptionSelected ? Colors.black : Colors.white,
                    ),
                  ),
                ),
                // One-Time Button
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isSubscriptionSelected = false;
                    });
                  },
                  child: Container(
                    width: 169.w,
                    height: 46.h,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: !_isSubscriptionSelected ? Colors.white : Colors.transparent,
                      border: Border.all(
                        color: Colors.grey.shade400,
                        width: 2.w,
                      ),
                    ),
                    child: appText.primaryText(
                      text: "One-Time",
                      color: !_isSubscriptionSelected ? Colors.black : Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 25.h),

          // Search Box
          Container(
            width: 343.w,
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
                appText.primaryText(
                  text: "Search for booking",
                  color: Colors.grey,
                ),
              ],
            ),
          ),
          SizedBox(height: 25.h),

          // Conditionally Render Subscription or One-Time Plans
          Expanded(
            child: Obx(() {
              if (bookingsController.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              }
              if (bookingsController.errorMessage.value.isNotEmpty) {
                return Center(child: Text(bookingsController.errorMessage.value));
              }
              return SingleChildScrollView(
                child: Column(
                  children: bookingsController.bookings.map((booking) => 
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => BookingDetailsScreen()),
                        );
                      },
                      child: BStatusCard(booking: booking),  // Correct way to pass individual booking
                    )
                  ).toList(),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
