import 'package:cleanby_maria/Screens/admin_cleabby_maria/Dashboard/ClientScreen/BookingDetailsScreen.dart';
import 'package:cleanby_maria/Screens/staff_cleanbymaria/BookingScreen/BookingScreen.dart';
import 'package:cleanby_maria/Src/appText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ClientScreen extends StatefulWidget {
  const ClientScreen({super.key});

  @override
  State<ClientScreen> createState() => _ClientScreenState();
}

class _ClientScreenState extends State<ClientScreen> {
  bool _isSubscriptionSelected = true; // Default selection

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
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if (_isSubscriptionSelected)
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => BookingDetailsScreen()),
                            );
                          },
                          child: _buildStatusCard(
                            "By weekly plan",
                            "| 1M-2M=3S-4W",
                            "Los Angeles, USA, 955032 - Washington DC.",
                            "320",
                          ),
                        ),
                      ],
                    )
                  else
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => BookingDetailsScreen()),
                            );
                          },
                          child: _buildStatusCard(
                            "2025 MAR 12",
                            "| Single Booking",
                            "New York, USA, 10001",
                            "120",
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Status Card Widget
  Widget _buildStatusCard(String plan, String time, String place, String price) {
    return Container(
      width: 352.w,
      height: 90.h,
      margin: EdgeInsets.only(left: 15.w, right: 15.w, bottom: 10.h),
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r), // ✅ Used 10.r here for flutter_screenutil
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 4),
            blurRadius: 10,
            spreadRadius: 2,
            color: Colors.black.withOpacity(0.1),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                appText.primaryText(
                  text: "Customer name",
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
                SizedBox(height: 3.h),
                Row(
                  children: [
                    Image.asset(
                      "assets/clock.png",
                      height: 15.h,
                      width: 15.w,
                    ),
                    SizedBox(width: 5.w),
                    appText.primaryText(
                      text: plan,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: (plan == "By weekly plan" || plan == "2025 MAR 12")
                          ? const Color(0xFF19A4C6)
                          : Colors.black,
                    ),
                    SizedBox(width: 5.w),
                    appText.primaryText(
                      text: time,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ],
                ),
                SizedBox(height: 3.h),
                appText.primaryText(
                  text: place,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/call2.png",
                height: 20.h,
                width: 20.w,
              ),
              SizedBox(height: 5.h),
              appText.primaryText(
                text: price,
                fontSize: 10.5.sp,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
