import 'package:cleanby_maria/Screens/admin_cleabby_maria/Dashboard/StaffScreen/Service/Controller.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cleanby_maria/Screens/admin_cleabby_maria/Dashboard/StaffScreen/Models/StaffModel.dart';
//import 'package:cleanby_maria/Screens/admin_cleabby_maria/Dashboard/StaffScreen/Service/Controller.dart';
import 'package:cleanby_maria/Src/appButton.dart';

class EditStaffBottomSheet extends StatefulWidget {
  final Staff staff;
  final Function(Staff) onUpdate;

  const EditStaffBottomSheet({
    super.key,
    required this.staff,
    required this.onUpdate,
  });

  @override
  State<EditStaffBottomSheet> createState() => _EditStaffBottomSheetState();
}

class _EditStaffBottomSheetState extends State<EditStaffBottomSheet> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController passwordController;
  bool isLoading = false;
  final controller = StaffController();

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.staff.name);
    emailController = TextEditingController(text: widget.staff.email);
    phoneController = TextEditingController(text: widget.staff.phone ?? '');
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void updateStaff() async {
    setState(() => isLoading = true);

    final controller = StaffController();
    final updatedStaff = await controller.updateStaff(
      context,
      staffId: widget.staff.id,
      name: nameController.text.trim(),
      email: emailController.text.trim(),
      phone: phoneController.text.trim(),
      password: passwordController.text.trim(),
    );

    setState(() => isLoading = false);

    if (updatedStaff != null) {
      widget.onUpdate(updatedStaff);
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Staff updated successfully")),
      );
    }
  }

  Widget _buildInputField(String label, TextEditingController controller, {bool obscure = false, String? hint}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: GoogleFonts.poppins(fontSize: 14.sp, fontWeight: FontWeight.w600)),
        SizedBox(height: 5.h),
        TextFormField(
          controller: controller,
          obscureText: obscure,
          decoration: InputDecoration(
            hintText: hint ?? '',
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        padding: EdgeInsets.all(20.w),
        height: 618.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        child: SingleChildScrollView(
          child: Column(
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
              _buildInputField("Staff Name", nameController),
              _buildInputField("Email", emailController),
              _buildInputField("Phone", phoneController),
              _buildInputField("New Password", passwordController, obscure: true, hint: "Leave blank to keep current"),
              SizedBox(height: 20.h),
              isLoading
                  ? const CircularProgressIndicator()
                  : AppButton(
                      text: "Update Staff",
                      onPressed: updateStaff,
                    ),
              TextButton(
                onPressed: () async {
  final updatedStaff = await controller.updateStaff(
    context,
    staffId: widget.staff.id!,
    name: nameController.text,
    email: emailController.text,
    phone: phoneController.text,
    password: passwordController.text.isEmpty ? null : passwordController.text,
  );

  if (updatedStaff != null) {
    widget.onUpdate(updatedStaff);
    Navigator.pop(context);
     // Make sure this runs BEFORE Navigator.pop
  }
},
                child: Center(child: Text("Cancel", style: TextStyle(fontSize: 14.sp, color: Colors.black))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
