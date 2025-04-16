import 'package:cleanby_maria/Screens/Admin/ClientScreen/BookingDetailsScreen.dart';
import 'package:cleanby_maria/Screens/Admin/HistoryScreen/Models/HistoryModel.dart';
import 'package:cleanby_maria/Screens/staff/Controller/SHomeController.dart';
import 'package:cleanby_maria/Src/appText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class Dutycard extends StatelessWidget {
  Dutycard({super.key});

  StaffHomeController sHCtrl = Get.put(StaffHomeController());

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.h, // Set a height to avoid layout issues
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            for (var data in sHCtrl.todayHistory) _buildDutyCard(data),
          ],
        ),
      ),
    );
  }

  Widget _buildDutyCard(HistoryModel history) {
    return InkWell(
      onTap: () {
        Get.to(
            () => BookingDetailsScreen(
                  bookingId: history.booking!.id!,
                  staff: history.staff!.name,
                  isStaff: true,
                  scheduleId: history.id,
                  status: history.status ?? "Unknown",
                  date:
                      "${DateFormat("MMM dd,yyyy | hh:mm a").format(DateTime.parse(history.startTime!))} - ${DateFormat("hh:mm a").format(DateTime.parse(history.endTime!))}",
                ),
            transition: Transition.rightToLeft);
      },
      child: Container(
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
                            text: history.booking!.customer!.name!,
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
                                text:
                                    "${DateFormat("hh:mm a").format(DateTime.parse(history.startTime!))} - ${DateFormat("hh:mm a").format(DateTime.parse(history.endTime!))}",
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF19A4C6),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Spacer(),
                      InkWell(
                        onTap: () {
                          launchUrl(Uri.parse(
                              "tel:${history.booking!.customer!.phone ?? "+1"}"));
                        },
                        child: Image.asset(
                          "assets/call.png",
                          height: 27.h,
                          width: 27.w,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 3.h),
                  appText.primaryText(
                    text: history.booking!.service!.name,
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
