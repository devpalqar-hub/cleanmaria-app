import 'package:cleanby_maria/Screens/Admin/StaffScreen/Service/Controller.dart';
import 'package:cleanby_maria/Screens/Admin/StaffScreen/Views/EditBottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:cleanby_maria/Screens/Admin/StaffScreen/Models/StaffModel.dart';

class StaffCard extends StatefulWidget {
  final Staff staff;

  const StaffCard({
    super.key,
    required this.staff,
  });

  @override
  State<StaffCard> createState() => _StaffCardState();
}

class _StaffCardState extends State<StaffCard> {
  late String name;
  late String email;
  late bool isActive;

  @override
  void initState() {
    super.initState();
    name = widget.staff.name;
    email = widget.staff.email;
    isActive = widget.staff.status == 'active';
  }

  StaffController stCtrl = Get.put(StaffController());

@override
Widget build(BuildContext context) {
  return Container(
    width: 352.w,
    padding: EdgeInsets.all(15.w),
    margin: EdgeInsets.only(bottom: 12.h),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.white, Colors.grey[100]!],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(15.r),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          blurRadius: 6,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Row(
      children: [
        // Avatar
        CircleAvatar(
          radius: 22.r,
          backgroundColor: Colors.blue.shade100,
          child: Text(
            widget.staff.name.isNotEmpty ? widget.staff.name[0] : '?',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
        ),
        SizedBox(width: 20.w),
        // Info Column
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                email,
                style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  color: Colors.grey[700],
                ),
              ),
              SizedBox(height: 4.h),
              Row(
                children: [
                  Icon(Icons.flag, size: 14.sp, color: Colors.orange),
                  SizedBox(width: 10.w),
                  Text(
                    "Priority: ${widget.staff.priority}",
                    style: GoogleFonts.poppins(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                    //  color: Colors.deepOrange,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        // Status Tag
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
          decoration: BoxDecoration(
            color: isActive ? Color(0xFF1C9F0B) : Colors.red,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Row(
            children: [
              Icon(
                isActive ? Icons.check_circle : Icons.block,
                color: Colors.white,
                size: 14.sp,
              ),
              SizedBox(width: 4.w),
              Text(
                isActive ? "Active" : "Disabled",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 5.w),
        // Menu
        PopupMenuButton<String>(
          icon: Icon(Icons.more_vert, size: 20.sp, color: Colors.grey),
          onSelected: (String value) async {
            switch (value) {
              case "Edit":
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20.r)),
                  ),
                  builder: (context) => EditStaffBottomSheet(
                    staff: widget.staff,
                  ),
                );
                break;
              case "Enable":
                _showDeleteConfirmation("Enable", () {
                  stCtrl.enableStaff(widget.staff.id);
                });
                break;
              case "Disable":
                _showDeleteConfirmation("Disable", () {
                  stCtrl.disableStaff(widget.staff.id);
                });
                break;
              case "Delete":
                _showDeleteConfirmation("Delete", () {
                  stCtrl.deleteStaff(widget.staff);
                });
                break;
            }
          },
          itemBuilder: (BuildContext context) {
            return <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'Edit',
                child: Text('Edit'),
              ),
              if (!isActive)
                const PopupMenuItem<String>(
                  value: 'Enable',
                  child: Text('Enable'),
                ),
              if (isActive)
                const PopupMenuItem<String>(
                  value: 'Disable',
                  child: Text('Disable'),
                ),
              const PopupMenuItem<String>(
                value: 'Delete',
                child: Text('Delete'),
              ),
            ];
          },
        ),
      ],
    ),
  );
}

  
  void _showDeleteConfirmation(String content, Function callback) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text("Confirm $content"),
          content: Text(
              "Are you sure you want to ${content.toLowerCase()} this staff member?"),
          actions: [
            TextButton(
              child: const Text(
                "Cancel",
                style: TextStyle(color: Colors.blue),
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text(
                content,
                style: TextStyle(color: Colors.blue),
              ),
              onPressed: () {
                callback();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
