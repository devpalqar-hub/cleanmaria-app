import 'package:cleanby_maria/Screens/Admin/ClientScreen/Models/bookingModel.dart';
import 'package:cleanby_maria/Screens/Admin/ClientScreen/Service/BookingController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cleanby_maria/Screens/Admin/ClientScreen/Models/BookingDetailModel.dart';
import 'package:cleanby_maria/Src/appText.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:url_launcher/url_launcher.dart' show launchUrl;

class BStatusCard extends StatelessWidget {
  final BookingModel booking;
  BStatusCard({
    super.key,
    required this.booking,
  });


   BookingsController bCtrl = Get.put(BookingsController());

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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
           
              children: [
                appText.primaryText(
                  text: booking.customer!.name!,
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
                        text: (booking.subscriptionType != null)
                            ? "${booking.subscriptionType!.name!} |"
                            : "One Time | ",
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w500,
                        color:
                            // (booking.plan == "By weekly plan" ||
                            //         booking.plan == "2025 MAR 12")
                            const Color(0xFF19A4C6)
                        //: Colors.black,
                        ),
                        SizedBox(width: 140.w),
                   // appText.primaryText(
                     // text: (booking.subscriptionType != null)
                       //   ? booking.monthSchedules!
                         //    .map((value) =>
                           ///       "${bCtrl.weektoDay(value.dayOfWeek!)}, ${value.time!}} ")
                             // .join(",")
                        // : bCtrl.WeekDatetoDate(
                          ///    createdDate: DateTime.parse(booking.createdAt!),
                             // weekOfMonth:
                               //   booking.monthSchedules!.first.weekOfMonth!,
                             // dayOfWeek:
                               //   booking.monthSchedules!.first.dayOfWeek!),
                     // fontSize: 10.sp,
                      //fontWeight: FontWeight.w500,
                      //color: Colors.black,
                   // ),
                    Row(
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
                
              SizedBox(width: 20.h),
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
                    appText.primaryText(
                  text:
                      "${booking.bookingAddress!.address!.line1!}, ${booking.bookingAddress!.address!.city ?? ""} - ${booking.bookingAddress!.address!.zip ?? ""} ",
                  fontSize: 11.sp,
                  maxLines: 1,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
               
             
              ],
              
            ),
          ),
                    ],
            ),
          
        
      
    );
  }
}
