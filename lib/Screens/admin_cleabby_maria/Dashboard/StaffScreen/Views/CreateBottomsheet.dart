import 'package:cleanby_maria/Screens/admin_cleabby_maria/Dashboard/StaffScreen/Service/Controller.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cleanby_maria/Src/appButton.dart';

class CreateStaffBottomSheet extends StatefulWidget {
  final VoidCallback onUpdate;
  final String baseUrl;
  final String token;

  const CreateStaffBottomSheet({
    super.key,
    required this.onUpdate,
    required this.baseUrl,
    required this.token,
  });

  @override
  State<CreateStaffBottomSheet> createState() => _CreateStaffBottomSheetState();
}

class _CreateStaffBottomSheetState extends State<CreateStaffBottomSheet> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  late CreateStaffController _controller;

  @override
  void initState() {
    super.initState();
    _controller = CreateStaffController(
      baseUrl: widget.baseUrl,
      token: widget.token,
    );
  }

  Future<void> _createStaff() async {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final phone = phoneController.text.trim();
    final password = passwordController.text.trim();

    await _controller.createStaff(
      name: name,
      email: email,
      phone: phone,
      password: password,
      onSuccess: () {
        widget.onUpdate();
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Staff created successfully")),
        );
      },
      onError: (errorMessage) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage)),
        );
      },
    );
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
                "Create Staff",
                style: GoogleFonts.poppins(fontSize: 18.sp, fontWeight: FontWeight.w700),
              ),
            ),
            SizedBox(height: 20.h),
            _buildInputField("Staff Name", "Enter Staff Name", nameController),
            _buildInputField("Email", "Enter Staff Email", emailController),
            _buildInputField("Phone", "Enter Staff Phone", phoneController),
            _buildInputField("Password", "Enter Password", passwordController, obscureText: true),
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
                    onPressed: _createStaff,
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
