import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cleanby_maria/main.dart';
import 'package:cleanby_maria/Screens/admin_cleabby_maria/Dashboard/StaffScreen/Models/StaffModel.dart';

class StaffController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isLoading = false;

  // Create staff
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
    //try 
    {
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
         print("Response Body: ${response.body}");
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Staff created successfully")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data['message'] ?? "Failed to create staff")),
        );
      }
    }
    // catch (e) {
      //ScaffoldMessenger.of(context).showSnackBar(
        //SnackBar(content: Text("Something went wrong: $e")),
     // );
    ///} finally {
      //isLoading = false;
      //onComplete();

   // }
  }

  // Fetch staff list
  Future<List<Staff>> fetchStaffList() async {
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
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final decodedJson = json.decode(response.body);
        final List<dynamic> staffListJson = decodedJson['data'] ?? [];
        print("Fetched Staff Data: $staffListJson");
        return staffListJson.map((json) => Staff.fromJson(json)).toList();
      } else {
        debugPrint("Failed to fetch staff: ${response.body}");
        return [];
      }
    } catch (e) {
      debugPrint('Error fetching staff list: $e');
      return [];
    }
  }

  // Update staff
  Future<Staff?> updateStaff(
    BuildContext context, {
    required String staffId,
    required String name,
    required String email,
    required String phone,
    String? password,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('access_token');

      if (token == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Token is missing. Please login again")),
        );
        return null;
      }

      final Map<String, dynamic> body = {};

      if (name.isNotEmpty) body['name'] = name;
      if (email.isNotEmpty) body['email'] = email;
      if (phone.isNotEmpty) body['phone'] = phone;
      if (password != null && password.isNotEmpty) body['password'] = password;

      if (body.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("No data to update")),
        );
        return null;
      }

      final response = await http.patch(
        Uri.parse('$baseUrl/users/$staffId'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );

      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Staff edited successfully")),
        );
        if (data != null && data['data'] != null) {
          return Staff.fromJson(data['data']);
        } else {
          print("Data field is null or missing");
          return null;
        }
      } else {
        final data = jsonDecode(response.body);
        String errorMessage = "Update failed";

        if (data is Map<String, dynamic>) {
          if (data['message'] is String) {
            errorMessage = data['message'];
          } else if (data['message'] is List) {
            errorMessage = (data['message'] as List).join(", ");
          }
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage)),
        );
        return null;
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error updating staff: $e")),
      );
      return null;
    }
  }

  // Enable staff
  Future<void> enableStaff(BuildContext context, String staffId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('access_token');

      if (token == null) {
        debugPrint('Token is null. Please login first.');
        return;
      }

      final response = await http.patch(
        Uri.parse('$baseUrl/users/$staffId'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({"status": "active"}),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Staff enabled successfully")),
        );
      } else {
        final data = jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data['message'] ?? "Failed to enable staff")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error enabling staff: $e")),
      );
    }
  }

  // Disable staff
  Future<void> disableStaff(BuildContext context, String staffId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('access_token');

      if (token == null) {
        debugPrint('Token is null. Please login first.');
        return;
      }

      final response = await http.patch(
        Uri.parse('$baseUrl/users/$staffId'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({"status": "disabled"}),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Staff disabled successfully")),
        );
      } else {
        final data = jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data['message'] ?? "Failed to disable staff")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error disabling staff: $e")),
      );
    }
  }

  // Delete staff
  Future<void> deleteStaff(BuildContext context, Staff staff) async {
    final staffId = staff.id;
    final url = Uri.parse('$baseUrl/users/$staffId');
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
          const SnackBar(content: Text("Staff deleted successfully")),
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

  // Dispose controllers
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
  }
}
