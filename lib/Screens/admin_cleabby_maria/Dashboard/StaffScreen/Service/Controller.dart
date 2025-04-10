import 'dart:convert';
import 'package:cleanby_maria/Screens/admin_cleabby_maria/Dashboard/StaffScreen/Models/StaffModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cleanby_maria/main.dart';

class StaffController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isLoading = false;

  // Method to create a new staff
  Future<void> createStaff(BuildContext context, VoidCallback onComplete) async {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all required fields")),
      );
      return;
    }

    isLoading = true;
    onComplete();

    try {
      final response = await http.post(
        Uri.parse("$baseUrl/auth/register"),
        headers: authHeader,
        body: jsonEncode({
          "name": name,
          "email": email,
          "password": password,
          "role": "staff",
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Staff created successfully")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data['message'] ?? "Failed to create staff")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Something went wrong: $e")),
      );
    } finally {
      isLoading = false;
      onComplete();
    }
  }

  // Method to fetch the list of staff members
  Future<List<Map<String, dynamic>>> fetchStaffList() async {
    final url = Uri.parse('$baseUrl/users/staff');
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('access_token');

      if (token == null) {
        debugPrint('Token is null. Please login first.');
        return [];
      }

      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      final decodedJson = json.decode(response.body);
      final staffList = List<Map<String, dynamic>>.from(decodedJson['data'] ?? []);
      return staffList;
    } catch (e) {
      debugPrint('Error fetching staff list: $e');
      return [];
    }
  }

  // Method to delete a staff member
 Future<void> deleteStaff(BuildContext context, Staff staff) async {
    final staffId = staff.id; // Assuming 'id' is a property of StaffModel
    final url = Uri.parse('$baseUrl/users/$staffId'); // Use the correct API endpoint URL
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('access_token');

      if (token == null) {
        debugPrint('Token is null. Please login first.');
        return;
      }

      final response = await http.delete(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Staff deleted successfully")),
        );
      } else {
        final data = jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data['message'] ?? "Failed to delete staff")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Something went wrong: $e")),
      );
    }
  }

  // Dispose method to clean up controllers
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
  }
}
