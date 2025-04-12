import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:cleanby_maria/Screens/admin_cleabby_maria/Dashboard/StaffScreen/Models/StaffModel.dart';

class StaffCard extends StatefulWidget {
  final Staff staff;
  final Future<Staff?> Function(Staff staff) onEdit;
  final VoidCallback onEnable;
  final VoidCallback onDisable;
  final VoidCallback onDelete;

  const StaffCard({
    Key? key,
    required this.staff,
    required this.onEdit,
    required this.onEnable,
    required this.onDisable,
    required this.onDelete,
  }) : super(key: key);

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

  void updateLocalStaff(Staff updated) {
    setState(() {
      name = updated.name;
      email = updated.email;
      isActive = updated.status == 'active';
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.only(bottom: 10.h),
        padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.w),
        decoration: BoxDecoration(
          color: const Color(0xFFF3F5F6),
          border: Border.all(color: const Color(0x757D7F), width: 0.5),
          borderRadius: BorderRadius.circular(17.w),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF000000).withOpacity(0.05),
              blurRadius: 1,
              spreadRadius: 0.5,
              offset: const Offset(0, 1),
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
              height: 18.h,
              width: 56.w,
              decoration: BoxDecoration(
                color: isActive ? const Color(0xFF1C9F0B) : Colors.red,
                borderRadius: BorderRadius.circular(20.w),
              ),
              child: Center(
                child: Text(
                  isActive ? "Active" : "Disabled",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 8.sp,
                    fontWeight: FontWeight.w500,
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
                    final updatedStaff = await widget.onEdit(widget.staff);
                    if (updatedStaff != null) updateLocalStaff(updatedStaff);
                    break;
                  case "Enable":
                    widget.onEnable();
                    break;
                  case "Disable":
                    widget.onDisable();
                    break;
                  case "Delete":
                    _showDeleteConfirmationDialog(context, widget.onDelete);
                    break;
                }
              },
              itemBuilder: (BuildContext context) {
                final List<PopupMenuEntry<String>> items = [];
                items.add(_buildMenuItem("Edit", Icons.edit));
                if (isActive) {
                  items.add(_buildMenuItem("Disable", Icons.toggle_off));
                } else {
                  items.add(_buildMenuItem("Enable", Icons.toggle_on));
                }
                items.add(_buildMenuItem("Delete", Icons.delete));
                return items;
              },
            ),
          ],
        ),
      ),
    );
  }

  PopupMenuItem<String> _buildMenuItem(String title, IconData icon) {
    return PopupMenuItem<String>(
      value: title,
      child: Row(
        children: [
          Icon(icon, size: 18, color: Colors.black),
          SizedBox(width: 10),
          Text(
            title,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, VoidCallback onDelete) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm Deletion"),
          content: const Text("Are you sure you want to delete this staff member?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                onDelete();
              },
              child: const Text("Delete"),
            ),
          ],
        );
      },
    );
  }
}
