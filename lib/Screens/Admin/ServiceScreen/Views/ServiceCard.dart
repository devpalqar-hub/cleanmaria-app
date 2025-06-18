import 'package:cleanby_maria/Screens/Admin/ServiceScreen/Model/Service%20Model.dart';
import 'package:cleanby_maria/Screens/Admin/ServiceScreen/Views/EditService.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ServiceCard extends StatefulWidget {
  final ServiceModel service;

  const ServiceCard({super.key, required this.service});

  @override
  State<ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<ServiceCard> {
  late String name;
  late double duration;

  @override
  void initState() {
    super.initState();
    name = widget.service.name;
    duration = widget.service.durationMinutes;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
     // height: 220.h,
      width: 352.w,
      margin: EdgeInsets.only(bottom: 5.h),
      padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 15.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(
          color: const Color.fromARGB(255, 234, 236, 237),
        ),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 1),
            blurRadius: 4,
            spreadRadius: 0,
            color: Colors.black.withOpacity(0.1),
          ),
        ],
      ),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(10.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 5.h),
                Text(
                  widget.service.name,
                  style: GoogleFonts.poppins(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF19A4C6),
                  ),
                ),
                SizedBox(height: 10.h),
                _buildDetailRow("Duration:", "${widget.service.durationMinutes.toInt()} minutes"),
                _buildDetailRow("Base Price:", "\$${widget.service.basePrice}"),
                _buildDetailRow("Bathroom Rate:", "\$${widget.service.bathroomRate}"),
                _buildDetailRow("Room Rate:", "\$${widget.service.roomRate}"),
                _buildDetailRow("Sqft Rate:", "\$${widget.service.squareFootPrice}"),
              ],
            ),
          ),

          /// Vertical 3-dot menu fixed top-right
          Positioned(
            top: 5.h,
            right: 5.w,
            child: PopupMenuButton<String>(
              icon: Icon(Icons.more_vert, color: const Color(0xFF19A4C6)),
              onSelected: (String value) {
                if (value == 'edit') {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(20.r)),
                    ),
                    builder: (context) => EditServiceBottomSheet(
                      service: widget.service,
                      //      notify: notify,
                    ),);
                }
              },
              itemBuilder: (BuildContext context) => [
                PopupMenuItem<String>(
                  value: 'edit',
                  child: Text('Edit'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h),
      child: Row(
        children: [
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(width: 10.w),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 13.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
