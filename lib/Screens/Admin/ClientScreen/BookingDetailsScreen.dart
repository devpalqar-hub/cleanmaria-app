import 'package:cleanby_maria/Screens/Admin/ClientScreen/CleaningHistory.dart';
import 'package:cleanby_maria/Screens/Admin/ClientScreen/Models/BookingDetailModel.dart';
import 'package:cleanby_maria/Screens/Admin/ClientScreen/Service/BookingController.dart';
import 'package:cleanby_maria/Screens/Admin/ClientScreen/Views/StatusChangeBottomSheet.dart';
import 'package:cleanby_maria/Src/appButton.dart';
import 'package:cleanby_maria/Src/appText.dart';
import 'package:cleanby_maria/Src/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart' show Get;
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class BookingDetailsScreen extends StatefulWidget {
  final String bookingId;
  final String? staff;
  final bool isCanceld;
  String? status;
  final String? scheduleId;
  final String? date;
  final String? subscriptionId;
  var pCtrl;

  bool isStaff;
  BookingDetailsScreen(
      {required this.bookingId,
      this.date,
      this.staff,
      this.status,
      this.pCtrl,
      this.scheduleId,
      this.subscriptionId,
      this.isStaff = false,
      this.isCanceld = false,
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

  bool isLoading = false;


 Widget _editableField({
  required String title,
  required String value,
  required VoidCallback onEdit,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: appText.primaryText(
              text: title,
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black,
             
            ),
          ),
          IconButton(
            icon: Icon(Icons.edit, size: 16.sp, color: Colors.red),
            onPressed: onEdit,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ],
      ),
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


void showEditDialog({
  required BuildContext context,
  required String fieldName,
  required String initialValue,
  required Function(String newValue) onSave,
}) {
  TextEditingController controller = TextEditingController(text: initialValue);
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text("Edit $fieldName"),
      content: TextField(
        controller: controller,
        decoration: InputDecoration(hintText: "Enter new $fieldName"),
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context), child: Text("Cancel")),
        TextButton(
            onPressed: () {
              Navigator.pop(context);
              onSave(controller.text.trim());
            },
            child: Text("Save")),
      ],
    ),
  );
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
       SpacerH(12.h),
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
    final booking = controller.bookingDetail;

    if (booking?.status == "cancelled" || booking?.status == "completed") {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("This booking cannot be cancelled.")),
      );
      return;
    }

    bool isLoading = false;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Cancel Booking"),
        content: const Text("Are you sure you want to cancel this booking?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("No", style: TextStyle(color: Colors.blue)),
          ),
          StatefulBuilder(builder: (context, state) {
            return TextButton(
              onPressed: () async {
                final bookingId = widget.bookingId;
                final type = booking?.type ?? 'subscription';
                final currentStatus = 'active';

                state(() {
                  isLoading = true;
                });

                bool result = await controller.cancelBooking(
                  bookingId: bookingId,
                  type: type,
                );

                state(() {
                  isLoading = false;
                });

                if (result) {
                  Navigator.pop(context);
                  Get.back();

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text("Booking cancelled successfully")),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Failed to cancel booking")),
                  );
                }
              },
              child: (isLoading)
                  ? LoadingAnimationWidget.staggeredDotsWave(
                      color: Colors.blue, size: 24.sp)
                  : const Text("Yes", style: TextStyle(color: Colors.blue)),
            );
          }),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: (widget.scheduleId == null)
          ? null
          : InkWell(
              onTap: () {
                Get.bottomSheet(BookingStatusBottomSheet(
                    isStaff: widget.isStaff,
                    sheduleID: widget.scheduleId!,
                    currentStatus: widget.status!,
                    onStatusChanged: (value) {
                      //  booking.status = value;

                      if (widget.status != null) widget.status = value;
                      setState(() {});
                      if (widget.pCtrl != null) widget.pCtrl.reload();
                    }));
              },
              child: Container(
                width: 320.w,
                margin: EdgeInsets.only(bottom: 20, left: 20, right: 20),
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
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_outlined,
              color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: appText.primaryText(
          text: "Booking Details",
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: GetBuilder<BookingsController>(builder: (_) {
        return SingleChildScrollView(
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
    // Name & Call Button Row
    Row(
      children: [
        Expanded(
          child: _infoText(
            title: "Name",
            value: customer?.name ?? 'N/A',
          ),
        ),
        if (customer?.phone != null && customer!.phone!.isNotEmpty)
          InkWell(
            onTap: () {
              launchUrl(Uri.parse("tel:${customer.phone!}"));
            },
            child: Image.asset(
              'assets/call2.png',
              width: 30.w,
              height: 30.h,
            ),
          ),
      ],
    ),
    SizedBox(height: 10.h),
   _editableField(
  title: "Contact Number",
  value: customer?.phone ?? 'N/A',
  onEdit: () {
    showEditDialog(
      context: context,
      fieldName: "Contact Number",
      initialValue: customer?.phone ?? '',
      onSave: (newVal) async {
        final success = await controller.updateBookingDetails(
          booking.id!,
          {"customer.phone": newVal}, // Adjust this key based on backend structure
        );
        if (success) {
          Fluttertoast.showToast(msg: "Contact Number updated");
        }
      },
    );
  },
),
SizedBox(height: 10.h),

    SizedBox(height: 10.h),
    _infoText(title: "Email", value: customer?.email ?? 'N/A'),
    SizedBox(height: 10.h),
    _infoText(
      title: "Address",
      value:
          "${booking.bookingAddress?.address?.line1 ?? ''}, ${booking.bookingAddress?.address?.city ?? ''}",
    ),
    SizedBox(height: 10.h),
    _editableField(
      title: "Status",
      value: booking.status ?? 'N/A',
      onEdit: () {
        showEditDialog(
          context: context,
          fieldName: "Status",
          initialValue: booking.status ?? '',
          onSave: (newVal) async {
            final success = await controller.updateBookingDetails(
              booking.id!,
              {"status": newVal},
            );
            if (success) Fluttertoast.showToast(msg: "Status updated");
          },
        );
      },
    ),
    SizedBox(height: 10.h),
    _infoText(
      title: widget.date == null ? "Booking Date" : "Cleaning Schedule",
      value: widget.date ??
          DateFormat("dd MMM yyyy|hh:mm a")
              .format(DateTime.parse(booking.createdAt!).toLocal()),
    ),
    SizedBox(height: 10.h),
    if (widget.date == null)
      _infoText(
        title: "Schedules",
        value: (detail.type == "recurring")
            ? booking.monthSchedules!
                .map((e) =>
                    "${controller.weektoDay(e.dayOfWeek!)}, ${e.time!}")
                .join("\n")
            : DateFormat("dd-MM-yyyy|hh:mm:ss a")
                .format(DateTime.parse(booking.date!)),
      ),
    SizedBox(height: 10.h),
    Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: _editableField(
            title: "Service Cost",
            value: "Estimated Cost: ₹${booking.price ?? 'N/A'}",
            onEdit: () {
              showEditDialog(
                context: context,
                fieldName: "Service Cost",
                initialValue: booking.price?.toString() ?? '',
                onSave: (newVal) async {
                  final parsedPrice = double.tryParse(newVal);
                  if (parsedPrice == null) {
                    Fluttertoast.showToast(msg: "Invalid number");
                    return;
                  }
                  final success = await controller.updateBookingDetails(
                    booking.id!,
                    {"finalAmount": parsedPrice},
                  );
                  if (success) {
                    Fluttertoast.showToast(msg: "Price updated");
                  }
                },
              );
            },
          ),
        ),
        if (booking.transactions!.isEmpty ||
            controller.checkTransation(booking.transactions!.first))
          Padding(
            padding: EdgeInsets.only(top: 15.h),
            child: Container(
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
          ),
      ],
    ),
    SizedBox(height: 10.h),
    _infoText(
      title: "Total Sq",
      value: "Estimated sqft: ${booking.areaSize ?? 'N/A'}",
    ),
    SizedBox(height: 10.h),
    _infoText(
      title: "Type of cleaning",
      value: booking.reccuingType ?? "One Time",
    ),
    SizedBox(height: 10.h),
    if (widget.date != null)
      _infoText(title: "Cleaned By", value: widget.staff ?? 'N/A'),
    if (widget.date != null)
      _editableField(title: "Status", value: widget.status ?? 'N/A', onEdit: () {}),
    SizedBox(height: 10.h),
    _infoText(title: "Type of property", value: booking.propertyType ?? 'N/A'),
    SizedBox(height: 10.h),

    // Room & Bathroom aligned row
    Row(
      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        appText.primaryText(
          text: "Rooms: ${detail.noOfRooms ?? 'N/A'}",
          fontWeight: FontWeight.w500,
        ),SizedBox(width: 130.w,),
        appText.primaryText(
          text: "Bathrooms: ${detail.noOfBathRooms ?? 'N/A'}",
          fontWeight: FontWeight.w500,
        ),
      ],
    ),
    SizedBox(height: 20.h),

    // Service Plan and ECO Tag
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: _infoText(
            title: "Service plan",
            value: service!.name ?? "",
          ),
        ),
        if (detail.isEco ?? false)
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
    SizedBox(height: 10.h),

    if (detail.materialProvided ?? false)
      appText.primaryText(
        text: "Cleaning items given",
        color: const Color(0xFF1C9F0B),
        fontSize: 12.sp,
      ),

    if (widget.date == null) ...[
      SizedBox(height: 30.h),
      GestureDetector(
        onTap: () => Get.to(
          () => CleaningHistory(bookingId: booking.id!),
          transition: Transition.rightToLeft,
        ),
        child: Center(
          child: appText.primaryText(
            text: "View Cleaning History",
            color: Colors.black,
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    ],
    if (booking.status == "booked") ...[
      SizedBox(height: 10.h),
      GestureDetector(
        onTap: () => _showCancelDialog(context),
        child: Center(
          child: appText.primaryText(
            text: "Cancelation of Booking",
            color: Colors.red,
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    ],
    SizedBox(height: 20.h),
  ],
);
          }),);}),);}}