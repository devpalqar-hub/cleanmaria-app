import 'package:cleanby_maria/Screens/admin_cleabby_maria/Dashboard/HomeScreen/Services/homeController.dart';
import 'package:cleanby_maria/Screens/admin_cleabby_maria/Dashboard/HomeScreen/views/Graphcard.dart';
import 'package:cleanby_maria/Screens/admin_cleabby_maria/Dashboard/HomeScreen/views/cancellationcard.dart';
import 'package:cleanby_maria/Screens/admin_cleabby_maria/Dashboard/HomeScreen/views/detailcard.dart';
import 'package:cleanby_maria/Screens/admin_cleabby_maria/Dashboard/HomeScreen/views/overview.dart';
import 'package:cleanby_maria/Src/appText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
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
          padding: EdgeInsets.fromLTRB(16.w, 41.h, 16.w, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left:2.w),
                child: _buildTopBar(HomeController()),
              ),
              SizedBox(height: 32.h),
              _buildGreetingAndDropdown(),
              SizedBox(height: 15.h),
              OverViewCard(),
              SizedBox(height: 15.h),
              appText.primaryText(
                text: "Performance Analysis",
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
              ),
              SizedBox(height: 15.h),
              _buildDateRangePicker(),
              SizedBox(height: 15.h),
              detailcardScreen(),
              SizedBox(height: 20.h),
              LineChartWidget(),
              SizedBox(height: 15.h),
              appText.primaryText(
                text: "Cancellation",
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
              ),
              Cancellationcard(),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildTopBar(HomeController controller) {
    return Row(
      //crossAxisAlignment: CrossAxisAlignment.start,
      //mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Image.asset("assets/bname.png", height: 50.h, width: 115.w),
        SizedBox(width: 198.w,),
        GestureDetector(
          onTap: () => _showSettingsDialog(context, controller),
          child: Image.asset("assets/settings.png", height: 32.w, width: 32.w),
        ),
      ],
    );
  }

  Widget _buildGreetingAndDropdown() {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal:16.w),
      child: Row(
        
        children: [
          appText.primaryText(
            text: "Nice day, ${hCtrl.userName}",
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
          ),
          const Spacer(),
          DropdownButton<String>(
            value: hCtrl.filterRange,
            hint: Text("Select Range", style: TextStyle(fontSize: 10.sp)),
            items: ["Last Week", "Last Month", "Last Year"].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value, style: TextStyle(fontSize: 10.sp)),
              );
            }).toList(),
            onChanged: (String? newValue) {
              if (newValue != null) {
                hCtrl.filterRange = newValue;
                hCtrl.setDateRangeFromDropdown(newValue);
              }
            },
            icon: const Icon(Icons.arrow_drop_down_sharp),
          ),
          SizedBox(width: 20.w),
        ],
      ),
    );
  }

  Widget _buildDateRangePicker() {
    return Row(
      children: [
        _buildDateInput("From date", hCtrl.fromDateController),
        SizedBox(width: 15.w),
        _buildDateInput("To date", hCtrl.toDateController),
        SizedBox(width: 12.w),
        Padding(
          padding: EdgeInsets.only(top: 20.h),
          child: GestureDetector(
            onTap: () {
              hCtrl.fromDateController.text =
                  DateFormat("yyyy-MM-dd").format(DateTime.now());
              hCtrl.fetchPerformanceData();
            },
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
    );
  }

  Widget _buildDateInput(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        appText.primaryText(
            text: label, fontSize: 12.sp, fontWeight: FontWeight.w600),
        Container(
          width: 120.w,
          height: 40.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6.w),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: TextField(
            controller: controller,
            readOnly: true,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 10.sp),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.fromLTRB(5.w, 5.h, 15.w, 1.h),
              prefixIcon: IconButton(
                onPressed: () => hCtrl.selectDate(context, controller),
                icon: Icon(Icons.calendar_month_outlined, size: 18.sp),
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
                    Navigator.pop(context);
                    // Add your logout logic here
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
