import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class appButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isPrimary;

  const appButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.isPrimary = true,
  }) : super(key: key);

  @override
  _AppButtonState createState() => _AppButtonState();
}

class _AppButtonState extends State<appButton> {
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
      width: 330.w,
      height: 60.h,
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
                      size: 30,
                    )
                  : Text(
                      widget.text,
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
            )
          : TextButton(
              onPressed: _isLoading ? null : _handlePress,
              child: _isLoading
                  ? LoadingAnimationWidget.staggeredDotsWave(
                      color: const Color(0xFF19A4C6),
                      size: 30,
                    )
                  : Text(
                      widget.text,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF19A4C6),
                      ),
                    ),
            ),
    );
  }
}
