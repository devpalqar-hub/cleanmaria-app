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

  const AppButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.isPrimary = true,
    this.width, // Allow width customization
    this.height, // Allow height customization
    this.fontSize, // Allow font size customization
    this.fontWeight, // Allow font weight customization
  }) : super(key: key);

  @override
  _AppButtonState createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  bool _isLoading = false;

  void _handlePress() async {
    setState(() {
      _isLoading = true;
    });

    await Future.delayed(const Duration(seconds: 2)); // Simulate a delay

    setState(() {
      _isLoading = false;
    });

    widget.onPressed();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width ?? 0.85.sw, // Default width 85% of screen width
      height: widget.height ?? 55.h, // Default height using ScreenUtil
      child: widget.isPrimary
          ? ElevatedButton(
              onPressed: _isLoading ? null : _handlePress,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF19A4C6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
              child: _isLoading
                  ? LoadingAnimationWidget.staggeredDotsWave(
                      color: Colors.white,
                      size: 30.sp,
                    )
                  : Text(
                      widget.text,
                      style: TextStyle(
                        fontSize: widget.fontSize , // Default font size
                        fontWeight:
                            widget.fontWeight ,// Default weight
                        color: Colors.white,
                      ),
                    ),
            )
          : TextButton(
              onPressed: _isLoading ? null : _handlePress,
              child: _isLoading
                  ? LoadingAnimationWidget.staggeredDotsWave(
                      color: const Color(0xFF19A4C6),
                      size: 30.sp,
                    )
                  : Center(
                    child: Text(
                        widget.text,
                        style: TextStyle(
                          fontSize: widget.fontSize , // Default font size
                          fontWeight:
                              widget.fontWeight, // Default weight
                          color: const Color(0xFF19A4C6),
                        ),
                      ),
                  ),
            ),
    );
  }
}
