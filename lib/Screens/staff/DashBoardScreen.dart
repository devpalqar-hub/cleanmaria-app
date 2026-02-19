import 'package:cleanby_maria/Screens/Admin/HistoryScreen/Controller/HistoryController.dart';
import 'package:cleanby_maria/Screens/Admin/HomeScreen/views/MessageIconButton.dart';
import 'package:cleanby_maria/Screens/Admin/ScheduleViewScreen/ScheduleHistoryScreen.dart';
import 'package:cleanby_maria/Screens/Admin/ScheduleViewScreen/ScheduleViewScreen.dart';
import 'package:cleanby_maria/Screens/Chats/Controller/ChatController.dart';
import 'package:cleanby_maria/Screens/staff/Controller/SHomeController.dart';
import 'package:cleanby_maria/Screens/staff/Views/profileSettingsCard.dart';
import 'package:cleanby_maria/Src/appText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  _DashBoardScreenState createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  final HistoryController hisCtrl = Get.put(HistoryController());
  StaffHomeController sHCtrl = Get.put(StaffHomeController());

  String? userId; // will store user_id from SharedPreferences

  @override
  void initState() {
    super.initState();
    _loadUserId(); // load user_id on init
  }

  Future<void> _loadUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getString("user_id") ?? "unknown";
    });
    print("Loaded user_id: $userId");
    // Optionally, you can fetch schedules or other data using this userId
    sHCtrl.fetchShdedule(userId: userId);
  }

  Chatcontroller controller = Get.put(Chatcontroller());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: GetBuilder<StaffHomeController>(builder: (_) {
          return Container(
            //  padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 38.h),
                Row(
                  children: [
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
                    GetBuilder<Chatcontroller>(builder: (__) {
                      return MessageIconButton(
                        unreadCount: __.unReadMessage,
                      );
                    }),
                    SizedBox(
                      width: 10.w,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: InkWell(
                          onTap: () {
                            Get.to(() => ScheduleHistoryScreen(
                                  staffID: userId ?? "",
                                ));
                          },
                          child: Image.asset(
                            "assets/v2/schedules.png",
                            width: 24,
                            height: 24,
                            color: Color(0xff17A5C6),
                          )),
                    ),
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
                    SizedBox(width: 17.w),
                  ],
                ),
                SizedBox(height: 43.h),
                Expanded(
                    child: ScheduleViewScreen(
                  staffID: userId ?? "",
                ))
              ],
            ),
          );
        }),
      ),
    );
  }
}
