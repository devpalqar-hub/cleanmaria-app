import 'package:cleanby_maria/Screens/AuthenticationScreen/AutheticationScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

void showSettingsBottomSheet(
    BuildContext context, String name, String emailID) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      return Container(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.r),
            topRight: Radius.circular(30.r),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Bottom sheet handle
              Container(
                width: 40.w,
                height: 4.h,
                margin: EdgeInsets.only(bottom: 16.h),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),

              // Header
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
                    splashRadius: 24,
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              // Profile picture
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: CircleAvatar(
                  radius: 62.w,
                  backgroundColor: Colors.grey[300],
                  child: Icon(Icons.person, size: 62.w, color: Colors.white),
                ),
              ),
              SizedBox(height: 16.h),
              // User name
              Text(
                "${name}",
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                  fontFamily: "NunitoSans",
                  color: Colors.black,
                ),
              ),

              SizedBox(height: 4.h),

              // User email
              Text(
                "${emailID}",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  fontFamily: "NunitoSans",
                  color: Colors.grey[600],
                ),
              ),

              SizedBox(height: 32.h),

              // Settings options
              // _buildSettingsOption(
              //   icon: Icons.account_circle_outlined,
              //   title: "Account Settings",
              //   onTap: () {
              //     // Navigate to account settings
              //     Navigator.pop(context);
              //     // Add your navigation logic here
              //   },
              // ),

              // _buildSettingsOption(
              //   icon: Icons.notifications_none_rounded,
              //   title: "Notifications",
              //   onTap: () {
              //     // Navigate to notifications settings
              //     Navigator.pop(context);
              //     // Add your navigation logic here
              //   },
              // ),
              _buildSettingsOption(
                icon: Icons.help_outline_rounded,
                title: "Estimate Service",
                onTap: () {
                  // Navigate to help center
                  launchUrl(
                      Uri.parse("https://cleanmaria.com/estimate-service"));
                  // Add your navigation logic here
                },
              ),

              _buildSettingsOption(
                icon: Icons.help_outline_rounded,
                title: "Help Center",
                onTap: () {
                  // Navigate to help center
                  launchUrl(Uri.parse("https://mariacleaning.com"));
                  // Add your navigation logic here
                },
              ),

              SizedBox(height: 32.h),

              // Logout button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    // Logout logic
                    SharedPreferences pref =
                        await SharedPreferences.getInstance();

                    Fluttertoast.showToast(msg: "Session Expired");
                    pref.setString("LOGIN", "OUT");

                    Get.offAll(() => AuthenticationScreen(),
                        transition: Transition.rightToLeft);
                    Get.deleteAll();

                    // Add your logout logic here
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF19A4C6),
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    "Logout",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      fontFamily: "NunitoSans",
                    ),
                  ),
                ),
              ),

              SizedBox(height: 16.h),
            ],
          ),
        ),
      );
    },
  );
}

Widget _buildSettingsOption({
  required IconData icon,
  required String title,
  required VoidCallback onTap,
}) {
  return InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(12.r),
    child: Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(
              icon,
              color: const Color(0xFF19A4C6),
              size: 24.w,
            ),
          ),
          SizedBox(width: 16.w),
          Text(
            title,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              fontFamily: "NunitoSans",
              color: Colors.black,
            ),
          ),
          Spacer(),
          Icon(
            Icons.arrow_forward_ios_rounded,
            color: Colors.grey.shade400,
            size: 16.w,
          ),
        ],
      ),
    ),
  );
}
