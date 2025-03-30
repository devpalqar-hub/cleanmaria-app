
import 'package:cleanby_maria/Screens/admin_cleabby_maria/Dashboard/ClientScreen/CleaningDetails.dart';
import 'package:cleanby_maria/Src/appText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CleaningHistory extends StatefulWidget {
  const CleaningHistory({super.key});

  @override
  State<CleaningHistory> createState() => _CleaningHistoryState();
}

class _CleaningHistoryState extends State<CleaningHistory> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
     appBar: PreferredSize(preferredSize: Size.fromHeight(70.h), child: AppBar(
      leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_outlined, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
      title: appText.primaryText(text: "Cleaning History",fontSize: 18.sp,fontWeight: FontWeight.w700),
      )),
      
        body: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
          children: [
              Container(
            width: 343.w,
            height: 50.h,
             margin: EdgeInsets.only(left: 15.w),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.w),color: Colors.grey.shade200),
            child: Row(
              children: [
                Icon(Icons.search),
                appText.primaryText(text: "Search for booking"),
              ],
            ),
          ),
          SizedBox(height: 10.h,),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (context) => CleaningDetails(),
                  ),
                );
              },
              child: _buildStatusCard("Completed", Color(0xFF03AE9D)),
            ),
            SizedBox(height: 10.h),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CleaningDetails(),
                  ),
                );
              },
              child: _buildStatusCard("Cancelled", Color(0xFFAE1D03)),
            ),
            SizedBox(height:10.h),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>  CleaningDetails(),
                  ),
                );
              },
              child: _buildStatusCard("Pending", Color(0xFFE89F18)),
            ),
          ],
        ),
      
    );
  }
}
 Widget _buildStatusCard(String status, Color color) {
    return Container(
      width: 352.w,
      height: 88.h,
      padding: EdgeInsets.all(10),
       margin: EdgeInsets.only(left: 15.w),
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
