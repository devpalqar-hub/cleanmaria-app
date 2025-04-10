import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cleanby_maria/Src/appButton.dart';

class EditStaffBottomSheet extends StatefulWidget {
  final Map<String, String> staff;
  final Function(Map<String, String>) onUpdate; // Pass updated staff data

  const EditStaffBottomSheet({
    super.key,
    required this.staff,
    required this.onUpdate,
  });

  @override
  State<EditStaffBottomSheet> createState() => _EditStaffBottomSheetState();
}

class _EditStaffBottomSheetState extends State<EditStaffBottomSheet> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.staff["name"] ?? '';
    emailController.text = widget.staff["email"] ?? '';
    phoneController.text = widget.staff["phone"] ?? '';
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        padding: EdgeInsets.all(20.w),
        height: 600.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Container(width: 89.w, child: Divider(thickness: 2, color: Colors.grey[300]))),
            SizedBox(height: 5.h),
            Center(
              child: Text(
                "Edit Staff",
                style: GoogleFonts.poppins(fontSize: 18.sp, fontWeight: FontWeight.w700),
              ),
            ),
            SizedBox(height: 20.h),
            _buildInputField("Staff Name", "Enter Staff Name", nameController),
            _buildInputField("Email", "Enter Staff Email", emailController),
            _buildInputField("Phone", "Enter Staff Phone", phoneController),
            _buildInputField("Password", "Enter New Password", passwordController, obscureText: true),
            SizedBox(height: 20.h),
            Row(
              children: [
                Expanded(
                  child: AppButton(
                    text: "Cancel",
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    width: 150.w,
                    height: 45.h,
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: AppButton(
                    text: "Save",
                    onPressed: () {
                      // Gather the updated staff data
                      Map<String, String> updatedStaff = {
                        'name': nameController.text.trim(),
                        'email': emailController.text.trim(),
                        'phone': phoneController.text.trim(),
                        // Optionally, add the password field if you want to update it
                        'password': passwordController.text.trim(),
                      };
                      // Pass the updated staff data to the parent
                      widget.onUpdate(updatedStaff);
                      Navigator.pop(context);
                    },
                    width: 150.w,
                    height: 45.h,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(String label, String hint, TextEditingController controller, {bool obscureText = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: GoogleFonts.poppins(fontSize: 14.sp, fontWeight: FontWeight.w600)),
        SizedBox(height: 5.h),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: Colors.grey[200],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide.none,
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 12.h),
          ),
        ),
        SizedBox(height: 15.h),
      ],
    );
  }
}
