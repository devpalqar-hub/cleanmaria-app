//import 'package:cleanby_maria/Screens/admin_cleabby_maria/Dashboard/ClientScreen/BookingDetailsScreen.dart';
import 'package:cleanby_maria/Screens/admin_cleabby_maria/Dashboard/ClientScreen/BookingDetailsScreen.dart';
import 'package:cleanby_maria/Screens/staff_cleanbymaria/BookingScreen/BookingScreen.dart';
import 'package:cleanby_maria/Src/appText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ClientScreen extends StatefulWidget {
   ClientScreen({super.key});

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
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_outlined, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          title: appText.primaryText(text: "Clients", fontSize: 18.sp, fontWeight: FontWeight.w700),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        SizedBox(height: 10.h,),
          Container(
            width: 343.w,
            height: 50.h,
            margin: EdgeInsets.only(left: 15.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.w),
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
                      borderRadius: BorderRadius.circular(10.w),
                      color: _isSubscriptionSelected ? Colors.white : Colors.transparent,
                      border: Border.all(color: Colors.grey.shade400, width: 4.w),
                    ),
                    child: appText.primaryText(
                      text: "Subscriptions",
                      color: _isSubscriptionSelected ? Colors.black : Colors.white,
                    ),
                  ),
                ),
                SizedBox(width: 30.w),
                // One-Time Button
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isSubscriptionSelected = false;
                    });
                  },
                  
                  child: appText.primaryText(
                    text: "One-Time",
                    color: !_isSubscriptionSelected ? Colors.white : Colors.black,
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
              borderRadius: BorderRadius.circular(10.w),
              color: Colors.grey.shade200,
            ),
            child: Row(
              children: [
                SizedBox(width: 15.w),
                Icon(Icons.search),
                appText.primaryText(text: "Search for booking"),
              ],
            ),
          ),
          SizedBox(height: 25.h),

          // Conditionally Render Subscription or One-Time Plans
          if (_isSubscriptionSelected)
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BookingDetailsScreen()),
                );
              },
              child: _buildStatusCard("By weekly plan", "| 1M-2M=3S-4W", "Los Angeles, USA, 955032 - Washington DC.", "320"),
            )
          else
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BookingDetailsScreen()),
                );
              },
              child: _buildStatusCard("2025 MAR 12", "| Single Booking", "New York, USA, 10001", "120"),
            ),
        ],
      ),
    );
  }
}



Widget _buildStatusCard(String Plan, String time, String place, String price) {
  return Container(
    width: 352.w,
    height: 90.h,
    margin: EdgeInsets.only(left: 15.w),
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10.r),
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          offset: Offset(0, 4),
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
                    text: Plan,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: (Plan == "By weekly plan" || Plan == "2025 MAR 12") ? Color(0xFF19A4C6) : Colors.black,
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
              "assets/call.png",
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
        )
      ],
    ),
  );
}