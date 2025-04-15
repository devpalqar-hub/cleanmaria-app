import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class AppButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isPrimary;
  final double? width;
  final double? height;
  final double? fontSize;
  final FontWeight? fontWeight;
  final IconData? icon;
  final Color? iconColor;

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
  });

  @override
  _AppButtonState createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  bool _isLoading = false;

  void _handlePress() async {
  if (!mounted) return; // Ensure the widget is still in the tree

  setState(() {
    _isLoading = true;
  });

  await Future.delayed(const Duration(seconds: 2)); // Simulate a delay

  if (!mounted) return; // Ensure the widget is still in the tree

  setState(() {
    _isLoading = false;  // Should be false, not true
  });

  widget.onPressed();
}

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width ?? 0.85.sw,
      height: widget.height ?? 55.h,
      child: widget.isPrimary
          ? ElevatedButton(
              onPressed: _isLoading ? null : _handlePress,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF19A4C6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
                padding: EdgeInsets.symmetric(horizontal: 10.w), // Ensure content fits
              ),
              child: _isLoading
                  ? LoadingAnimationWidget.staggeredDotsWave(
                      color: Colors.white,
                      size: 20.sp,
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center, // Center content
                      children: [
                        if (widget.icon != null) ...[
                          Icon(widget.icon, size: 14.sp, color: widget.iconColor ?? Colors.white),
                          SizedBox(width: 5.w),
                        ],
                        Text(
                          widget.text,
                          style: TextStyle(
                            fontSize: widget.fontSize,
                            fontWeight: widget.fontWeight,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
            )
          : TextButton(
              onPressed: _isLoading ? null : _handlePress,
              child: _isLoading
                  ? LoadingAnimationWidget.staggeredDotsWave(
                      color: const Color(0xFF19A4C6),
                      size: 20.sp,
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center, // Center content
                      children: [
                        if (widget.icon != null) ...[
                          Icon(widget.icon, size: 14.sp, color: widget.iconColor ?? const Color(0xFF19A4C6)),
                          SizedBox(width: 5.w),
                        ],
                        Text(
                          widget.text,
                          style: TextStyle(
                            fontSize: widget.fontSize,
                            fontWeight: widget.fontWeight,
                            color: const Color(0xFF19A4C6),
                          ),
                        ),
                      ],
                    ),
            ),
    );
  }
}
