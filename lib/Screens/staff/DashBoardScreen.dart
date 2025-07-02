import 'package:cleanby_maria/Screens/Admin/ClientScreen/BookingDetailsScreen.dart';
import 'package:cleanby_maria/Screens/Admin/ClientScreen/Views/StatusCard.dart';

import 'package:cleanby_maria/Screens/staff/Controller/SHomeController.dart';
import 'package:cleanby_maria/Screens/staff/Views/DutyCard.dart';
import 'package:cleanby_maria/Screens/staff/Views/OverViewCard.dart';
import 'package:cleanby_maria/Screens/staff/Views/profileSettingsCard.dart';
import 'package:cleanby_maria/Src/appText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  _DashBoardScreenState createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  String _selectedDutyStatus = "All Duty";
  final List<String> _dutyOptions = [
    "All Duty",
    "scheduled",
    "completed",
    "missed",
    "refunded"
  ];

  StaffHomeController sHCtrl = Get.put(StaffHomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: GetBuilder<StaffHomeController>(builder: (_) {
          return Container(
            padding: EdgeInsetsDirectional.symmetric(horizontal: 20.w),
            child: SmartRefresher(
              controller: sHCtrl.refreshCtrl,
              onRefresh: () {
                sHCtrl.page = 1;
                sHCtrl.history.clear();
                sHCtrl.fetchShdedule();
                sHCtrl.fetchTodayShedule();
                sHCtrl.update();
              },
              onLoading: () {
                sHCtrl.fetchShdedule();
                sHCtrl.update();
              },
              enablePullDown: true,
              enablePullUp: true,
              child: SingleChildScrollView(
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
                              text: "${sHCtrl.userName}",
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ],
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            showSettingsBottomSheet(
                                context, sHCtrl.userName, sHCtrl.email);
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
                    if (sHCtrl.todayHistory.isNotEmpty)
                      appText.primaryText(
                        text: "Today Duty",
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    if (sHCtrl.todayHistory.isNotEmpty) Dutycard(),SizedBox(width: 10.w,),
                    if (sHCtrl.todayHistory.isNotEmpty) SizedBox(height: 17.h),
                    Row(
                      children: [
                        appText.primaryText(
                          text: "Duty List",
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                        Spacer(),
                        DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: _selectedDutyStatus,
                            icon:
                                Icon(Icons.arrow_drop_down, color: Colors.black),
                                style: const TextStyle(color: Colors.black),
                              dropdownColor: Colors.white,
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedDutyStatus = newValue!;
                                sHCtrl.selectedFilter = newValue;
                                sHCtrl.refreshCtrl.requestRefresh();
                              });
                            },
                            items: _dutyOptions
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value.toString().capitalize!,
                                    style: TextStyle(
                                        fontSize: 11.sp,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black)),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 17.h),
                    if (sHCtrl.history.isEmpty) Image.asset("assets/nojob.png"),
                    for (var data in sHCtrl.history)
                      StatusCard(
                          status: data.status ?? "Unknown",
                          color: sHCtrl.getStatusColor(data.status!),
                          customerName: data.booking!.customer!.name!,
                          onTap: () {
                           if (data.status == "scheduled" || data.status == "completed")
                              Get.to(
                                  () => BookingDetailsScreen(
                                        bookingId: data.booking!.id!,
                                        staff: data.staff!.name,
                                        isStaff: true,
                                        pCtrl: sHCtrl,
                                        scheduleId: data.id,
                                       status: data.status ?? "Unknown",
                                        date:
                                            "${DateFormat("MMM dd,yyyy | hh:mm a").format(DateTime.parse(data.startTime!))} - ${DateFormat("hh:mm a").format(DateTime.parse(data.endTime!))}",
                                      ),
                                  transition: Transition.rightToLeft);
                          },
                          time:
                              "${DateFormat("MMM dd,yyyy | hh:mm a").format(DateTime.parse(data.startTime!))} - ${DateFormat("hh:mm a").format(DateTime.parse(data.endTime!))}",
                          location: "Cleaned By : ${data.staff!.name}"),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
