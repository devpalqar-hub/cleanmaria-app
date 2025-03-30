import 'package:cleanby_maria/Src/appText.dart';
import 'package:cleanby_maria/Src/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class detailcardScreen extends StatelessWidget {
   detailcardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
  
      child:SingleChildScrollView( 
        scrollDirection: Axis.horizontal,
       child: Row(
          children: [
            _detailcard(
              Title: "Booking",
             
              count: "12",
              subtitle: "Total Booking/Day",
            ),
            SizedBox(width: 5.w),
            _detailcard(
             Title: "Allocation",
             
              count: "12",
              subtitle: "Avg staff/Booking",
            ),
             SizedBox(width: 5.w),
            _detailcard(
             Title: "Cancellation",
             
              count: "1",
              subtitle: "Cancelled Booking",
            ),
        
          ],
        ),),
       
       
      );
   
  }
}

  Widget _detailcard({
    required String  Title,
  
    required String count,
    required String subtitle,
  }) {
    return Container(
      width: 105.w,
      height: 72.h,
      padding: EdgeInsets.only(left:5.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.w),
       color: Color(0xffF6F6F6),
       border: Border.all(color: Colors.grey.shade300,width: 0.5.w)
      
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
             crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
            
              SpacerW(4.w),
              appText.primaryText(
                text: Title,
                fontSize: 12.sp,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
              SizedBox(height: 3.h),
          appText.primaryText(
            text: count,
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),SizedBox(height: 3.h),
           appText.primaryText(
            text: subtitle,
            fontSize: 10.sp,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),

            ],
          ),
          
         
        ],
      ),
    );
  }