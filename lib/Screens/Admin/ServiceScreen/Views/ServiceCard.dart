import 'package:cleanby_maria/Screens/Admin/ServiceScreen/Model/Service%20Model.dart';
import 'package:cleanby_maria/Screens/Admin/ServiceScreen/Views/EditService.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/utils.dart';

class ServiceCard extends StatelessWidget {
  final ServiceModel service;

  const ServiceCard({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 2.h),
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: const Color(0xFFEEEEEE), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  service.name.tr,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF111827),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 9.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F4F6),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  children: [
                    Icon(Icons.timer_outlined,
                        size: 11.sp, color: const Color(0xFF9CA3AF)),
                    SizedBox(width: 3.w),
                    Text(
                      "${service.durationMinutes.toInt()}m",
                      style: GoogleFonts.poppins(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF6B7280),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 6.w),
              GestureDetector(
                onTap: () {
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
                child: Container(
                  padding: EdgeInsets.all(6.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF9FAFB),
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(color: const Color(0xFFE5E7EB)),
                  ),
                  child: Icon(Icons.edit_outlined,
                      size: 14.sp, color: const Color(0xFF6B7280)),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Base price".tr,
                    style: GoogleFonts.poppins(
                      fontSize: 10.sp,
                      color: const Color(0xFF9CA3AF),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    "\$${service.basePrice}",
                    style: GoogleFonts.poppins(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF111827),
                      height: 1.1,
                    ),
                  ),
                ],
              ),
              SizedBox(width: 14.w),
              Container(
                width: 1,
                height: 36.h,
                color: const Color(0xFFE5E7EB),
              ),
              SizedBox(width: 14.w),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _rateChip("BATH".tr, service.bathroomRate),
                    _rateChip("ROOM".tr, service.roomRate),
                    _rateChip("SQFT".tr, service.squareFootPrice),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _rateChip(String label, dynamic value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 9.sp,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.8,
            color: const Color(0xFFD1D5DB),
          ),
        ),
        SizedBox(height: 3.h),
        Text(
          "\$$value",
          style: GoogleFonts.poppins(
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF374151),
          ),
        ),
      ],
    );
  }
}
