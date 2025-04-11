import 'package:cleanby_maria/Screens/admin_cleabby_maria/Dashboard/StaffScreen/Models/StaffModel.dart';
import 'package:cleanby_maria/main.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cleanby_maria/Src/appButton.dart';

class EditStaffBottomSheet extends StatefulWidget {
  final Map<String, String> staff;
  final Function(Map<String, String>) onUpdate;

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

  String selectedStatus = 'active';
  String token = '';

  @override
  void initState() {
    super.initState();
    nameController.text = widget.staff["name"] ?? '';
    emailController.text = widget.staff["email"] ?? '';
    phoneController.text = widget.staff["phone"] ?? '';
    selectedStatus = widget.staff["status"] ?? 'active';
    loadToken();
  }

  void loadToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString('token') ?? '';
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> updateStaffStatus(BuildContext context, Staff staff) async {
  final staffId = staff.id;
  final url = Uri.parse('$baseUrl/users/$staffId');

  final String status = staff.status ?? 'active';

  final Map<String, dynamic> body = {
    "name": staff.name,
    "email": staff.email,
    "phone": staff.phone,
    // "password": staff.password, // Exclude password if not updating
    "status": status,
  };

  try {
    final response = await http.patch(
      url,
      headers: await _authHeader(),
      body: json.encode(body),
    );

    print('🔄 PATCH Request Sent to $url');
    print('📤 Request Body: ${json.encode(body)}');
    print('📥 Response Status: ${response.statusCode}');
    print('📥 Response Body: ${response.body}');

    if (mounted) {
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Staff updated successfully")),
        );
      } else {
        final data = jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data['message'] ?? "Failed to update staff")),
        );
      }
    }
  } catch (e) {
    print('⚠️ Error updating staff: $e');
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Something went wrong: $e")),
      );
    }
  }
}


  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm Update"),
          content: const Text("Are you sure you want to edit this staff?"),
          actions: <Widget>[
            TextButton(
              child: const Text("Cancel"),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text("Yes"),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pop(context); // Close the bottom sheet

                 Staff updatedStaff = Staff(
                id: widget.staff["id"] ?? '', // Assuming "id" is in the staff data
                name: nameController.text.trim(),
                email: emailController.text.trim(),
                phone: phoneController.text.trim(),
              //  password: passwordController.text.trim(),
                status: selectedStatus,
              );
              updateStaffStatus(context, updatedStaff);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20.w),
          height: 680.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 89.w,
                  child: Divider(thickness: 2, color: Colors.grey[300]),
                ),
              ),
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
                      onPressed: () => Navigator.pop(context),
                      width: 150.w,
                      height: 45.h,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: AppButton(
                      text: "Save",
                      onPressed: _showConfirmationDialog,
                      width: 150.w,
                      height: 45.h,
                    ),
                  ),
                ],
              ),
            ],
          ),
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
Future<Map<String, String>> _authHeader() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token') ?? ''; // Fetch token from SharedPreferences

  return {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token', // Add the bearer token to the headers
  };
}
