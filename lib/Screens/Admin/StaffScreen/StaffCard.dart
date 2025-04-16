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
      height: 80.h,
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
          offset: const Offset(0, 1),
            blurRadius: 4,
            spreadRadius: 0,
          color: Colors.black.withOpacity(0.1),
          ),
        ],
      ),
      child: Row(
        children: [
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 3.h),
                Text(
                  email,
                  style: GoogleFonts.poppins(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 24.h,
            width: 82.w,
            decoration: BoxDecoration(
              color: isActive ? const Color(0xFF1C9F0B) : Colors.red,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Center(
              child: Text(
                isActive ? "Active" : "Disabled",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          SizedBox(width: 5.w),
          PopupMenuButton<String>(
            icon: Icon(Icons.more_vert, size: 18.sp, color: Colors.grey),
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
                      //      notify: notify,
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
              child: const Text("Cancel",style: TextStyle(color: Colors.blue),),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text(content,style: TextStyle(color: Colors.blue) ,),
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
