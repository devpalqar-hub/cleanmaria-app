import 'dart:convert';
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

  Future<List<dynamic>> fetchStaffList() async {
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
          //'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      final decodedJson = json.decode(response.body);
      return decodedJson['data'] ?? [];
    } catch (e) {
      debugPrint('Error fetching staff list: $e');
      return [];
    }
  }

  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
  }
}
