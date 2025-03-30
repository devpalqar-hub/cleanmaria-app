import 'package:cleanby_maria/Screens/AuthenticationScreen/AutheticationScreen.dart';
import 'package:cleanby_maria/Screens/admin_cleabby_maria/Dashboard/Dashboard/DashboardScreen.dart';
import 'package:cleanby_maria/Screens/admin_cleabby_maria/Dashboard/HomeScreen/HomeScreen.dart';
import 'package:cleanby_maria/Screens/admin_cleabby_maria/Dashboard/HomeScreen/views/overview.dart';

//import 'package:cleanby_maria/Screens/admin_cleabby_maria/Dashboard/HistoryScreen/CleaningHistory.dart';
import 'package:cleanby_maria/Screens/staff_cleanbymaria/DashBoardScreen/Controller/DashBoardScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(const cleanby_maria());
}

class cleanby_maria extends StatelessWidget {
  const cleanby_maria({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 850),
      builder: (context, child) => Sizer(
        builder: (context, orientation, deviceType) {
          return GetMaterialApp(home: AuthenticationScreen());
        },
      ),
    );
  }
}
