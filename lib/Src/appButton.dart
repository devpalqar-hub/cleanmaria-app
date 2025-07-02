import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isPrimary;
  final double? width;
  final double? height;
  final double? fontSize;
  final FontWeight? fontWeight;
  final IconData? icon;
  final Color? iconColor;
  final bool isLoading;

  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isPrimary = true,
    this.width,
    this.height,
    this.fontSize,
    this.fontWeight,
    this.icon,
    this.iconColor,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 0.85.sw,
      height: height ?? 55.h,
      child: isPrimary
          ? ElevatedButton(
              onPressed: isLoading ? null : onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF19A4C6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
                padding: EdgeInsets.symmetric(horizontal: 10.w),
              ),
              child: isLoading
                  ? LoadingAnimationWidget.staggeredDotsWave(
                      color: Colors.white,
                      size: 20.sp,
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (icon != null) ...[
                          Icon(icon, size: 14.sp, color: iconColor ?? Colors.white),
                          SizedBox(width: 5.w),
                        ],
                        Text(
                          text,
                          style: TextStyle(
                            fontSize: fontSize,
                            fontWeight: fontWeight,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
            )
          : TextButton(
              onPressed: isLoading ? null : onPressed,
              child: isLoading
                  ? LoadingAnimationWidget.staggeredDotsWave(
                      color: const Color(0xFF19A4C6),
                      size: 20.sp,
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (icon != null) ...[
                          Icon(icon, size: 14.sp, color: iconColor ?? const Color(0xFF19A4C6)),
                          SizedBox(width: 5.w),
                        ],
                        Text(
                          text,
                          style: TextStyle(
                            fontSize: fontSize,
                            fontWeight: fontWeight,
                            color: const Color(0xFF19A4C6),
                          ),
                        ),
                      ],
                    ),
            ),
    );
  }
}
