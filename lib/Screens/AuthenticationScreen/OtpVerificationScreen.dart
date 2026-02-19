import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:cleanby_maria/Screens/AuthenticationScreen/controller.dart';
import 'package:cleanby_maria/Src/appButton.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String email;
  const OtpVerificationScreen({super.key, required this.email});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final AuthenticationController _authController = Get.find();

  final List<TextEditingController> _otpControllers =
      List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());

  int _resendTimer = 30;
  Timer? _timer;
  bool _canResend = false;

  // ── Lifecycle ───────────────────────────────────────────────────────────────

  @override
  void initState() {
    super.initState();
    _startTimer();
    // Rebuild border colour when any field gains/loses focus
    for (final node in _focusNodes) {
      node.addListener(() => setState(() {}));
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (final c in _otpControllers) c.dispose();
    for (final n in _focusNodes) n.dispose();
    super.dispose();
  }

  // ── Timer ───────────────────────────────────────────────────────────────────

  void _startTimer() {
    _canResend = false;
    _resendTimer = 30;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_resendTimer > 0) {
        setState(() => _resendTimer--);
      } else {
        setState(() => _canResend = true);
        timer.cancel();
      }
    });
  }

  // ── Actions ─────────────────────────────────────────────────────────────────

  String _getOTP() => _otpControllers.map((c) => c.text).join();

  void _handleVerifyOTP() {
    final otp = _getOTP();
    if (otp.length == 6) {
      _authController.handleVerifyOTP(widget.email, otp);
    } else {
      Fluttertoast.showToast(msg: 'Please enter all 6 digits');
    }
  }

  void _handleResendOTP() {
    if (!_canResend) return;
    _authController.handleResendOTP(widget.email);
    for (final c in _otpControllers) c.clear();
    _focusNodes[0].requestFocus();
    _startTimer();
  }

  // ── Build ───────────────────────────────────────────────────────────────────

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
          // ── Top hero (teal) ───────────────────────────────────────────────
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

                // Back button + hero content
                SafeArea(
                  bottom: false,
                  child: Column(
                    children: [
                      // Back button
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 8.w, top: 4.h),
                          child: IconButton(
                            icon: const Icon(Icons.arrow_back_ios_new_rounded,
                                color: Colors.white, size: 20),
                            onPressed: () => Get.back(),
                          ),
                        ),
                      ),

                      // Centered icon + text
                      Expanded(
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Mail icon bubble
                              Container(
                                width: 72.w,
                                height: 72.h,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white.withOpacity(0.18),
                                ),
                                child: Icon(
                                  Icons.mark_email_unread_outlined,
                                  size: 32.sp,
                                  color: Colors.white,
                                ),
                              ),

                              SizedBox(height: 18.h),

                              Text(
                                "Check your inbox",
                                style: TextStyle(
                                  fontSize: 22.sp,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                  letterSpacing: -0.4,
                                ),
                              ),

                              SizedBox(height: 8.h),

                              Text(
                                "We sent a 6-digit code to",
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  color: Colors.white.withOpacity(0.72),
                                ),
                              ),

                              SizedBox(height: 4.h),

                              // Email pill
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 14.w, vertical: 6.h),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.18),
                                  borderRadius: BorderRadius.circular(20.r),
                                ),
                                child: Text(
                                  widget.email,
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 10.h),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // ── Bottom form (white) ───────────────────────────────────────────
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

                    Text(
                      "Enter your code",
                      style: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0D0D0D),
                        letterSpacing: -0.4,
                      ),
                    ),

                    SizedBox(height: 6.h),

                    Text(
                      "Type the 6-digit code sent to your email address.",
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: const Color(0xFF999999),
                        height: 1.5,
                      ),
                    ),

                    SizedBox(height: 32.h),

                    // OTP fields
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(6, (i) => _buildOTPField(i)),
                    ),

                    SizedBox(height: 20.h),

                    // Resend row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Didn't receive the code? ",
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: const Color(0xFF999999),
                          ),
                        ),
                        GestureDetector(
                          onTap: _handleResendOTP,
                          child: Text(
                            _canResend
                                ? "Resend now"
                                : "Resend in ${_resendTimer}s",
                            style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600,
                              color: _canResend
                                  ? const Color(0xFF18B9C5)
                                  : const Color(0xFFCCCCCC),
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 32.h),

                    // Verify button
                    Obx(
                      () => AppButton(
                        text: "Verify OTP",
                        onPressed: _handleVerifyOTP,
                        isLoading: _authController.isLoading.value,
                        width: double.infinity,
                        height: 54.h,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    SizedBox(height: 28.h),

                    // Security note
                    Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.lock_outline_rounded,
                              size: 12, color: const Color(0xFFCCCCCC)),
                          SizedBox(width: 5.w),
                          Text(
                            "This code expires in 10 minutes",
                            style: TextStyle(
                              fontSize: 11.sp,
                              color: const Color(0xFFCCCCCC),
                            ),
                          ),
                        ],
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

  // ── OTP single field ────────────────────────────────────────────────────────

  Widget _buildOTPField(int index) {
    final isFocused = _focusNodes[index].hasFocus;
    final isFilled = _otpControllers[index].text.isNotEmpty;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      width: 46.w,
      height: 56.h,
      decoration: BoxDecoration(
        color: isFilled ? const Color(0xFFEEFBFC) : const Color(0xFFF7F8FA),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(
          color: isFocused
              ? const Color(0xFF18B9C5)
              : isFilled
                  ? const Color(0xFF18B9C5).withOpacity(0.4)
                  : const Color(0xFFE5E7EB),
          width: isFocused ? 2 : 1.5,
        ),
        boxShadow: isFocused
            ? [
                BoxShadow(
                  color: const Color(0xFF18B9C5).withOpacity(0.15),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ]
            : [],
      ),
      child: TextField(
        controller: _otpControllers[index],
        focusNode: _focusNodes[index],
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        style: TextStyle(
          fontSize: 22.sp,
          fontWeight: FontWeight.w700,
          color: const Color(0xFF0D0D0D),
        ),
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        decoration: const InputDecoration(
          border: InputBorder.none,
          counterText: '',
        ),
        onChanged: (value) {
          setState(() {});
          if (value.isNotEmpty && index < 5) {
            _focusNodes[index + 1].requestFocus();
          }
          // Handle backspace — move focus back
          if (value.isEmpty && index > 0) {
            _focusNodes[index - 1].requestFocus();
          }
          // Auto-submit when last digit entered
          if (index == 5 && value.isNotEmpty) {
            _focusNodes[index].unfocus();
          }
        },
        onTap: () {
          _otpControllers[index].selection = TextSelection.fromPosition(
            TextPosition(offset: _otpControllers[index].text.length),
          );
        },
      ),
    );
  }
}
