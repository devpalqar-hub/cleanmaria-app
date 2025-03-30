import 'package:cleanby_maria/Src/appText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StaffScreen extends StatelessWidget {
  const StaffScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.h),
        child: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_outlined, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          title: appText.primaryText(text: "Staffs", fontSize: 18.sp, fontWeight: FontWeight.w700),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 15.w),
              child: ElevatedButton.icon(
                onPressed: () {
                  // Navigate to staff creation screen
                },
                icon: const Icon(Icons.add, size: 18, color: Colors.white),
                label: const Text("Create staff", style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.w)),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10.h),
            // Search Bar
            Container(
              width: double.infinity,
              height: 50.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.w),
                color: const Color(0xFFF7F6F5),
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.search, color: Colors.black),
                    onPressed: () {},
                  ),
                  appText.primaryText(text: "Search", fontSize: 16.sp, fontWeight: FontWeight.w500),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.filter_list, color: Colors.black),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            SizedBox(height: 15.h),
            // Staff List
            Expanded(
              child: ListView.builder(
                itemCount: 5, // Change this to actual staff count
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      // Navigate to staff details
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: 10.h),
                      padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.w),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 5,
                            spreadRadius: 1,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          // Avatar/Icon
                         
                          SizedBox(width: 10.w),
                          // Name & Description
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Staff Name",
                                  style: TextStyle(color: Colors.black, fontSize: 14.sp, fontWeight: FontWeight.w600),
                                ),
                                SizedBox(height: 3.h),
                                Text(
                                  "Description",
                                  style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500, color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                          // Status Indicator
                          Container(
                            height: 30.h,
                            width: 60.w,
                            decoration: BoxDecoration(
                              color: const Color(0xFF1C9F0B),
                              borderRadius: BorderRadius.circular(20.w),
                            ),
                            child: Center(
                              child: Text(
                                "Active",
                                style: TextStyle(color: Colors.white, fontSize: 12.sp, fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}