import 'package:cleanby_maria/Screens/Admin/HomeScreen/Services/homeController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OverViewCard extends StatelessWidget {
  OverViewCard({super.key});

  final HomeController _controller = Get.find<HomeController>(); // ✅ Use existing controller

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (controller) {
      return SizedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _overview(
              count: controller.totalClients.toString(),
              imagePath: "assets/client.png",
              color: const Color(0xffE5FDF3),
              subtitle: "Total Clients",
            ),
            SizedBox(width: 7.w),
            _overview(
              count: "₹${controller.totalEarnings.toStringAsFixed(2)}", // ✅ Format safely
              imagePath: "assets/earnings.png",
              color: const Color(0xffFDFDE5),
              subtitle: "Total Revenue",
            ),
            SizedBox(width: 7.w),
            _overview(
              count: controller.totalStaff.toString(),
              imagePath: "assets/person.png",
              color: const Color(0xffFDE5E5),
              subtitle: "Total Staff",
            ),
          ],
        ),
      );
    });
  }

  Widget _overview({
    required String count,
    required String imagePath,
    required String subtitle,
    required Color color,
  }) {
    return Container(
      width: 112.w,
      alignment: Alignment.center,
      padding: EdgeInsets.all(10.w),
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
              SizedBox(width: 10.w),
              Text(
                count,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          SizedBox(height: 3.h),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
