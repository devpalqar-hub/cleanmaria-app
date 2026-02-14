import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cleanby_maria/main.dart';
import 'package:cleanby_maria/Screens/Admin/StaffScreen/Models/StaffModel.dart';

class StaffController extends GetxController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController priorityController = TextEditingController();

  Map<String, String> authHeader = {};

  bool isLoading = false;
  List<Staff> staffList = [];
  Future<void> createStaff(BuildContext context,
      {required String priority}) async {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (name.isEmpty || email.isEmpty || password.isEmpty || priority.isEmpty) {
      Fluttertoast.showToast(msg: "Please fill all required fields");
      return;
    }
    isLoading = true;
    update();
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/users"),
        headers: authHeader,
        body: json.encode({
          "name": name,
          "email": email,
          "password": password,
          "role": "staff",
          "priority": int.tryParse(priority) ?? 0,
        }),
      );
      final data = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        Navigator.of(context).pop();
        Fluttertoast.showToast(msg: "Staff created successfully");
        print("Response Body:${response.body} ");
        fetchStaffList();
        clearText();
      } else {
        Fluttertoast.showToast(
            msg: "user already existed please retry with new id");
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Something went wrong: $e");
    } finally {
      isLoading = false;
    }
  }

  clearText() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
    phoneController.clear();
    priorityController.clear();
    update();
  }

  // Fetch staff list
  Future<void> fetchStaffList() async {
    staffList = [];
    update();
    final url = Uri.parse('$baseUrl/users/staff');
    isLoading = true;
    update();
    final response = await http.get(url, headers: authHeader);
    isLoading = false;

    print(response.body);
    update();
    if (response.statusCode == 200) {
      for (var data in json.decode(response.body)["data"]) {
        staffList.add(Staff.fromJson(data));
      }
    }
    update();
  }

  // Update staff
  Future<void> updateStaff(
      Map<String, dynamic> body, String staffID, BuildContext context) async {
    try {
      final response = await http.patch(
        Uri.parse('$baseUrl/users/$staffID'),
        headers: authHeader,
        body: jsonEncode(body),
      );
      isLoading = false;
      update();

      if (response.statusCode == 200) {
        fetchStaffList();

        Fluttertoast.showToast(msg: "Staff edited successfully");
        clearText();
        Navigator.of(context).pop();
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
        Fluttertoast.showToast(
          msg: errorMessage,
        );
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Error updating staff: $e");
    }
  }

  // Enable staff
  Future<void> enableStaff(String staffId) async {
    try {
      isLoading = true;
      update();
      final response = await http.patch(
        Uri.parse('$baseUrl/users/$staffId'),
        headers: authHeader,
        body: jsonEncode({"status": "active"}),
      );
      isLoading = false;
      update();

      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: "Staff enabled successfully");
        fetchStaffList();
      } else {
        final data = jsonDecode(response.body);
        Fluttertoast.showToast(
            msg: data['message'] ?? "Failed to enable staff");
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Error enabling staff: $e");
    }
  }

  // Disable staff
  Future<void> disableStaff(String staffId) async {
    try {
      isLoading = true;
      update();
      final response = await http.patch(
        Uri.parse('$baseUrl/users/$staffId'),
        headers: authHeader,
        body: jsonEncode({"status": "disabled"}),
      );
      isLoading = false;
      update();

      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: "Staff disabled successfully");
        fetchStaffList();
      } else {
        final data = jsonDecode(response.body);
        Fluttertoast.showToast(
            msg: data['message'] ?? "Failed to disable staff");
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Error disabling staff: $e");
    }
  }

  // Delete staff
  Future<void> deleteStaff(Staff staff) async {
    final url = Uri.parse('$baseUrl/users/${staff.id}');
    try {
      isLoading = true;
      update();

      final response = await http.delete(url, headers: authHeader);
      isLoading = false;
      update();

      print(response.body);
      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: "Staff deleted successfully");
        fetchStaffList();
      } else {
        final data = jsonDecode(response.body);
        Fluttertoast.showToast(
            msg: data['message'] ?? "Failed to delete staff");
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Something went wrong: $e");
    }
  }

  // Dispose controllers

  loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');
    authHeader = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
    update();
    fetchStaffList();
  }

  @override
  void onInit() {
    super.onInit();

    print("init");
    loadUser();
  }
}
