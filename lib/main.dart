import 'package:cleanby_maria/Screens/AuthenticationScreen/AutheticationScreen.dart';
import 'package:get/get.dart'; // Import Get package
//import 'package:cleanby_maria/Screens/admin_cleabby_maria/Dashboard/HomeScreen/Services/homeController.dart'; // Import HomeController
import 'package:cleanby_maria/Screens/admin_cleabby_maria/Dashboard/HomeScreen/HomeScreen.dart';

import 'package:cleanby_maria/Screens/admin_cleabby_maria/Dashboard/HomeScreen/views/overview.dart';
import 'package:cleanby_maria/Screens/staff_cleanbymaria/DashBoardScreen/Controller/DashBoardScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
String baseUrl = "https://app.cleanmaria.com/api";
String login = "";
var authHeader;
String userType = "";
String? token;
void main()async { 
  await WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  login = preferences.getString("LOGIN") ?? "";
  token = preferences.getString("accessToken") ?? "";

  if (login == "IN")
    authHeader = {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json"
    };

 // Get.put(HomeController()); 
  runApp(cleanby_maria());
}

class cleanby_maria extends StatelessWidget {
  const cleanby_maria({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 850),
      builder: (context, child) => GetMaterialApp(
          home: (login == "IN")
              ? (userType == "admin")
                  ? Homescreen()
                  : AuthenticationScreen()
              : DashBoardScreen()),
       
        
      
    );
  }
}
