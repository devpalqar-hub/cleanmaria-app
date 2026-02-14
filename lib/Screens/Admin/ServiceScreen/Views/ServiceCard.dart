import 'package:cleanby_maria/Screens/Admin/ServiceScreen/Model/Service%20Model.dart';
import 'package:cleanby_maria/Screens/Admin/ServiceScreen/Views/EditService.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ServiceCard extends StatelessWidget {
  final ServiceModel service;

  const ServiceCard({super.key, required this.service});

  @override
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(
          color: const Color(0xFFE5E7EB),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  service.name,
                  style: GoogleFonts.poppins(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF111827),
                  ),
                ),
              ),
              Row(
                children: [
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3F4F6),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Text(
                      "${service.durationMinutes.toInt()}m",
                      style: GoogleFonts.poppins(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF6B7280),
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    icon: const Icon(Icons.edit, color: Color(0xFF6B7280)),
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
                  ),
                ],
              )
            ],
          ),
          SizedBox(height: 10.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "\$${service.basePrice}/",
                style: GoogleFonts.poppins(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF2D3748),
                ),
              ),
              SizedBox(width: 8.w),
              Padding(
                padding: EdgeInsets.only(bottom: 6.h),
                child: Text(
                  "base price",
                  style: GoogleFonts.poppins(
                    fontSize: 14.sp,
                    color: const Color(0xFF9CA3AF),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Divider(
            thickness: 1,
            color: const Color(0xFFE5E7EB),
          ),
          SizedBox(height: 10.h),
          Row(
            children: [
              _bottomColumn("BATH", service.bathroomRate),
              _verticalDivider(),
              _bottomColumn("ROOM", service.roomRate),
              _verticalDivider(),
              _bottomColumn("SQFT", service.squareFootPrice),
            ],
          ),
        ],
      ),
    );
  }

  Widget _bottomColumn(String label, dynamic value) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 11.sp,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.2,
              color: const Color(0xFFD1D5DB),
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            "\$$value",
            style: GoogleFonts.poppins(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF374151),
            ),
          ),
        ],
      ),
    );
  }

  Widget _verticalDivider() {
    return Container(
      width: 1,
      height: 40.h,
      margin: EdgeInsets.symmetric(horizontal: 12.w),
      color: const Color(0xFFE5E7EB),
    );
  }
}
