import 'dart:developer';
import 'package:cleanby_maria/Screens/Admin/ClientScreen/ClientScreen.dart';
import 'package:cleanby_maria/Screens/Admin/HistoryScreen/HistoryScreen.dart';
import 'package:cleanby_maria/Screens/Admin/HistoryScreen/ScheduleListView.dart';
import 'package:cleanby_maria/Screens/Admin/HomeScreen/views/HomeView.dart';
import 'package:cleanby_maria/Screens/Admin/ScheduleViewScreen/ScheduleViewScreen.dart';
import 'package:cleanby_maria/Screens/Admin/ServiceScreen/ServiceScreen.dart';
import 'package:cleanby_maria/Screens/Admin/StaffScreen/StaffScreen.dart';
import 'package:cleanby_maria/Screens/Chats/Controller/ChatController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cleanby_maria/Screens/Admin/HomeScreen/Services/homeController.dart';
import 'package:cleanby_maria/Screens/Admin/HomeScreen/views/Graphcard.dart';
import 'package:cleanby_maria/Screens/Admin/HomeScreen/views/cancellationcard.dart';
import 'package:cleanby_maria/Screens/Admin/HomeScreen/views/detailcard.dart';
import 'package:cleanby_maria/Screens/Admin/HomeScreen/views/overview.dart';
import 'package:cleanby_maria/Src/appText.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  int indexnum = 0;
  @override
  void initState() {
    super.initState();
  }

  final List<Widget> _pages = [
    HomeContent(),
    ClientScreen(),
    // BookingsaScreen(),
    ScheduleViewScreen(),
    StaffScreen(),
    ServiceScreen(),
  ];

  Chatcontroller cctrl = Get.put(Chatcontroller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _pages[indexnum],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          _buildBarItem("assets/v2/home.png", "Home", 0),
          _buildBarItem("assets/v2/bookings.png", "Bookings", 1),
          _buildBarItem("assets/v2/schedules.png", "Schedules", 2),
          _buildBarItem("assets/v2/staff.png", "Staff", 3),
          _buildBarItem("assets/v2/services.png", "Service", 4),
        ],
        currentIndex: indexnum,
        showUnselectedLabels: true,
        onTap: (index) => setState(() => indexnum = index),
        selectedFontSize: 11.sp,
        backgroundColor: Colors.white,
        unselectedFontSize: 11.sp,
        selectedItemColor: const Color(0xff17A5C6),
        unselectedItemColor: const Color(0xff9DB2CE),
        selectedLabelStyle:
            GoogleFonts.lexend(fontSize: 12.sp, fontWeight: FontWeight.w400),
        unselectedLabelStyle:
            GoogleFonts.lexend(fontSize: 12.sp, fontWeight: FontWeight.w400),
      ),
    );
  }

  BottomNavigationBarItem _buildBarItem(
      String iconPath, String label, int index) {
    return BottomNavigationBarItem(
      backgroundColor: Colors.white,
      icon: Image.asset(
        iconPath,
        color: indexnum == index
            ? const Color(0xff17A5C6)
            : const Color(0xff9DB2CE),
        height: 22.h,
      ),
      label: label,
    );
  }
}
