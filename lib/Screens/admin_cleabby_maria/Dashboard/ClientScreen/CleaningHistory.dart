import 'package:cleanby_maria/Screens/admin_cleabby_maria/Dashboard/ClientScreen/CleaningDetails.dart';
import 'package:cleanby_maria/Screens/admin_cleabby_maria/Dashboard/ClientScreen/Views/StatusCard.dart';
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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_outlined,
              color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: appText.primaryText(
            text: "Cleaning History",
            fontSize: 18.sp,
            fontWeight: FontWeight.w700),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
             SizedBox(height: 20.h,),
             Container(
              width: 345.w,
              height: 50.h,
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.w),
                  color: Colors.grey.shade200),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Icon(Icons.search),SizedBox(width: 15.w,),
                    appText.primaryText(text: "Search for booking"),
                  ],
                ),
              ),
            ),
          
          SizedBox(
            height: 20.h,
          ),
          Center(
            child: Column(
              children: [
                StatusCard(
                  status: "Completed",
                  color: const Color(0xFF03AE9D),
                  customerName: "Customer name",
                  time: "10:00 AM - 11:00 AM",
                  location: "Los Angeles, USA, 955032 - Washington DC.",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CleaningDetails(),
                      ),
                    );
                  },
                ),
              
            SizedBox(height: 10.h),
            StatusCard(
              status: "Cancelled",
              color: const Color(0xFFAE1D03),
              customerName: "Customer name",
              time: "10:00 AM - 11:00 AM",
              location: "Los Angeles, USA, 955032 - Washington DC.",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CleaningDetails(),
                  ),
                );
              },
            ),
            SizedBox(height: 10.h),
            StatusCard(
              status: "Pending",
              color: const Color(0xFFE89F18),
              customerName: "Customer name",
              time: "10:00 AM - 11:00 AM",
              location: "Los Angeles, USA, 955032 - Washington DC.",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CleaningDetails(),
                  ),
                );
              },
            ),
            ],
            ),
          ),
        ],
      ),
    );
  }
}
