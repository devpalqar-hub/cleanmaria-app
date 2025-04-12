import 'package:cleanby_maria/Screens/admin_cleabby_maria/Dashboard/HomeScreen/Services/homeController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';

class OverViewCard extends StatelessWidget {
  OverViewCard({super.key});

  HomeController _controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            SizedBox(width: 4.w),
            _overview(
              count: _controller.totalBookings,
              imagePath: "assets/client.png",
              color: const Color(0xffE5FDF3),
              subtitle: "Total Clients",
            ),
            SizedBox(width: 15.w),
            _overview(
              count: _controller.summaryEarnings,
              imagePath: "assets/earnings.png",
              color: const Color(0xffFDFDE5),
              subtitle: "Total Revenue",
            ),
            SizedBox(width: 15.w),
            _overview(
              count: _controller.summaryStaff,
              imagePath: "assets/person.png",
              color: const Color(0xffFDE5E5),
              subtitle: "Total Staff",
            ),
          ],
        ),
      ),
    );
  }

// UI component for each overview item
  Widget _overview({
    required int count,
    required String imagePath,
    required String subtitle,
    required Color color,
  }) {
    return Container(
      width: 100.w,
      height: 60.h,
      margin: EdgeInsets.only(left: 5.w),
      alignment: Alignment.center,
      padding: EdgeInsets.only(left: 10.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.w),
        color: color,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Image.asset(imagePath, width: 16.w, height: 18.w),
              SizedBox(width: 4.w),
              Text(
                count.toString(),
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          SizedBox(height: 3.h),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 10.sp,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
