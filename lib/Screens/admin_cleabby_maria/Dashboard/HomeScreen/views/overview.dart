import 'package:cleanby_maria/Src/appText.dart';
import 'package:cleanby_maria/Src/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class OverViewCard extends StatelessWidget {
   OverViewCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child:SingleChildScrollView( 
        scrollDirection: Axis.horizontal,
       child: Row(
          children: [
            _overview(
             imagePath:"assets/client.png" ,
              color: Color(0xffE5FDF3
),
              count: "120",
              subtitle: "Total Clients"
              ,
            ),
            SizedBox(width: 20.w),
            _overview(
              imagePath: "assets/earnings.png",
              color: Color(0xffFDFDE5
),
             
              count: "1200 ",
              subtitle: "Total Earnings",
            ),
             SizedBox(width: 20.w),
            _overview(
              imagePath: "assets/person.png",
             color: Color(0xffFDE5E5)
,
              count: "3",
              subtitle: "Total Staff",
            ),
        
          ],
        ),),
       
       
      );
   
  }
}

  Widget _overview({
    required String imagePath,
  
    required String count,
    required String subtitle,
    required color
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
              SpacerW(4.w),
              appText.primaryText(
                text: count,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
              SizedBox(height: 3.h),
         

            ],
          ),
           appText.primaryText(
            text: subtitle,
            fontSize: 10.sp,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
         
        ],
      ),
    );
  }