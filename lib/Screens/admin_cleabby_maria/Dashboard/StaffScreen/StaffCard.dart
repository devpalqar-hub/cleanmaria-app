import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class StaffCard extends StatelessWidget {
  final bool isActive;
  final VoidCallback onEdit;
  final VoidCallback onEnable;
  final VoidCallback onDisable;

  const StaffCard({
    Key? key,
    required this.isActive,
    required this.onEdit,
    required this.onEnable,
    required this.onDisable,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
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
                    "Staff Name",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 3.h),
                  Text(
                    "Description",
                    style: TextStyle(
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
              onSelected: (String value) {
                if (value == "Edit") {
                  onEdit();
                } else if (value == "Enable") {
                  onEnable();
                } else if (value == "Disable") {
                  onDisable();
                }
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                _buildMenuItem("Edit", Icons.edit),
                _buildMenuItem("Enable", Icons.toggle_on),
                _buildMenuItem("Disable", Icons.toggle_off),
                _buildMenuItem("Delete", Icons.delete),
              ],
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
          Text(title, style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
