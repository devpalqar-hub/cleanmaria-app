import 'package:cleanby_maria/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cleanby_maria/Screens/admin_cleabby_maria/Dashboard/HomeScreen/HomeScreen.dart';
import 'package:cleanby_maria/Screens/staff_cleanbymaria/DashBoardScreen/Controller/DashBoardScreen.dart';

class AuthenticationController extends GetxController {
  var isLoading = false.obs; // Observable boolean for loading state

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> handleLogin() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      showSnackBar('Email and password cannot be empty');
      return;
    }

    isLoading.value = true; // Show loading

    try {
      final response = await login(emailController.text, passwordController.text);

      if (response['success']) {
        showSnackBar('Login successful');

        SharedPreferences prefs = await SharedPreferences.getInstance();
        String? role = prefs.getString("role");

        print("User role: $role");

        if (role == 'admin') {
          Get.offAll(() => Homescreen(), transition: Transition.rightToLeft);
        } else {
          Get.offAll(() => DashBoardScreen(), transition: Transition.rightToLeft);
        }
      } else {
        showSnackBar(response['error'] ?? 'Login failed. Invalid credentials.');
      }
    } catch (e) {
      showSnackBar('An error occurred: $e');
    } finally {
      isLoading.value = false; // Hide loading
    }
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    String loginUrl = "$baseUrl/auth/login";
    
    try {
      final response = await http.post(
        Uri.parse(loginUrl),
        body: jsonEncode({"email": email, "password": password}),
        headers: {"Content-Type": "application/json"},
      );

      final Map<String, dynamic> data = json.decode(response.body);

      if (response.statusCode == 201 && data.containsKey('access_token')) {
        // Store user token and role
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString("access_token", data['access_token']);
        await prefs.setString("role", data['user']['role'] ?? "user");

        return {"success": true, "accessToken": data['access_token'], "user": data['user']};
      } else {
        return {"success": false, "error": data['message'] ?? "Invalid credentials"};
      }
    } catch (e) {
      return {"success": false, "error": "An error occurred: $e"};
    }
  }

  void showSnackBar(String message) {
    Get.snackbar("Message", message, snackPosition: SnackPosition.BOTTOM);
  }
}
