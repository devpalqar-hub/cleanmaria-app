import 'package:cleanby_maria/Screens/Admin/StaffScreen/Service/Controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cleanby_maria/Src/appButton.dart';

class CreateStaffBottomSheet extends StatefulWidget {
  const CreateStaffBottomSheet({super.key});

  @override
  State<CreateStaffBottomSheet> createState() => _CreateStaffBottomSheetState();
}

class _CreateStaffBottomSheetState extends State<CreateStaffBottomSheet> {
  @override
  void dispose() {
    super.dispose();
  }
  bool _obscurePassword = false;

  Widget _buildInputField(
      String label, String hint, TextEditingController controller,
      {bool obscureText = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style:
              GoogleFonts.poppins(fontSize: 14.sp, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 5.h),
        TextFormField(
          controller: controller,
          obscureText: obscureText? _obscurePassword : true,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: Colors.grey[200],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide.none,
            ),
            contentPadding:
                EdgeInsets.symmetric(horizontal: 15.w, vertical: 12.h),
                suffixIcon: obscureText
              ? IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility_off : Icons.visibility,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                )
              : null,
          ),
        ),
        SizedBox(height: 15.h),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StaffController>(builder: (_) {
      return Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          padding: EdgeInsets.all(20.w),
          height: 618.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                    child: SizedBox(
                        width: 89.w,
                        child: Divider(thickness: 2, color: Colors.grey[300]))),
                SizedBox(height: 5.h),
                Center(
                  child: Text(
                    "Create Staff",
                    style: GoogleFonts.poppins(
                        fontSize: 18.sp, fontWeight: FontWeight.w700),
                  ),
                ),
                SizedBox(height: 20.h),
                _buildInputField(
                    "Staff Name", "Enter Staff Name", _.nameController),
                _buildInputField(
                    "Email", "Enter Staff Email", _.emailController),
                _buildInputField(
                    "Phone", "Enter Staff Phone", _.phoneController),
                _buildInputField(
                    "Password", "Enter Password", _.passwordController,
                    obscureText: true),
                SizedBox(height: 20.h),
                _.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : AppButton(
                        text: "Create Staff",
                        onPressed: () {
                          _.createStaff(context);
                        },
                      ),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Center(
                      child: Text("Get Back",
                          style:
                              TextStyle(fontSize: 14.sp, color: Colors.black))),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
