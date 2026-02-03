import 'package:cleanby_maria/Screens/Admin/ServiceScreen/Model/Service%20Model.dart';
import 'package:cleanby_maria/Screens/Admin/ServiceScreen/Views/EditService.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ServiceCard extends StatelessWidget {
  final ServiceModel service;

  const ServiceCard({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 352.w,
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: Colors.teal.shade100),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 4,
            offset: const Offset(0, 2),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// HEADER (NAME + EDIT)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  service.name,
                  style: GoogleFonts.poppins(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF19A4C6),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.edit, color: Color(0xFF19A4C6)),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.vertical(top: Radius.circular(20.r)),
                    ),
                    builder: (context) =>
                        EditServiceBottomSheet(service: service),
                  );
                },
              )
            ],
          ),

          SizedBox(height: 6.h),

          /// BASIC INFO
          Text(
            "Duration: ${service.durationMinutes.toInt()} minutes",
            style: GoogleFonts.poppins(fontSize: 13.sp),
          ),
          Text(
            "Base Price: \$${service.basePrice}",
            style: GoogleFonts.poppins(fontSize: 13.sp),
          ),

          SizedBox(height: 12.h),

          /// GRID PRICING
          Row(
            children: [
              _priceBox("Bathroom", service.bathroomRate),
              _priceBox("Room", service.roomRate),
              _priceBox("Sqft", service.squareFootPrice),
            ],
          ),
        ],
      ),
    );
  }

  Widget _priceBox(String title, dynamic price) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 4.w),
        padding: EdgeInsets.symmetric(vertical: 10.h),
        decoration: BoxDecoration(
          color: Colors.teal.shade50,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: Colors.teal.shade100),
        ),
        child: Column(
          children: [
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              "\$$price",
              style: GoogleFonts.poppins(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF19A4C6),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
