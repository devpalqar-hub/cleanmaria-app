import 'package:cleanby_maria/Src/appText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Dutycard extends StatelessWidget {
  const Dutycard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.h, // Set a height to avoid layout issues
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _buildDutyCard(),
            SizedBox(width: 18.w),
            _buildDutyCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildDutyCard() {
    return Container(
      width: 257.w,
      height: 88.h,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 4),
               blurRadius: 5, 
        spreadRadius: 2, 
        color: Colors.black.withOpacity(0.1), 
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                              text: "10:00 AM - 11:00 AM",
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF19A4C6),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(width: 67.w),
                    Image.asset(
                      "assets/call.png",
                      height: 27.h,
                      width: 27.w,
                    ),
                  ],
                ),
                SizedBox(height: 3.h),
                appText.primaryText(
                  text: "Los Angeles, USA, 955032 - Washington DC.",
                  fontSize: 10.5.sp,
                  fontWeight: FontWeight.w400,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
