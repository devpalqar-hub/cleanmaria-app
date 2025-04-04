//import 'package:cleanby_maria/Screens/admin_cleabby_maria/Dashboard/HomeScreen/Services/homeController.dart';
import 'package:cleanby_maria/Screens/admin_cleabby_maria/Dashboard/HomeScreen/Services/homeController.dart';
import 'package:get/get.dart';
import 'package:cleanby_maria/Screens/admin_cleabby_maria/Dashboard/HomeScreen/views/Graphcard.dart';
import 'package:cleanby_maria/Screens/admin_cleabby_maria/Dashboard/HomeScreen/views/cancellationcard.dart';
import 'package:cleanby_maria/Screens/admin_cleabby_maria/Dashboard/HomeScreen/views/detailcard.dart';
import 'package:cleanby_maria/Screens/admin_cleabby_maria/Dashboard/HomeScreen/views/overview.dart';
import 'package:cleanby_maria/Screens/admin_cleabby_maria/Dashboard/ClientScreen/ClientScreen.dart';
import 'package:cleanby_maria/Screens/admin_cleabby_maria/Dashboard/HistoryScreen/BookingsScreen.dart';
import 'package:cleanby_maria/Screens/admin_cleabby_maria/Dashboard/StaffScreen/StaffScreen.dart';
import 'package:cleanby_maria/Src/appText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
//
class Homescreen extends StatefulWidget {
  Homescreen({super.key});
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  int indexnum = 0;
    final List<Widget> _pages = <Widget>[
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
            BottomNavigationBarItem(
              icon: Image.asset("assets/home.png", color: (indexnum != 0) ? Color(0xff9DB2CE) : Color(0xff17A5C6), height: 24.h),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Image.asset("assets/search.png", color: (indexnum != 1) ? Color(0xff9DB2CE) : Color(0xff17A5C6), height: 24.h),
              label: "Client",
            ),
            BottomNavigationBarItem(
              icon: Image.asset("assets/shop.png", color: (indexnum != 2) ? Color(0xff9DB2CE) : Color(0xff17A5C6), height: 24.h),
              label: "History",
            ),
            BottomNavigationBarItem(
              icon: Image.asset("assets/cart.png", color: (indexnum != 3) ? Color(0xff9DB2CE) : Color(0xff17A5C6), height: 24.h),
              label: "Staff",
            ),
          ],
          iconSize: 24.w,
          selectedFontSize: 11.sp,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          currentIndex: indexnum,
          unselectedFontSize: 11.sp,
          selectedItemColor: Color(0xff17A5C6),
          unselectedItemColor: Color(0xff9DB2CE),
          selectedLabelStyle: GoogleFonts.lexend(fontWeight: FontWeight.w400, fontSize: 10.sp),
          unselectedLabelStyle: GoogleFonts.lexend(fontWeight: FontWeight.w400, fontSize: 10.sp),
          onTap: (int index) {
            setState(() {
              indexnum = index;
            });
          },
        ),
      ),
    );
  }
}


class HomeContent extends StatefulWidget {
  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  final HomeController _controller = HomeController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.fromLTRB(16.w, 41.h, 16.w, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
            children: [
              Image.asset("assets/bname.png", height: 50.h, width: 115.w),
              SizedBox(width: 211.w), // Keep if necessary
            ],
          ),
           SizedBox(height: 15.h),
            ValueListenableBuilder<String>(
              valueListenable: _controller.userName,
              builder: (context, userName, child) {
                return Padding(
                  padding: EdgeInsets.only(left: 14.w),
                  child: Row(
                    children: [
                      appText.primaryText(
                        text: "Nice day, $userName",
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                      ),
                      Expanded(child: Container()),
                      appText.primaryText(
                        text: "Last week",
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w400,
                      ),
                      Icon(Icons.arrow_drop_down_sharp),
                      SizedBox(width: 20.w),
                    ],
                  ),
                );
              },
            ),
            SizedBox(height: 15.h),
            OverViewCard(),
            SizedBox(height: 15.h),
            appText.primaryText(text: "Performance Analysis", fontSize: 18.sp, fontWeight: FontWeight.w700),
            SizedBox(height: 15.h),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    appText.primaryText(text: "From date", fontSize: 12.sp, fontWeight: FontWeight.w600),
                    Container(
                      width: 120.w,
                      height: 40.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6.w),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: TextField(
                        controller: _controller.fromDateController,
                        readOnly: true,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 10.sp),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.fromLTRB(0,10,5,18),
                          prefixIcon: IconButton(
                            onPressed: () => _controller.selectDate(context, _controller.fromDateController,),
                            icon: Icon(Icons.calendar_month_outlined, size: 18.sp),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 15.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    appText.primaryText(text: "To date", fontSize: 12.sp, fontWeight: FontWeight.w600),
                    Container(
                      width: 120.w,
                      height: 40.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6.w),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: TextField(
                        controller: _controller.toDateController,
                        readOnly: true,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 10.sp),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.fromLTRB(0,10,5,18),
                          prefixIcon: IconButton(
                            onPressed: () => _controller.selectDate(context, _controller.toDateController, ),
                            icon: Icon(Icons.calendar_month_outlined, size: 18.sp),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 12.w),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 20, 2,5),
                  child: GestureDetector(
                    onTap: _controller.setTodayDate,
                    child: Container(
                      height: 35.h,
                      width: 83.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.r),
                        color: const Color(0xFF17A5C6),
                      ),
                      child: Center(
                        child: Text("Today", style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 15.h),
            detailcardScreen(),
            SizedBox(height: 20.h),
            LineChartWidget(),
            appText.primaryText(text: "Cancellation", fontSize: 18.sp, fontWeight: FontWeight.w700),
            Cancellationcard(),
          ],
        ),
      ),
    );
  }
}