import 'package:cleanby_maria/Screens/admin_cleabby_maria/Dashboard/HomeScreen/Services/homeController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OverViewCard extends StatefulWidget {
  OverViewCard({super.key});

  @override
  _OverViewCardState createState() => _OverViewCardState();
}

class _OverViewCardState extends State<OverViewCard> {
  final HomeController _controller = HomeController();

  @override
  void initState() {
    super.initState();
    _controller.fetchBusinessOverview(); // Fetch business overview data
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _buildOverviewItem(
              controller: _controller.totalBookings,
              imagePath: "assets/client.png",
              color: const Color(0xffE5FDF3),
              subtitle: "Total Bookings",
            ),
            SizedBox(width: 20.w),
            _buildOverviewItem(
              controller: _controller.totalRevenue,
              imagePath: "assets/earnings.png",
              color: const Color(0xffFDFDE5),
              subtitle: "Total Revenue",
            ),
            SizedBox(width: 20.w),
            _buildOverviewItem(
              controller: _controller.totalStaff,
              imagePath: "assets/person.png",
              color: const Color(0xffFDE5E5),
              subtitle: "Total Staff",
            ),
          ],
        ),
      ),
    );
  }

  // Helper function to create overview items
  Widget _buildOverviewItem({
    required ValueNotifier<int> controller,
    required String imagePath,
    required String subtitle,
    required Color color,
  }) {
    return ValueListenableBuilder<int>(
      valueListenable: controller,
      builder: (context, value, child) {
        return _overview(
          imagePath: imagePath,
          color: color,
          count: value.toString(),
          subtitle: subtitle,
        );
      },
    );
  }
}

// UI component for each overview item
Widget _overview({
  required String imagePath,
  required String count,
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
              count,
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
