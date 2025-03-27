import 'package:cleanby_maria/Src/appText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(preferredSize: Size.fromHeight(70.h), child: AppBar(
        leading: Icon(Icons.arrow_back_ios),
        title: appText.primaryText(text: "Clients",fontSize: 18.sp,fontWeight: FontWeight.w700 ),
      )),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 343.w,
            height: 50.h,
            margin: EdgeInsets.only(left: 15.w),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.w),color: Colors.grey.shade400),
            child: Row(
              children: [
                Container(width: 169.w,
                height:46.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.w),color: Colors.white,border: Border.all(color:Colors.grey.shade400,width: 4.w )),
                child: appText.primaryText(text: "Subscriptions"),

                ),
                SizedBox(width: 30.w,),
                appText.primaryText(text: "One-Time"),
              ],
            ),
          ),
          SizedBox(height: 25.h,),
          Container(
            width: 343.w,
            height: 50.h,
              margin: EdgeInsets.only(left: 15.w),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.w),color: Colors.grey.shade200),
            child: Row(
              children: [
                SizedBox(width: 15.w,),
                Icon(Icons.search),
                appText.primaryText(text: "Search for booking"),
              ],
            ),
          ),
           SizedBox(height: 25.h,),
         _buildStatusCard("By weekly plan", "1M-2M=3S-4W", "los Angles , USA, 955032 - Washin DC.", "320")
        ],
      ),
    );
  }
}
Widget _buildStatusCard(String Plan, String time,String place,String price) {
    return Container(
      width: 352.w,
      height: 88.h,
       margin: EdgeInsets.only(left: 15.w),
      padding: EdgeInsets.all(10),
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    appText.primaryText(
                      text: "Customer name",
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
                          text: Plan,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF19A4C6),
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
                     SizedBox(width: 5.w),
                        appText.primaryText(
                          text: place,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF19A4C6),
                        ),
                  ],
                ),
                SizedBox(width: 80.w),
              
              
               
              ],
            ),
          ),
           Column(
                children: [
                   Image.asset("assets/call.png"),
                    appText.primaryText(
                  text: price,
                  fontSize: 10.5.sp,
                  fontWeight: FontWeight.w400,
                ),
                ],
               )
        ],
      ),
    );
  }

