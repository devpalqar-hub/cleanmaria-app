import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'Screens/AuthenticationScreen/AutheticationScreen.dart';
import 'Screens/admin_cleabby_maria/Dashboard/HomeScreen/HomeScreen.dart';
import 'Screens/staff_cleanbymaria/DashBoardScreen/Controller/DashBoardScreen.dart';

String baseUrl = "https://app.cleanmaria.com/api";

String login = "";
String? userType = "";
String? token;

Map<String, String> authHeader = {};

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();

  login = prefs.getString("LOGIN") ?? "";
  token = prefs.getString("accessToken") ?? "";
  userType = prefs.getString("userType") ?? "";

  if (token != null && token!.isNotEmpty) {
    authHeader = {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json",
    };
    print("AuthHeader Initialized: $authHeader");
  }

  // Wait for shared preferences to be properly loaded before running the app.
  runApp(const CleanbyMaria());
}

class CleanbyMaria extends StatelessWidget {
  const CleanbyMaria({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 850),
      builder: (context, child) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: (login == "IN")
            ? (userType == "admin" ? DashBoardScreen() : Homescreen())
            : AuthenticationScreen(),
      ),
    );
  }

  Widget _getInitialScreen() {
    // Check if login is successful and if the token is available
    if (login == "IN") {
      if (userType == "admin") {
        return DashBoardScreen(); // Admin Dashboard
      } else {
        return Homescreen(); // Staff Dashboard or other user type
      }
    } else {
      // Default to AuthenticationScreen if not logged in
      return AuthenticationScreen();
    }
  }
}
