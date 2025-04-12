import 'package:cleanby_maria/Screens/admin_cleabby_maria/Dashboard/ClientScreen/ClientScreen.dart';
import 'package:cleanby_maria/Screens/admin_cleabby_maria/Dashboard/HistoryScreen/BookingsScreen.dart';
import 'package:cleanby_maria/Screens/admin_cleabby_maria/Dashboard/HomeScreen/views/HomeView.dart';
import 'package:cleanby_maria/Screens/admin_cleabby_maria/Dashboard/StaffScreen/StaffScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:cleanby_maria/Screens/admin_cleabby_maria/Dashboard/HomeScreen/Services/homeController.dart';
import 'package:cleanby_maria/Screens/admin_cleabby_maria/Dashboard/HomeScreen/views/Graphcard.dart';
import 'package:cleanby_maria/Screens/admin_cleabby_maria/Dashboard/HomeScreen/views/cancellationcard.dart';
import 'package:cleanby_maria/Screens/admin_cleabby_maria/Dashboard/HomeScreen/views/detailcard.dart';
import 'package:cleanby_maria/Screens/admin_cleabby_maria/Dashboard/HomeScreen/views/overview.dart';

import 'package:cleanby_maria/Src/appText.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Homescreen extends StatefulWidget {
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
    BookingsaScreen(),
    StaffScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: _pages[indexnum],
        bottomNavigationBar: BottomNavigationBar(
          items: [
            _buildBarItem("assets/home.png", "Home", 0),
            _buildBarItem("assets/search.png", "Client", 1),
            _buildBarItem("assets/shop.png", "History", 2),
            _buildBarItem("assets/cart.png", "Staff", 3),
          ],
          currentIndex: indexnum,
          onTap: (index) => setState(() => indexnum = index),
          selectedFontSize: 11.sp,
          unselectedFontSize: 11.sp,
          selectedItemColor: const Color(0xff17A5C6),
          unselectedItemColor: const Color(0xff9DB2CE),
          selectedLabelStyle:
              GoogleFonts.lexend(fontSize: 10.sp, fontWeight: FontWeight.w400),
          unselectedLabelStyle:
              GoogleFonts.lexend(fontSize: 10.sp, fontWeight: FontWeight.w400),
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildBarItem(
      String iconPath, String label, int index) {
    return BottomNavigationBarItem(
      icon: Image.asset(
        iconPath,
        color: indexnum == index
            ? const Color(0xff17A5C6)
            : const Color(0xff9DB2CE),
        height: 24.h,
      ),
      label: label,
    );
  }
}
