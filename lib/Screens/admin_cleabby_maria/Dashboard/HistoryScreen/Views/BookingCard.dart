import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class BookingCard extends StatelessWidget {
  final String name;
  final String phone;
  final String bookingDate;
  final String bookingTime;
  final VoidCallback onCallTap;
  final VoidCallback onBookingTap;

  const BookingCard({
    Key? key,
    required this.name,
    required this.phone,
    required this.bookingDate,
    required this.bookingTime,
    required this.onCallTap,
    required this.onBookingTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 380.w,
      height: 160 .h,
      margin: EdgeInsets.symmetric(vertical: 2.h),
      padding: EdgeInsets.all(15.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: Colors.grey.shade300, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: GoogleFonts.poppins(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    phone,
                    style: GoogleFonts.poppins(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: onCallTap,
                child: Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue,
                  ),
                  child: Icon(
                    Icons.call,
                    color: Colors.white,
                    size: 15.sp,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Divider(color: Colors.grey[300]),
          SizedBox(height: 5.h),
          Text(
            "Booking Date",
            style: GoogleFonts.poppins(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 3.h),
          Row(
            children: [
              Icon(Icons.access_time, size: 16.sp, color: Colors.grey),
              SizedBox(width: 5.w),
              Text(
                "$bookingDate - $bookingTime",
                style: GoogleFonts.poppins(
                  fontSize: 10.sp,
                  color: Colors.grey,
                ),
              ),
            
          
          SizedBox(width: 90.h),
          Align(
            alignment: Alignment.centerRight,
            child: SizedBox(
              width: 60.w,
              height: 20.h,
              child: ElevatedButton(
                onPressed: onBookingTap,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF19A4C6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  padding: EdgeInsets.zero,
                ),
                child: Text(
                  "Booking",
                  style: GoogleFonts.poppins(
                    fontSize: 10.sp,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
            ],
          ),
        ],
      ),
    );
  }
}
