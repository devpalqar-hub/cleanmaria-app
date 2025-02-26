import 'package:cleanby_maria/Src/appText.dart';
import 'package:cleanby_maria/Src/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OverViewCard extends StatelessWidget {
  const OverViewCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
    // height: 300.h, 
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _buildCard(
              imagePath: "assets/pie.png",
              title: "Duty\nAssigned",
              count: "10 nos",
              subtitle: "Total Duty Assigned",
            ),
            SizedBox(width: 20.w),
            _buildCard(
              imagePath: "assets/pie.png",
              title: "Duty\nCompleted",
              count: "4 nos",
              subtitle: "Total Duty Today",
            ),
        
          ],
        ),
      ),
    );
  }

  Widget _buildCard({
    required String imagePath,
    required String title,
    required String count,
    required String subtitle,
  }) {
    return Container(
      width: 164.w,
      height: 90.h,
      padding: EdgeInsets.fromLTRB(18.w, 14.h, 18.w, 6.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 4),
           blurRadius: 10, 
        spreadRadius: 2, 
        color: Colors.black.withOpacity(0.1), 
           
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Image.asset(imagePath, width: 24.w, height: 24.w),
              SpacerW(4.w),
              appText.primaryText(
                text: title,
                fontSize: 10.sp,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ],
          ),
          SizedBox(height: 3.h),
          appText.primaryText(
            text: count,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
          SizedBox(height: 1.2.h),
          appText.primaryText(
            text: subtitle,
            fontSize: 8.sp,
            fontWeight: FontWeight.w300,
            color: Colors.black,
          ),
        ],
      ),
    );
  }
}
