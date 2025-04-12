import 'package:cleanby_maria/Screens/admin_cleabby_maria/Dashboard/ClientScreen/Models/bookingModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cleanby_maria/Src/appText.dart';

class BStatusCard extends StatelessWidget {
  final Booking booking;  

  const BStatusCard({
    required this.booking,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 352.w,
      height: 90.h,
      margin: EdgeInsets.only(left: 15.w, right: 15.w, bottom: 10.h),
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
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
                  text: booking.name, 
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
                      text: booking.plan, 
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: (booking.plan == "By weekly plan" || booking.plan == "2025 MAR 12")
                          ? const Color(0xFF19A4C6)
                          : Colors.black,
                    ),
                    SizedBox(width: 5.w),
                    appText.primaryText(
                      text: booking.time,  
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ],
                ),
                SizedBox(height: 3.h),
                appText.primaryText(
                  text: booking.place,  
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
                text: booking.price,  
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
