import 'package:cleanby_maria/Screens/AuthenticationScreen/AutheticationScreen.dart';
import 'package:cleanby_maria/Screens/admin_cleabby_maria/Dashboard/HomeScreen/HomeScreen.dart';
import 'package:cleanby_maria/Screens/admin_cleabby_maria/Dashboard/HomeScreen/views/overview.dart';
import 'package:cleanby_maria/Screens/admin_cleabby_maria/Dashboard/SearchScreen/searchScreen.dart';
import 'package:cleanby_maria/Screens/admin_cleabby_maria/Dashboard/ShopScreen/ShopScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() {
  runApp(cleanby_maria());
}

class cleanby_maria extends StatelessWidget {
  const cleanby_maria({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize:const Size(390,850),
      builder:(context,child) => GetMaterialApp(home:Shopscreen()
      ),
    );
  }
}