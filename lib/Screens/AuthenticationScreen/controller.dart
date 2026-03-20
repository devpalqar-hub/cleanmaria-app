import 'dart:convert';
import 'dart:developer';
import 'package:cleanby_maria/Screens/User/UserHomeScreen/UserHomeScreen.dart';
import 'package:cleanby_maria/main.dart';
import 'package:cleanby_maria/Screens/AuthenticationScreen/OtpVerificationScreen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:cleanby_maria/Screens/Admin/HomeScreen/HomeScreen.dart';
import 'package:cleanby_maria/Screens/staff/DashBoardScreen.dart';

class AuthenticationController extends GetxController {
  var isLoading = false.obs;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> handleSendOTP() async {
    if (emailController.text.isEmpty) {
      Fluttertoast.showToast(msg: 'Email cannot be empty'.tr);
      return;
    }

    if (!emailController.text.isEmail) {
      Fluttertoast.showToast(msg: 'Please enter a valid email'.tr);
      return;
    }

    isLoading.value = true;

    try {
      final response = await generateOTP(emailController.text);
      print(response);

      if (response['success']) {
        Fluttertoast.showToast(msg: 'OTP sent to your email'.tr);
        Get.to(() => OtpVerificationScreen(email: emailController.text),
            transition: Transition.rightToLeft);
      } else {
        Fluttertoast.showToast(
            msg: (response['message'] ?? 'Failed to send OTP'.tr));
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'An error occurred: $e'.tr);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> handleResendOTP(String email) async {
    isLoading.value = true;

    try {
      final response = await generateOTP(email);
      print(response);

      if (response['success']) {
        Fluttertoast.showToast(msg: 'OTP resent to your email'.tr);
      } else {
        Fluttertoast.showToast(
            msg: (response['message'] ?? 'Failed to resend OTP'.tr));
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'An error occurred: $e'.tr);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> handleVerifyOTP(String email, String otp) async {
    isLoading.value = true;

    try {
      final response = await verifyOTP(email, otp);
      print(response);

      if (response['success']) {
        Fluttertoast.showToast(msg: 'Login successful'.tr);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String? role = prefs.getString("role");

        print("User role: $role");

        if (role == 'admin') {
          Get.offAll(() => Homescreen(), transition: Transition.rightToLeft);
        } else if (role == "customer") {
          Get.offAll(() => UserHomeScreen(),
              transition: Transition.rightToLeft);
        } else {
          Get.offAll(() => DashBoardScreen(),
              transition: Transition.rightToLeft);
        }
      } else {
        Fluttertoast.showToast(msg: (response['message'] ?? 'Invalid OTP'.tr));
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'An error occurred: $e'.tr);
    } finally {
      isLoading.value = false;
    }
  }

  Future<Map<String, dynamic>> generateOTP(String email) async {
    String otpUrl = "$baseUrl/auth/otp/generate";

    try {
      final response = await http.post(
        Uri.parse(otpUrl),
        body: jsonEncode({"email": email.trim()}),
        headers: {
          "Content-Type": "application/json",
        },
      );
      print(email);
      print("Status code: ${response.statusCode}");
      print("Raw response body: ${response.body}");
      final Map<String, dynamic> data = json.decode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return {
          "success": true,
          "message": data['message'] ?? "OTP sent successfully".tr
        };
      } else {
        return {
          "success": false,
          "message": data['message'] ?? "Failed to send OTP".tr
        };
      }
    } catch (e) {
      return {"success": false, "message": "An error occurred: $e".tr};
    }
  }

  Future<Map<String, dynamic>> verifyOTP(String email, String otp) async {
    String verifyUrl = "$baseUrl/auth/otp/verify";

    try {
      final response = await http.post(
        Uri.parse(verifyUrl),
        body: jsonEncode({"email": email, "otp": otp}),
        headers: {
          "Content-Type": "application/json",
        },
      );

      final Map<String, dynamic> data = json.decode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (data.containsKey('access_token')) {
          final accessToken = data['access_token'];
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString("access_token", data['access_token']);
          await prefs.setString("user_id", data['user']['id'] ?? "user");
          await prefs.setString("role", data['user']['role'] ?? "user");
          await prefs.setString("user_name", data['user']['name'] ?? "User");
          await prefs.setString("email", email);
          await prefs.setString("LOGIN", "IN");
          authToken = accessToken;
          userID = data['user']['id'];
          setFcmToken(data['user']['id']);
          return {
            "success": true,
            "accessToken": data['access_token'],
            "user": data['user']
          };
        } else {
          return {
            "success": false,
            "message": data['message'] ?? "Invalid response from server".tr
          };
        }
      } else {
        return {
          "success": false,
          "message": data['message'] ?? "Invalid OTP".tr
        };
      }
    } catch (e) {
      return {"success": false, "message": "An error occurred: $e".tr};
    }
  }

  setFcmToken(String userID) async {
    FirebaseMessaging fcm = FirebaseMessaging.instance;
    String token = await fcm.getToken() ?? "";

    try {
      if (token == "") return;
      final resposen = await http.patch(Uri.parse(baseUrl + "/users/fcm-token"),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $authToken',
          },
          body: jsonEncode({"userid": "", "fcmToken": token}));

      log("FCM TOKEN --> ${resposen.statusCode} -> ${resposen.body}");
    } finally {}
  }

  Future<void> handleLogin() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      Fluttertoast.showToast(msg: 'Email and password cannot be empty'.tr);
      return;
    }

    isLoading.value = true;

    try {
      final response =
          await login(emailController.text, passwordController.text);

      if (response['success']) {
        Fluttertoast.showToast(msg: 'Login successful'.tr);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String? role = prefs.getString("role");

        if (role == 'admin') {
          Get.offAll(() => Homescreen(), transition: Transition.rightToLeft);
        } else {
          Get.offAll(() => DashBoardScreen(),
              transition: Transition.rightToLeft);
        }
      } else {
        Fluttertoast.showToast(msg: " Invalid credentials ".tr);
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'An error occurred: $e'.tr);
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

      final Map<String, dynamic> data = json.decode(response.body);

      if (response.statusCode == 201 && data.containsKey('access_token')) {
        final accessToken = data['access_token'];
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString("access_token", data['access_token']);
        await prefs.setString("user_id", data['user']['id'] ?? "user");
        await prefs.setString("role", data['user']['role'] ?? "user");
        await prefs.setString("user_name", data['user']['name'] ?? "User");
        await prefs.setString("email", email);
        await prefs.setString("LOGIN", "IN");
        return {
          "success": true,
          "accessToken": data['access_token'],
          "user": data['user']
        };
      } else {
        return {"success": false, "error": "Login failed".tr};
      }
    } catch (e) {
      return {"success": false, "error": "An error occurred: $e".tr};
    }
  }
}
