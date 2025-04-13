import 'package:cleanby_maria/Screens/AuthenticationScreen/AutheticationScreen.dart';
import 'package:cleanby_maria/Screens/staff_cleanbymaria/BookingScreen/BookingScreen.dart';
import 'package:cleanby_maria/Screens/staff_cleanbymaria/DashBoardScreen/Controller/Views/DutyCard.dart';
import 'package:cleanby_maria/Screens/staff_cleanbymaria/DashBoardScreen/Controller/Views/OverViewCard.dart';
import 'package:cleanby_maria/Screens/staff_cleanbymaria/DashBoardScreen/Controller/Views/StatusDuty.dart';
import 'package:cleanby_maria/Src/appText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  _DashBoardScreenState createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  String _selectedDutyStatus = "All Duty";
  final List<String> _dutyOptions = [
    "All Duty",
    "Completed",
    "Pending",
    "Cancelled"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          padding: EdgeInsetsDirectional.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 38.h),
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.asset(
                      "assets/profile.png",
                      height: 46.w,
                      width: 46.w,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 17.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      appText.primaryText(
                        text: "Welcome back",
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(height: 1.h),
                      appText.primaryText(
                        text: "Reema Salam",
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      _showSettingsDialog(context);
                    },
                    child: Image.asset(
                      "assets/settings.png",
                      height: 24.w,
                      width: 24.w,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 43.h),
              appText.primaryText(
                text: "Overview",
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(height: 6.h),
              OverViewCard(),
              SizedBox(height: 30.h),
              appText.primaryText(
                text: "Today Duty",
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
              Dutycard(),
              SizedBox(height: 17.h),
              Row(
                children: [
                  appText.primaryText(
                    text: "Duty List",
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                  Spacer(),
                  DropdownButton<String>(
                    value: _selectedDutyStatus,
                    icon: Icon(Icons.arrow_drop_down, color: Colors.black),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedDutyStatus = newValue!;
                      });
                    },
                    items: _dutyOptions
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value,
                            style: TextStyle(
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w400,
                                color: Colors.black)),
                      );
                    }).toList(),
                  ),
                ],
              ),
              SizedBox(height: 17.h),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BookingScreen()),
                  );
                },
                child: Statusduty(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showSettingsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.r),
          ),
          content: SizedBox(
            width: 323.w,
            height: 375.h,
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      "Settings",
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                        fontFamily: "NunitoSans",
                        color: Colors.black,
                      ),
                    ),
                    Spacer(),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.close, color: Colors.black),
                    ),
                  ],
                ),
                SizedBox(height: 30.h),
                CircleAvatar(
                  radius: 62.w,
                  backgroundColor: Colors.grey[300],
                  child: Icon(Icons.person, size: 62.w, color: Colors.white),
                ),
                SizedBox(height: 15.h),
                Text(
                  "Reema Salam",
                  style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                      fontFamily: "NunitoSans",
                      color: Colors.black),
                ),
                SizedBox(height: 2.h),
                Text(
                  "reemasalam@gmail.com",
                  style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w500,
                      fontFamily: "NunitoSans",
                      color: Colors.black),
                ),
                SizedBox(height: 25.h),
                ElevatedButton(
                  onPressed: () {
                    //Navigator.pop(context);
                 
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF19A4C6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  child: Text(
                    "Logout",
                    style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                        fontFamily: "NunitoSans",
                        color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
