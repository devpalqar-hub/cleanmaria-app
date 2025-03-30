import 'package:cleanby_maria/Src/appText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StatusCard extends StatelessWidget {
  final String status;
  final Color color;
  final String customerName;
  final String time;
  final String location;
  final VoidCallback? onTap;

  const StatusCard({
    super.key,
    required this.status,
    required this.color,
    required this.customerName,
    required this.time,
    required this.location,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 352.w,
        height: 88.h,
        padding: EdgeInsets.all(10.w),
        margin: EdgeInsets.only(left: 15.w, bottom: 10.h),
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
                            text: customerName,
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
                                text: time,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF19A4C6),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(width: 50.w),
                      Container(
                        height: 24.h,
                        width: 82.w,
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Center(
                          child: Text(
                            status,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 3.h),
                  appText.primaryText(
                    text: location,
                    fontSize: 10.5.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
