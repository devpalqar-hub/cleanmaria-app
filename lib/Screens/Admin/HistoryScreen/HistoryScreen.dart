import 'package:cleanby_maria/Screens/Admin/HistoryScreen/ScheduleListView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:cleanby_maria/Screens/Admin/HistoryScreen/Models/CalendarBookingScreen.dart';
import 'package:cleanby_maria/Src/appText.dart';
import 'package:google_fonts/google_fonts.dart';

class BookingsaScreen extends StatefulWidget {
  const BookingsaScreen({super.key});

  @override
  State<BookingsaScreen> createState() => _BookingsaScreenState();
}

class _BookingsaScreenState extends State<BookingsaScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: appText.primaryText(
            text: "Cleaning History",
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.note_alt, color: Colors.black),
              onPressed: () {
                Get.to(() => const ScheduleListScreen());
              },
            ),
          ],
        ),
        body: const CalendarBookingScreen(isStaff: false),
      ),
    );
  }
}
