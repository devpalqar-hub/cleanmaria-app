import 'dart:convert';
import 'package:cleanby_maria/main.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:cleanby_maria/Screens/Admin/HomeScreen/HomeScreen.dart';
import 'package:cleanby_maria/Screens/staff/DashBoardScreen.dart';

class AuthenticationController extends GetxController {
  var isLoading = false.obs;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> handleLogin() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
     Fluttertoast.showToast(msg:'Email and password cannot be empty');
      return;
    }

    isLoading.value = true;
  
    try {
      final response =
          await login(emailController.text, passwordController.text);
          
      print(response);

      if (response['success']) {
        Fluttertoast.showToast(msg:'Login successful');
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String? role = prefs.getString("role");

        print("User role: $role");

        if (role == 'admin') {
          Get.offAll(() => Homescreen(), transition: Transition.rightToLeft);
        } else {
          Get.offAll(() => DashBoardScreen(),
              transition: Transition.rightToLeft);
        }
      } else {
        Fluttertoast.showToast(msg: " Invalid credentials ");
      }
    } catch (e) {
     Fluttertoast.showToast (msg:'An error occurred: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    String loginUrl = "$baseUrl/auth/login";

    try {
      final response = await http.post(
        Uri.parse(loginUrl),
        body: jsonEncode({"email": email, "password": password}),
        headers: {
          "Content-Type": "application/json",
        },
      );

      print("Status code: ${response.statusCode}");
      print("Raw response body: ${response.body}");
      final Map<String, dynamic> data = json.decode(response.body);

      if (response.statusCode == 201 && data.containsKey('access_token')) {
        final accessToken = data['access_token'];
        print("Access Token: $accessToken");
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString("access_token", data['access_token']);
        await prefs.setString("role", data['user']['role'] ?? "user");
        await prefs.setString("user_name", data['user']['name'] ?? "User");
        await prefs.setString("email", email ?? "User");
        await prefs.setString("LOGIN", "IN");
        return {
          "success": true,
          "accessToken": data['access_token'],
          "user": data['user']
        };
      } else {
        print("Non-201 response received");
        return {
          "success": false,
          "error": "Server returned ${response.statusCode}: ${response.body}"
        };
      }
    } catch (e) {
      print("Request error: $e");
      return {"success": false, "error": "An error occurred: $e"};
    }
  }

 
}

