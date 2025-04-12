import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cleanby_maria/Screens/AuthenticationScreen/controller.dart';
import 'package:cleanby_maria/Src/appButton.dart';
import 'package:cleanby_maria/Src/appText.dart';
import 'package:cleanby_maria/Src/appTextField.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthenticationScreen extends StatelessWidget {
  final AuthenticationController _authController = Get.put(AuthenticationController());

  AuthenticationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(375, 812));

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
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
          SizedBox(height: 40.h),
          Apptextfield.primary(
            labelText: 'Email*',
            hintText: 'Enter your email',
            controller: _authController.emailController,
          ),
          Apptextfield.primary(
            labelText: 'Password',
            hintText: 'Enter your password',
            controller: _authController.passwordController,
          ),
          SizedBox(height: 20.h),
         
          SizedBox(height: 100.h),
          Obx(() => _authController.isLoading.value
              ? CircularProgressIndicator()
              : AppButton(
                  text: "Login",
                  onPressed: _authController.handleLogin,
                  width: 200.w,
                  height: 50.h,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                )),
        ],
      ),
    );
  }
}