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
             imagePath:"assets/home.png" ,
              color: Color(0xffE5FDF3
),
              count: "120",
              subtitle: "Total Clients"
              ,
            ),
            SizedBox(width: 20.w),
            _overview(
              imagePath: "assets/pie.png",
              color: Colors.green,
             
              count: "1200 ",
              subtitle: "Total Earnings",
            ),
             SizedBox(width: 20.w),
            _overview(
              imagePath: "assets/pie.png",
             color: Colors.green,
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
      padding: EdgeInsets.fromLTRB(18.w, 14.h, 18.w, 6.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.w),
        color: color,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 4),
           blurRadius: 10, 
        spreadRadius: 2, 
       
           
          )
        ],
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