import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'Screens/AuthenticationScreen/AutheticationScreen.dart';
import 'Screens/Admin/HomeScreen/HomeScreen.dart';
import 'Screens/staff/DashBoardScreen.dart';

String baseUrl = "https://app.cleanmaria.com/api";

String login = "";
String? userType = "";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
        home: const SplashScreen(),
      ),
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  Future<Widget> _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String loginStatus = prefs.getString("LOGIN") ?? "";
    String userType = prefs.getString("role") ?? "";

    if (loginStatus == "IN") {
      return userType == "staff" ? DashBoardScreen() : Homescreen();
    } else {
      return AuthenticationScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Widget>(
      future: _checkLoginStatus(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else {
          return snapshot.data!;
        }
      },
    );
  }
}
