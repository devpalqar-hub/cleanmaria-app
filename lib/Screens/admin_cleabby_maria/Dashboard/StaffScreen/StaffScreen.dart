import 'package:cleanby_maria/Screens/admin_cleabby_maria/Dashboard/StaffScreen/StaffCard.dart';
import 'package:cleanby_maria/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cleanby_maria/Screens/admin_cleabby_maria/Dashboard/StaffScreen/Views/CreateBottomsheet.dart';
import 'package:cleanby_maria/Screens/admin_cleabby_maria/Dashboard/StaffScreen/Views/EditBottomsheet.dart';

class StaffScreen extends StatefulWidget {
  const StaffScreen({super.key});

  @override
  State<StaffScreen> createState() => _StaffScreenState();
}

class _StaffScreenState extends State<StaffScreen> {
  // Sample staff data with status included
  List<Map<String, String>> staffList = [
    {"name": "John Doe", "email": "john@example.com", "status": "active"},
    {"name": "Jane Smith", "email": "jane@example.com", "status": "inactive"},
    {"name": "Alice Brown", "email": "alice@example.com", "status": "active"},
    {"name": "Bob White", "email": "bob@example.com", "status": "inactive"},
    {"name": "Charlie Green", "email": "charlie@example.com", "status": "active"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.h),
        child: AppBar(
          leading: const Icon(Icons.arrow_back_ios),
          title: Text(
            "Staffs",
            style: GoogleFonts.poppins(
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 20.w),
              child: ElevatedButton.icon(
                icon: Icon(Icons.add, color: Colors.white, size: 16.sp),
                label: Text(
                  "Create Staff",
                  style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w600, color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  minimumSize: Size(105.w, 27.h),
                ),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
                    ),
                    builder: (context) => CreateStaffBottomSheet(onUpdate: () {
                        setState(() {
                          // You can add logic to update the staff list after adding a new staff
                        });
                      },
                      baseUrl: "$baseUrl",
                      token: "$token"),
                  );
                },
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
            SizedBox(height: 15.h),
            _buildSearchBox(),
            SizedBox(height: 15.h),
            Expanded(
              child: ListView.builder(
                itemCount: staffList.length,
                itemBuilder: (context, index) {
                  return StaffCard(
                    staff: staffList[index],  // Passing the staff data
                    onEdit: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
                        ),
                       builder: (context) => EditStaffBottomSheet(
      staff: staffList[index],  // Pass the staff data to the EditStaffBottomSheet
      onUpdate: () {
        setState(() {
          // You can add logic to update the staff list after editing
        });
      },
    ),
  );
},
                    onEnable: () {
                      setState(() {
                        staffList[index]['status'] = 'active'; // 
                      });
                    },
                    onDisable: () {
                      setState(() {
                        staffList[index]['status'] = 'inactive'; // Update staff status to inactive
                      });
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBox() {
    return Container(
      height: 47.h,
      width: 358.w,
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F6F5),
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Row(
        children: [
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              'Search',
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Image.asset(
              'assets/Filters.png',
              width: 70.sp,
              height: 24.sp,
            ),
          ),
        ],
      ),
    );
  }
}
