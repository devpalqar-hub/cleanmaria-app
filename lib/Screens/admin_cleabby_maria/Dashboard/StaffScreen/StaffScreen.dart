import 'dart:convert';
import 'package:cleanby_maria/Screens/admin_cleabby_maria/Dashboard/StaffScreen/Models/StaffModel.dart';
import 'package:cleanby_maria/Screens/admin_cleabby_maria/Dashboard/StaffScreen/Service/Controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'StaffCard.dart';
import 'Views/CreateBottomsheet.dart';
import 'Views/EditBottomsheet.dart';

class StaffScreen extends StatefulWidget {
  const StaffScreen({super.key});

  @override
  State<StaffScreen> createState() => _StaffScreenState();
}

class _StaffScreenState extends State<StaffScreen> {
  List<dynamic> staffList = [];
  bool isLoading = true;
  final StaffController staffController = StaffController();

  @override
  void initState() {
    super.initState();
    fetchStaffData();
  }

  Future<void> fetchStaffData() async {
    setState(() {
      isLoading = true;
    });

    final staffData = await staffController.fetchStaffList();
    setState(() {
      staffList = staffData;
      isLoading = false;
    });

    print("Fetched Staff List: $staffList");
  }

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
                  style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
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
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(20.r)),
                    ),
                    builder: (context) => CreateStaffBottomSheet(),
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
          children: [
            SizedBox(height: 15.h),
            _buildSearchBox(),
            SizedBox(height: 15.h),
            Expanded(
              child: isLoading
                  ? Center(child: CircularProgressIndicator())
                  : staffList.isEmpty
                      ? Center(
                          child: Text(
                            "No staff available",
                            style: TextStyle(fontSize: 16.sp),
                          ),
                        )
                      : ListView.builder(
                          itemCount: staffList.length,
                          itemBuilder: (context, index) {
                            final staff = staffList[index];
                            return StaffCard(
                              name: staff['name'] ?? 'No Name',
                              description: staff['email'] ?? 'No Email',
                              isActive: staff['status'] == 'active',
                              onEdit: () {
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(20.r)),
                                  ),
                                  builder: (context) => EditStaffBottomSheet(
                                    staff: staff,
                                    onUpdate: (updatedStaff) {
                                      setState(() {
                                        staffList[index] = updatedStaff;
                                      });
                                    },
                                  ),
                                );
                              },
                              onEnable: () {
                                setState(() {
                                  staffList[index]['status'] = 'active';
                                });
                              },
                              onDisable: () {
                                setState(() {
                                  staffList[index]['status'] = 'inactive';
                                });
                              },
                              onDelete: () {
                                onDeleteStaff(context, staff, index);
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

  void onDeleteStaff(BuildContext context, Map<String, dynamic> staff, int index) async {
    final isConfirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirm Deletion'),
        content: Text('Are you sure you want to delete this staff member?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text('OK'),
          ),
        ],
      ),
    );

    if (isConfirmed ?? false) {
      // Create a Staff object from the staff data
      final staffToDelete = Staff(
        id: staff['id'],
        name: staff['name'] ?? '',
        email: staff['email'] ?? '',
        status: staff['status'] ?? '',
      );

      // Call the delete API with the staff object
      await staffController.deleteStaff(context, staffToDelete);

      // After deletion, remove the staff from the list and refetch the staff data
      setState(() {
        staffList.removeAt(index);
      });
    }
  }
}
