import 'package:cleanby_maria/Screens/admin_cleabby_maria/Dashboard/HomeScreen/Services/homeController.dart';
import 'package:cleanby_maria/Src/appText.dart';
import 'package:cleanby_maria/Src/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class detailcardScreen extends StatefulWidget {
  const detailcardScreen({super.key});

  @override
  State<detailcardScreen> createState() => _detailcardScreenState();
}

class _detailcardScreenState extends State<detailcardScreen> {
  final HomeController _controller = HomeController();

  @override
  void initState() {
    super.initState();
    _controller.fetchPerformanceData();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Map<String, dynamic>>(
      valueListenable: _controller.performanceData,
      builder: (context, data, _) {
        final booking = data['booking']?.toString() ?? "0";
        final allocation = data['allocation']?.toString() ?? "0";
        final cancellation = data['cancellation']?.toString() ?? "0";

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _detailcard(
                Title: "Booking",
                count: booking,
                subtitle: "Total Booking/Day",
              ),
              SizedBox(width: 5.w),
              _detailcard(
                Title: "Allocation",
                count: allocation,
                subtitle: "Avg staff/Booking",
              ),
              SizedBox(width: 5.w),
              _detailcard(
                Title: "Cancellation",
                count: cancellation,
                subtitle: "Cancelled/Booking",
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _detailcard({
    required String Title,
    required String count,
    required String subtitle,
  }) {
    return Container(
      width: 105.w,
      height: 74.h,
      padding: EdgeInsets.only(left: 10.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.w),
        color: const Color(0xffF6F6F6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SpacerW(4.w),
          Text(
            Title,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w700,
              color: Colors.black,
              fontFamily: "NunitoSans",
            ),
          ),
          SizedBox(height: 3.h),
          Text(
            count,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              color: Colors.black,
              fontFamily: "NunitoSans",
            ),
          ),
          SizedBox(height: 3.h),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 9.sp,
              fontWeight: FontWeight.w500,
              color: Colors.black,
              fontFamily: "NunitoSans",
            ),
          ),
        ],
      ),
    );
  }
}
