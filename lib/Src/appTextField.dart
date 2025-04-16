import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

Widget tBox(
        {TextEditingController? controller,
        String? hint,
        String? prefixText,
        bool? isEnable,
        
         
        TextInputType? keyType}) =>
    Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white,
          ),
          borderRadius: BorderRadius.circular(12.r)),
      child: TextField(
        controller: controller,
        
        style: GoogleFonts.nunitoSans(
            fontWeight: FontWeight.w700,
            fontSize: 13.sp,
            color: Colors.black),
        keyboardType: keyType,
        textAlignVertical: TextAlignVertical.center,
        textAlign: TextAlign.start,
        enabled: isEnable,
        decoration: InputDecoration(
            prefixText: prefixText,
            hintStyle: GoogleFonts.nunitoSans(
                fontWeight: FontWeight.w400,
                fontSize: 16.sp,
                color: Color(0xFF838383)),
            border: InputBorder.none,
            isDense: true,
            hintText: hint),
      ),
    );

class Apptextfield {
  static Widget primary({
    required String labelText,
    required String hintText,
    bool isEnable = true,
     bool obscureText = false,
    TextInputType keyType = TextInputType.text,
    TextEditingController? controller,
    Widget? suffixIcon,
    Function(String)? onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 5.h),
        Text(
          labelText,
          style:
              GoogleFonts.nunitoSans(fontSize: 13.sp, fontWeight: FontWeight.w700),
        ),
        SizedBox(height: 7.h),
        Container(
          height: 50.h,
          width: 330.w,
          decoration: BoxDecoration(
            color: Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(12.r),  
          ),
          child: TextField(
            controller: controller,
             obscureText: obscureText,
            enabled: isEnable,
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 18.w),
              hintText: hintText,
               hintStyle: GoogleFonts.nunitoSans(
                fontWeight: FontWeight.w400,
                fontSize: 16.sp,
          
              ),
              suffixIcon: suffixIcon,
            ),
           
          ),
        ),
        SizedBox(height: 10.h),
      ],
    );
  }

  static Widget password({
    required String labelText,
    required String hintText,
    TextEditingController? controller,
  }) {
    bool obscureText = true;

    return StatefulBuilder(
      builder: (context, setState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 5.h),
            Text(
              labelText,
              style: GoogleFonts.inter(
                  fontSize: 16.sp, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 7.h),
            Container(
              height:50.h,
              width: 330.w,
              decoration: BoxDecoration(
                color: Color(0xFFDEDEDE),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: TextField(
                controller: controller,
                obscureText: obscureText,
                textAlign:
                    TextAlign.start, 
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 18.w),
                  hintText: hintText,
                 hintStyle: GoogleFonts.nunitoSans(
                fontWeight: FontWeight.w400,
                fontSize: 16.sp,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      obscureText ? Icons.visibility : Icons.visibility_off,
                      color: Colors.grey[600],
                    ),
                    onPressed: () {
                      setState(() {
                        obscureText = !obscureText;
                      });
                    },
                  ),
                ),
               
              ),
            ),
            //SizedBox(height: 17.h),
          ],
        );
      },
    );
  }
}
