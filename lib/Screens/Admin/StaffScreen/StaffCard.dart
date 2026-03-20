import 'package:cleanby_maria/Screens/Admin/StaffScreen/Service/Controller.dart';
import 'package:cleanby_maria/Screens/Admin/StaffScreen/Views/EditBottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
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

  final StaffController stCtrl = Get.put(StaffController());

  @override
  void initState() {
    super.initState();
    name = widget.staff.name;
    email = widget.staff.email;
    isActive = widget.staff.status.toLowerCase() == 'active';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(15.w),
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.white, Colors.grey.shade100],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(15.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 22.r,
            backgroundColor: Colors.blue.shade100,
            child: Text(
              widget.staff.name.isNotEmpty
                  ? widget.staff.name[0].toUpperCase()
                  : '?',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade700,
              ),
            ),
          ),
          SizedBox(width: 14.w),
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
                    fontSize: 12.sp,
                    color: Colors.grey[700],
                  ),
                ),
                SizedBox(height: 6.h),
                Row(
                  children: [
                    Icon(
                      Icons.flag,
                      size: 14.sp,
                      color: Colors.orange,
                    ),
                    SizedBox(width: 5.w),
                    Text(
                      "Priority: ${widget.staff.priority}".tr,
                      style: GoogleFonts.poppins(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[800],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: 8.w),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 10.w,
              vertical: 5.h,
            ),
            decoration: BoxDecoration(
              color: isActive ? const Color(0xFF1C9F0B) : Colors.red.shade600,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  isActive ? Icons.check_circle : Icons.block,
                  color: Colors.white,
                  size: 14.sp,
                ),
                SizedBox(width: 4.w),
                Text(
                  isActive ? "Active".tr : "Disabled".tr,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 5.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 4.w),
          SizedBox(
            width: 40.w,
            height: 40.h,
            child: PopupMenuButton<String>(
              icon: Icon(
                Icons.more_vert,
                size: 20.sp,
                color: Colors.grey[700],
              ),
              padding: EdgeInsets.zero,
              onSelected: _handleMenuAction,
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: "Edit",
                  child: Text("Edit".tr),
                ),
                if (!isActive)
                  PopupMenuItem(
                    value: "Enable",
                    child: Text("Enable".tr),
                  ),
                if (isActive)
                  PopupMenuItem(
                    value: "Disable",
                    child: Text("Disable".tr),
                  ),
                PopupMenuItem(
                  value: "Delete",
                  child: Text(
                    "Delete".tr,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _handleMenuAction(String value) {
    switch (value) {
      case "Edit":
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20.r),
            ),
          ),
          builder: (context) => EditStaffBottomSheet(
            staff: widget.staff,
          ),
        );
        break;

      case "Enable":
        _showConfirmation(
          "Enable Staff".tr,
          () => stCtrl.enableStaff(widget.staff.id),
        );
        break;

      case "Disable":
        _showConfirmation(
          "Disable Staff".tr,
          () => stCtrl.disableStaff(widget.staff.id),
        );
        break;

      case "Delete":
        _showConfirmation(
          "Delete Staff".tr,
          () => stCtrl.deleteStaff(widget.staff),
          isDelete: true,
        );
        break;
    }
  }

  void _showConfirmation(
    String title,
    VoidCallback onConfirm, {
    bool isDelete = false,
  }) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: Text(
          "Are you sure you want to ${title.toLowerCase()}?".tr,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel".tr),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: isDelete ? Colors.red : const Color(0xFF374A67),
            ),
            onPressed: () {
              Navigator.pop(context);
              onConfirm();
            },
            child: Text(
              isDelete ? "Delete".tr : "Confirm".tr,
            ),
          ),
        ],
      ),
    );
  }
}
