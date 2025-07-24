import 'package:cleanby_maria/Src/appText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/src/extensions/export.dart';

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
      child: Center(
        child: Container(
          width: 352.w,
          // height: 88.h,
          padding: EdgeInsets.all(10.w),
          margin: EdgeInsets.only(bottom: 10.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 1),
                blurRadius: 4,
                spreadRadius: 0,
                color: Colors.black.withOpacity(0.1),
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
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
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFF19A4C6),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 3.h),
                    appText.primaryText(
                      text: location,
                      fontSize: 10.5.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.black87,
                    ),
                  ],
                ),
              ),
              Container(
                height: 26.h,
                width: 100.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Center(
                  child: Text(
                    status
                            .toString()
                            .replaceAll("_", " ")
                            .toString()
                            .capitalize ??
                        "",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
