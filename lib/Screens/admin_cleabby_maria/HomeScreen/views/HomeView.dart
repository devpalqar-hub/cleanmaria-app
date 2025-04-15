import 'package:cleanby_maria/Screens/AuthenticationScreen/AutheticationScreen.dart';
import 'package:cleanby_maria/Screens/admin_cleabby_maria/HomeScreen/Services/homeController.dart';
import 'package:cleanby_maria/Screens/admin_cleabby_maria/HomeScreen/views/Graphcard.dart';
import 'package:cleanby_maria/Screens/admin_cleabby_maria/HomeScreen/views/cancellationcard.dart';
import 'package:cleanby_maria/Screens/admin_cleabby_maria/HomeScreen/views/detailcard.dart';
import 'package:cleanby_maria/Screens/admin_cleabby_maria/HomeScreen/views/overview.dart';
import 'package:cleanby_maria/Screens/staff_cleanbymaria/Views/profileSettingsCard.dart';
import 'package:cleanby_maria/Src/appText.dart';
import 'package:cleanby_maria/Src/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  HomeController hCtrl = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (_) {
      return SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(12.w, 10.h, 12.w, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 2.w),
                child: _buildTopBar(),
              ),
              SizedBox(height: 32.h),
              _buildGreetingAndDropdown(),
              //SizedBox(height: .h),
              OverViewCard(),
              SizedBox(height: 20.h),
              appText.primaryText(
                text: "Performance Analysis",
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(height: 10.h),
              _buildDateRangePicker(),
              SizedBox(height: 15.h),
              detailcardScreen(),
              SizedBox(height: 30.h),
              LineChartWidget(),
              SizedBox(height: 15.h),
              if (hCtrl.history.isNotEmpty)
                appText.primaryText(
                  text: "Cancellation",
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              if (hCtrl.history.isNotEmpty)
                SizedBox(
                  height: 10.w,
                ),
              if (hCtrl.history.isNotEmpty) Cancellationcard(),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildTopBar() {
    return Row(
      //crossAxisAlignment: CrossAxisAlignment.start,
      //mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Image.asset("assets/bname.png", height: 50.h, width: 115.w),
        SizedBox(
          width: 190.w,
        ),
        GestureDetector(
          onTap: () =>
              showSettingsBottomSheet(context, hCtrl.userName, hCtrl.userEmail),
          child: Image.asset("assets/settings.png", height: 32.w, width: 32.w),
        ),
      ],
    );
  }

  Widget _buildGreetingAndDropdown() {
    return Row(
      children: [
        Expanded(
          child: appText.primaryText(
            text: "Nice day, ${hCtrl.userName}",
            maxLines: 1,
            color: Colors.black87,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(width: 20.w),
        DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: hCtrl.filterRange,
            icon: const Icon(Icons.arrow_drop_down_sharp),
            //  hint: const SizedBox.shrink(), // No visible hint
            items: ["Last Week", "Last Month", "Last Year"].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value,
                    style: TextStyle(
                        fontSize: 12.sp, fontWeight: FontWeight.w500)),
              );
            }).toList(),
            onChanged: (String? newValue) {
              if (newValue != null) {
                hCtrl.filterRange = newValue;
                hCtrl.setDateRangeFromDropdown(newValue);
              }
            },
            style: TextStyle(fontSize: 10.sp, color: Colors.black),
            dropdownColor: Colors.white,
            underline: SizedBox(),
          ),
        ),
      ],
    );
  }

  Widget _buildDateRangePicker() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _buildDateInput("From date", hCtrl.fromDateController),
        SizedBox(width: 15.w),
        _buildDateInput("To date", hCtrl.toDateController),
        SizedBox(width: 12.w),
        GestureDetector(
          onTap: () {
            hCtrl.fromDateController.text =
                DateFormat("yyyy/MM/dd").format(DateTime.now());
            hCtrl.toDateController.text =
                DateFormat("yyyy/MM/dd").format(DateTime.now());
            hCtrl.fetchPerformanceData();
          },
          child: Container(
            height: 44.h,
            margin: EdgeInsets.only(bottom: 2.h),
            padding: EdgeInsets.only(left: 20.w, right: 20.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.r),
              color: const Color(0xFF17A5C6),
            ),
            child: Center(
              child: Text("Today",
                  style: TextStyle(color: Colors.white, fontSize: 12.sp)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDateInput(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        appText.primaryText(
            text: label, fontSize: 12.sp, fontWeight: FontWeight.w500),
        SpacerH(5.w),
        InkWell(
          onTap: () {
            hCtrl.selectDate(context, controller);
          },
          child: Container(
            width: 125.w,
            height: 45.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6.w),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: TextField(
              controller: controller,
              textAlignVertical: TextAlignVertical.top,
              readOnly: true,
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600),
              decoration: InputDecoration(
                  isDense: true,
                  //isCollapsed: true,
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(
                    left: 10.w,
                    right: 10.w,
                  ),
                  suffix: InkWell(
                    child: Icon(
                      Icons.calendar_month,
                      size: 15.sp,
                      color: Colors.black54,
                    ),
                  )
                  // prefixIcon: IconButton(
                  //   onPressed: () => hCtrl.selectDate(context, controller),
                  //   icon: Icon(Icons.calendar_month_outlined, size: 20.sp),
                  // ),
                  ),
            ),
          ),
        ),
      ],
    );
  }

  void _showSettingsDialog(BuildContext context, HomeController controller) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.r),
        ),
        content: SizedBox(
          width: 323.w,
          child: Column(
            mainAxisSize: MainAxisSize.min,
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
                  const Spacer(),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close, color: Colors.black),
                  ),
                ],
              ),
              SizedBox(height: 30.h),
              CircleAvatar(
                radius: 62.w,
                backgroundColor: Colors.grey[300],
                child: Icon(
                  Icons.person,
                  size: 62.w,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 15.h),

              /// 🔁 Dynamically display name from ValueNotifier
              Text(
                hCtrl.userName,
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),

              SizedBox(height: 2.h),

              /// 🔁 Dynamically display email from ValueNotifier
              Text(
                hCtrl.userEmail,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),

              SizedBox(height: 25.h),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Get.offAll(() => AuthenticationScreen(),
                        transition: Transition.rightToLeft);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF19A4C6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                  ),
                  child: Text(
                    "Logout",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
