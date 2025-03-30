import 'package:cleanby_maria/Src/appButton.dart';
import 'package:cleanby_maria/Src/appText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CleaningDetails extends StatelessWidget {
  const CleaningDetails({super.key});

  Widget _infoText({required String title, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        appText.primaryText(
          text: title,
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
        appText.primaryText(
          text: value,
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          color: const Color(0xFF757D7F),
        ),
        SizedBox(height: 10.h),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Cleaning  Details',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_outlined, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0.h),
          child: Container(
            color: const Color(0xFFF2F2F2),
            height: 1.0.h,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 15.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: _infoText(title: "Name", value: "Jhane Doe"),
                ),
                Image.asset(
                  'assets/call.png',
                  width: 30.w,
                  height: 30.h,
                ),
              ],
            ),
            _infoText(title: "Contact Number", value: "+91 237384855555"),
            _infoText(title: "Booking Date", value: "Mon, July 21 - 09:00 - 12:00 AM"),
            _infoText(title: "Service Cost", value: "Estimated Cost : 250"),
            _infoText(title: "Service Plan", value: "Instant Booking"),
            Row(
              children: [
                Expanded(
                  child: _infoText(title: "Service Cost", value: "Estimated Cost : 250"),
                ),
                Container(
                  width: 65.w,
                  height: 19.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: Color(0xFF1C9F0B),
                  ),
                  child: Center(
                    child: appText.primaryText(
                      text: "ECO SERVICE",
                      fontSize: 8.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            _infoText(title: "Email", value: "jhonedoe@gmail.com"),
             _infoText(title: "Completed by", value: "Reema Shareen"),
              _infoText(title: "Status", value: "Completed"),
            _infoText(
              title: "Address",
              value: "House name, House number, Street name, City name, and all the address details.",
            ),
            SizedBox(height: 10.h),
            appText.primaryText(
              text: "Cleaning items given",
              color: Color(0xFF1C9F0B),
              fontSize: 14.sp,
            ),
          ],
        ),
      ),
    );
  }
}
