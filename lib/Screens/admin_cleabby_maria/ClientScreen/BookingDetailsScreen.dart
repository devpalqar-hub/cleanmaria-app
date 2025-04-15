import 'package:cleanby_maria/Screens/admin_cleabby_maria/ClientScreen/CleaningHistory.dart';
import 'package:cleanby_maria/Screens/admin_cleabby_maria/ClientScreen/Models/BookingDetailModel.dart';
import 'package:cleanby_maria/Screens/admin_cleabby_maria/ClientScreen/Service/BookingController.dart';
import 'package:cleanby_maria/Screens/admin_cleabby_maria/ClientScreen/Views/StatusChangeBottomSheet.dart';
import 'package:cleanby_maria/Src/appButton.dart';
import 'package:cleanby_maria/Src/appText.dart';
import 'package:cleanby_maria/Src/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart' show Get;
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class BookingDetailsScreen extends StatefulWidget {
  final String bookingId;
  final String? staff;
  final String? status;
  final String? scheduleId;
  final String? date;
  bool isStaff;
  BookingDetailsScreen(
      {required this.bookingId,
      this.date,
      this.staff,
      this.status,
      this.scheduleId,
      this.isStaff = false,
      super.key});

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
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
        SpacerH(4.h),
        appText.primaryText(
          text: value,
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          color: Colors.black87,
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
        content:
            const Text("Are you sure you want to cancel this subscription?"),
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
          icon: const Icon(Icons.arrow_back_ios_new_outlined,
              color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: appText.primaryText(
          text: "Booking Details",
          fontSize: 18.sp,
          fontWeight: FontWeight.w700,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
        child: GetBuilder<BookingsController>(builder: (_) {
          if (controller.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (controller.errorMessage.isNotEmpty) {
            return Center(child: Text(controller.errorMessage));
          }
          if (controller.bookingDetail == null) {
            return const Center(child: Text('No booking details found'));
          }

          final detail = controller.bookingDetail!;
          final customer = detail.customer;
          final service = detail.service;
          final booking = detail;
          return Column(
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
                  InkWell(
                    onTap: () {
                      launchUrl(Uri.parse("tel:${detail.customer!.phone!}"));
                    },
                    child: Image.asset(
                      'assets/call.png',
                      width: 30.w,
                      height: 30.h,
                    ),
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
                value:
                    "${booking.bookingAddress!.address!.line1!},  ${booking.bookingAddress!.address!.line2 ?? "--:--"} \n${booking.bookingAddress!.address!.city ?? ""} ${booking.bookingAddress!.address!.zip ?? ""} ",
              ),
              if (widget.date == null)
                _infoText(
                  title: "Booking Date",
                  value: DateFormat("dd MMM yyyy | hh:mm a")
                          .format(DateTime.parse(booking!.createdAt!)) ??
                      'N/A',
                ),
              if (widget.date != null)
                _infoText(
                  title: "Cleaning Shedule",
                  value: widget.date ?? 'N/A',
                ),
              if (widget.date == null)
                _infoText(
                  title: "Shedules",
                  value: (detail.type == "subscription")
                      ? booking.monthSchedules!
                          .map((value) =>
                              "Week ${value.weekOfMonth} - ${controller.weektoDay(value.dayOfWeek!)}, ${value.time!} ")
                          .join("\n")
                      : controller.WeekDatetoDate(
                          createdDate: DateTime.parse(booking.createdAt!),
                          weekOfMonth:
                              booking.monthSchedules!.first.weekOfMonth!,
                          dayOfWeek: booking.monthSchedules!.first.dayOfWeek!),
                ),
              Row(
                children: [
                  Expanded(
                    child: _infoText(
                      title: "Service Cost",
                      value: "Estimated Cost: ${booking.price ?? 'N/A'}",
                    ),
                  ),
                  if (booking.transactions!.isEmpty ||
                      controller.checkTransation(booking.transactions!.first))
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
                value: "Estimated sqft: ${booking.areaSize ?? 'N/A'}",
              ),
              _infoText(
                title: "Type of cleaning",
                value: booking.type ?? 'N/A',
              ),
              if (widget.date != null)
                _infoText(
                  title: "Cleaned By",
                  value: widget.staff ?? 'N/A',
                ),
              if (widget.date != null)
                _infoText(
                  title: "Status",
                  value: widget.status ?? 'N/A',
                ),
              _infoText(
                title: "Type of property",
                value: booking.propertyType ?? 'N/A',
              ),
              Row(
                children: [
                  appText.primaryText(
                    text: "Rooms: ${detail.noOfRooms ?? 'N/A'}",
                  ),
                  SizedBox(width: 69.w),
                  appText.primaryText(
                    text: "Bathrooms: ${detail.noOfBathRooms ?? 'N/A'}",
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              Row(
                children: [
                  Expanded(
                    child: _infoText(
                        title: "Service plan", value: service!.name ?? ""),
                  ),
                  if (detail!.isEco != null && detail!.isEco!)
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
              SizedBox(height: 25.h),
              if (widget.scheduleId != null) SizedBox(height: 8.h),
              if (widget.scheduleId != null)
                InkWell(
                  onTap: () {
                    Get.bottomSheet(BookingStatusBottomSheet(
                        isStaff: widget.isStaff,
                        sheduleID: widget.scheduleId!,
                        currentStatus: booking.status!,
                        onStatusChanged: (value) {}));
                  },
                  child: Container(
                    width: 360.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.r),
                        color: Color(0xff19A4C6)),
                    height: 50,
                    alignment: Alignment.center,
                    child: Text(
                      "Change Status",
                      style: TextStyle(
                          fontSize: 14.w,
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              SizedBox(height: 8.h),
              if (detail!.materialProvided != null && detail!.materialProvided!)
                appText.primaryText(
                  text: "Cleaning items given",
                  color: const Color(0xFF1C9F0B),
                  fontSize: 12.sp,
                ),
              SizedBox(height: 40.h),
              if (widget.date == null)
                GestureDetector(
                  onTap: () {
                    Get.to(
                        () => CleaningHistory(
                              bookingId: booking.id!,
                            ),
                        transition: Transition.rightToLeft);
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
              if (widget.date == null)
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
          );
        }),
      ),
    );
  }
}
