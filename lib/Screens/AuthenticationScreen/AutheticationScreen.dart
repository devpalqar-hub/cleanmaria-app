import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:cleanby_maria/Screens/AuthenticationScreen/controller.dart';
import 'package:cleanby_maria/Src/appButton.dart';
import 'package:cleanby_maria/Src/appTextField.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthenticationScreen extends StatelessWidget {
  final AuthenticationController _authController =
      Get.put(AuthenticationController());

  AuthenticationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(375, 812));

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: Column(
        children: [
          // ── Top hero area (teal) ──────────────────────────────────────────
          Expanded(
            flex: 4,
            child: Stack(
              children: [
                // Teal background
                Positioned.fill(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color(0xFF18B9C5),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40),
                      ),
                    ),
                  ),
                ),

                // Decorative circle — top right
                Positioned(
                  top: -50,
                  right: -50,
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.07),
                    ),
                  ),
                ),

                // Decorative circle — bottom left
                Positioned(
                  bottom: -20,
                  left: -40,
                  child: Container(
                    width: 140,
                    height: 140,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.06),
                    ),
                  ),
                ),

                // Hero content
                SafeArea(
                  bottom: false,
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 28.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Logo — tinted white
                          Image.asset(
                            "assets/bname.png",
                            height: 54.h,
                            width: 170.w,
                            fit: BoxFit.contain,
                            color: Colors.white,
                          ),

                          SizedBox(height: 18.h),

                          Text(
                            "Your clean home,\non demand.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 22.sp,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              height: 1.3,
                              letterSpacing: -0.4,
                            ),
                          ),

                          SizedBox(height: 8.h),

                          Text(
                            "Sign in to manage your bookings",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 13.sp,
                              color: Colors.white.withOpacity(0.72),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ── Bottom form area (white) ──────────────────────────────────────
          Expanded(
            flex: 5,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 36.h),

                    // Heading
                    Text(
                      "Welcome back 👋",
                      style: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0D0D0D),
                        letterSpacing: -0.4,
                      ),
                    ),

                    SizedBox(height: 6.h),

                    Text(
                      "Enter your email to receive a one-time passcode.",
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: const Color(0xFF999999),
                        height: 1.5,
                      ),
                    ),

                    SizedBox(height: 10.h),

                    // Email label
                    Text(
                      "Email address",
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF444444),
                      ),
                    ),

                    SizedBox(height: 8.h),

                    // Email field — unchanged widget
                    Apptextfield.primary(
                      labelText: '',
                      hintText: 'Enter your email',
                      controller: _authController.emailController,
                      label: '',
                      keyType: TextInputType.emailAddress,
                    ),

                    SizedBox(height: 15.h),

                    // Send OTP button — unchanged logic
                    Obx(
                      () => _authController.isLoading.value
                          ? Center(
                              child: SizedBox(
                                height: 26.h,
                                width: 26.h,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.5,
                                  valueColor: const AlwaysStoppedAnimation(
                                    Color(0xFF18B9C5),
                                  ),
                                ),
                              ),
                            )
                          : AppButton(
                              text: "Send OTP",
                              onPressed: _authController.handleSendOTP,
                              width: double.infinity,
                              height: 54.h,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w600,
                            ),
                    ),

                    SizedBox(height: 28.h),

                    // Divider
                    Row(
                      children: [
                        const Expanded(
                            child: Divider(color: Color(0xFFEEEEEE))),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child: Text(
                            "secure & private",
                            style: TextStyle(
                              fontSize: 11.sp,
                              color: const Color(0xFFCCCCCC),
                            ),
                          ),
                        ),
                        const Expanded(
                            child: Divider(color: Color(0xFFEEEEEE))),
                      ],
                    ),

                    SizedBox(height: 10.h),

                    // // Trust badges
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //   children: [
                    //     _trustBadge(Icons.lock_outline_rounded, "OTP Secured"),
                    //     _trustBadge(Icons.verified_user_outlined, "Verified"),
                    //     _trustBadge(Icons.privacy_tip_outlined, "Private"),
                    //   ],
                    // ),

                    // SizedBox(height: 28.h),

                    // Terms
                    Center(
                      child: Text(
                        "By continuing you agree to our\nTerms of Service & Privacy Policy",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: const Color(0xFFCCCCCC),
                          height: 1.7,
                        ),
                      ),
                    ),

                    SizedBox(height: 16.h),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _trustBadge(IconData icon, String label) {
    return Column(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: const BoxDecoration(
            color: Color(0xFFEEFBFC),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 18, color: const Color(0xFF18B9C5)),
        ),
        SizedBox(height: 5.h),
        Text(
          label,
          style: TextStyle(
            fontSize: 10.sp,
            color: const Color(0xFFAAAAAA),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
