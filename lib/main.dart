import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'Screens/AuthenticationScreen/AutheticationScreen.dart';
import 'Screens/admin_cleabby_maria/HomeScreen/HomeScreen.dart';
import 'Screens/staff_cleanbymaria/DashBoardScreen.dart';

String baseUrl = "https://app.cleanmaria.com/api";

String login = "";
String? userType = "";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();

  login = prefs.getString("LOGIN") ?? "";
  userType = prefs.getString("role") ?? "";
  print(userType);
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
            ? (userType == "staff" ? DashBoardScreen() : Homescreen())
            : AuthenticationScreen(),
      ),
    );
  }
}
