import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cleanby_maria/Screens/AuthenticationScreen/controller.dart';
import 'package:cleanby_maria/Src/appButton.dart';
import 'package:cleanby_maria/Src/appText.dart';
import 'package:cleanby_maria/Src/appTextField.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthenticationScreen extends StatelessWidget {
  final AuthenticationController _authController =
      Get.put(AuthenticationController());

  AuthenticationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(375, 812));

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 141.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 71.w),
                child: Image.asset(
                  "assets/bname.png",
                  height: 103.h,
                  width: 247.w,
                ),
              ),
              SizedBox(height: 37.h),
              appText.primaryText(
                text: "Welcome Back",
                fontSize: 24.sp,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF000000),
              ),
              SizedBox(height: 12.h),
              Text(
                "Enter your email to receive OTP",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 40.h),
              Apptextfield.primary(
                labelText: 'Email*',
                hintText: 'Enter your email',
                controller: _authController.emailController,
                label: '',
                keyType: TextInputType.emailAddress,
              ),
              SizedBox(height: 40.h),
              Obx(() => _authController.isLoading.value
                  ? CircularProgressIndicator()
                  : AppButton(
                      text: "Send OTP",
                      onPressed: _authController.handleSendOTP,
                      width: 200.w,
                      height: 50.h,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    )),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}
