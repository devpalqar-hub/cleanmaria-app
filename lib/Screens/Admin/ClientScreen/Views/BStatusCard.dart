import 'package:cleanby_maria/Screens/Admin/ClientScreen/Models/bookingModel.dart';
import 'package:cleanby_maria/Screens/Admin/ClientScreen/Service/BookingController.dart';
import 'package:cleanby_maria/Src/appText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:url_launcher/url_launcher.dart';

class BStatusCard extends StatelessWidget {
  final BookingModel booking;
  final bool isCanceled;
  BStatusCard({super.key, required this.booking, this.isCanceled = false});

  final BookingsController bCtrl = Get.put(BookingsController());

  @override
  Widget build(BuildContext context) {
    final name = booking.customer?.name ?? 'Unknown';
    final status = booking.status ?? 'N/A';

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: Colors.grey.shade100,
        boxShadow: [BoxShadow(blurRadius: 4, color: Colors.black12)],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                appText.primaryText(
                  text: name,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
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
                      text: booking.reccuingType ?? "One Time",
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF19A4C6),
                    ),
                  ],
                ),
                SizedBox(height: 6.h),
                appText.primaryText(
                  text:
                      "${booking.bookingAddress!.address!.line1!}, ${booking.bookingAddress!.address!.city ?? ""} - ${booking.bookingAddress!.address!.zip ?? ""}",
                  fontSize: 11.sp,
                  maxLines: 1,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              InkWell(
                onTap: () {
                  launchUrl(Uri.parse("tel:${booking.customer!.phone!}"));
                },
                child: Image.asset(
                  "assets/call2.png",
                  height: 27.w,
                  width: 27.w,
                ),
              ),
              SizedBox(height: 10.h),
              appText.primaryText(
                text: "\$${booking.price!}",
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
