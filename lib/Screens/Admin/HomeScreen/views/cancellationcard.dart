import 'package:cleanby_maria/Screens/Admin/ClientScreen/BookingDetailsScreen.dart';
import 'package:cleanby_maria/Screens/Admin/ClientScreen/Views/StatusCard.dart';
import 'package:cleanby_maria/Screens/Admin/HomeScreen/Services/homeController.dart';
import 'package:cleanby_maria/Src/appText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';

class Cancellationcard extends StatelessWidget {
  Cancellationcard({super.key});

  HomeController hctlr = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: SingleChildScrollView(
        child: Column(
          children: [
            for (var data in hctlr.history)
              StatusCard(
                  status: data.status ?? "Unknown",
                  color: hctlr.getStatusColor(data.status!),
                  customerName: data.booking!.customer!.name ??"Unknown",
                  onTap: () {
                    Get.to(
                        () => BookingDetailsScreen(
                              bookingId: data.booking!.id!,
                              staff: data.staff!.name,
                              scheduleId: data.id,
                              pCtrl: hctlr, 
                              status: data.status ?? "Unknown",
                              date:
                                  "${DateFormat("MMM dd,yyyy | hh:mm a").format(DateTime.parse(data.startTime!))} - ${DateFormat("hh:mm a").format(DateTime.parse(data.endTime!))}",
                            ),
                        transition: Transition.rightToLeft);
                  },
                  time:
                      "${DateFormat("MMM dd,yyyy | hh:mm a").format(DateTime.parse(data.startTime!))} - ${DateFormat("hh:mm a").format(DateTime.parse(data.endTime!))}",
                  location: "Cleaned By : ${data.staff!.name}"),
          ],
        ),
      ),
    );
  }
}

Widget _buildStatusCard(String status, Color color) {
  return Container(
    width: 360.w,
    height: 85.h,
    padding: EdgeInsets.all(8.w),
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
                        text: "Customer name",
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                      SizedBox(height: 2.h),
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
                  SizedBox(width: 100.w),
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
