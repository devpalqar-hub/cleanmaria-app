import 'package:cleanby_maria/Screens/admin_cleabby_maria/Dashboard/ClientScreen/CleaningHistory.dart';
import 'package:cleanby_maria/Screens/admin_cleabby_maria/Dashboard/ClientScreen/Service/BookingController.dart';
import 'package:cleanby_maria/Src/appText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart' show Get;

class BookingDetailsScreen extends StatefulWidget {
  final String bookingId;

  const BookingDetailsScreen({required this.bookingId, Key? key}) : super(key: key);

  @override
  State<BookingDetailsScreen> createState() => _BookingDetailsScreenState();
}

class _BookingDetailsScreenState extends State<BookingDetailsScreen> {
  final BookingsController controller = Get.put(BookingsController());

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      controller.fetchBookingDetails(widget.bookingId);
    });
  }

  Widget _infoText({required String title, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        appText.primaryText(
          text: title,
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
        appText.primaryText(
          text: value,
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          color: const Color(0xFF757D7F),
        ),
        SizedBox(height: 10.h),
      ],
    );
  }

  void _showCancelDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Cancel Subscription"),
        content: const Text("Are you sure you want to cancel this subscription?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("No", style: TextStyle(color: Colors.black)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Subscription Cancelled")),
              );
            },
            child: const Text("Yes", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_outlined, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: appText.primaryText(
          text: "Booking Details",
          fontSize: 18.sp,
          fontWeight: FontWeight.w700,
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.errorMessage.value.isNotEmpty) {
          return Center(child: Text(controller.errorMessage.value));
        }
        if (controller.bookingDetail.value == null) {
          return const Center(child: Text('No booking details found'));
        }

        final detail = controller.bookingDetail.value!;
        final customer = detail.data?.customer;
        final service = detail.data?.service;
        final booking = detail.data;

        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 15.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: _infoText(
                      title: "Name",
                      value: customer?.name ?? 'N/A',
                    ),
                  ),
                  Image.asset(
                    'assets/call.png',
                    width: 30.w,
                    height: 30.h,
                  ),
                ],
              ),
              _infoText(
                title: "Contact Number",
                value: customer?.phone ?? 'N/A',
              ),
              _infoText(
                title: "Email",
                value: customer?.email ?? 'N/A',
              ),
              _infoText(
                title: "Address",
                value: booking?.bookingAddress?.specialInstructions ?? 'N/A',
              ),
              _infoText(
                title: "Booking Date",
                value: booking?.createdAt ?? 'N/A',
              ),
              Row(
                children: [
                  Expanded(
                    child: _infoText(
                      title: "Service Cost",
                      value: "Estimated Cost: ${booking?.price ?? 'N/A'}",
                    ),
                  ),
                  Container(
                    width: 65.w,
                    height: 19.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: const Color(0xFF19A4C6),
                    ),
                    child: Center(
                      child: appText.primaryText(
                        text: "NOT PAID",
                        fontSize: 8.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              _infoText(
                title: "Total Sq",
                value: "Estimated sqft: ${booking?.areaSize ?? 'N/A'}",
              ),
              _infoText(
                title: "Type of cleaning",
                value: booking?.type ?? 'N/A',
              ),
              _infoText(
                title: "Type of property",
                value: booking?.propertyType ?? 'N/A',
              ),
              Row(
                children: [
                  appText.primaryText(
                    text: "Rooms: ${service?.roomRate ?? 'N/A'}",
                  ),
                  SizedBox(width: 69.w),
                  appText.primaryText(
                    text: "Bathrooms: ${service?.bathroomRate ?? 'N/A'}",
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              Row(
                children: [
                  Expanded(
                    child: _infoText(title: "Service plan", value: "Plan name"),
                  ),
                  Container(
                    width: 65.w,
                    height: 19.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: const Color(0xFF1C9F0B),
                    ),
                    child: Center(
                      child: appText.primaryText(
                        text: "ECO SERVICE",
                        fontSize: 8.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              appText.primaryText(
                text: "Cleaning items given",
                color: const Color(0xFF1C9F0B),
                fontSize: 12.sp,
              ),
              SizedBox(height: 40.h),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CleaningHistory()),
                  );
                },
                child: Center(
                  child: appText.primaryText(
                    text: "View Cleaning History",
                    color: Colors.black,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              GestureDetector(
                onTap: () => _showCancelDialog(context),
                child: Center(
                  child: appText.primaryText(
                    text: "Cancelation of Subscription",
                    color: Colors.red,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
