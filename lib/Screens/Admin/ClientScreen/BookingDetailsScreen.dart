// import 'dart:convert';

// import 'package:cleanby_maria/Screens/Admin/BookingScreen/Controller/EstimateController.dart';
// import 'package:cleanby_maria/Screens/Admin/ClientScreen/CleaningHistory.dart';
// import 'package:cleanby_maria/Screens/Admin/ClientScreen/Models/BookingDetailModel.dart';
// import 'package:cleanby_maria/Screens/Admin/ClientScreen/Service/BookingController.dart';
// import 'package:cleanby_maria/Screens/Admin/ClientScreen/Views/StatusChangeBottomSheet.dart';
// import 'package:cleanby_maria/Screens/Admin/HistoryScreen/Controller/HistoryController.dart';
// import 'package:cleanby_maria/Screens/Admin/HistoryScreen/Models/HistoryModel.dart';
// import 'package:cleanby_maria/Src/appButton.dart';
// import 'package:cleanby_maria/Src/appText.dart';
// import 'package:cleanby_maria/Src/utils.dart';
// import 'package:cleanby_maria/main.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:intl/intl.dart';
// import 'package:loading_animation_widget/loading_animation_widget.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:url_launcher/url_launcher.dart';

// class BookingDetailsScreen extends StatefulWidget {
//   final String bookingId;
//   final String? staff;
//   final bool isCanceld;
//   String? status;
//   final String? scheduleId;
//   final String? date;
//   final String? subscriptionId;
//   var pCtrl;
//   bool isStaff;

//   BookingDetailsScreen(
//       {required this.bookingId,
//         this.date,
//         this.staff,
//         this.status,
//         this.pCtrl,
//         this.scheduleId,
//         this.subscriptionId,
//         this.isStaff = false,
//         this.isCanceld = false,
//         super.key});

//   @override
//   State<BookingDetailsScreen> createState() => _BookingDetailsScreenState();
// }

// class _BookingDetailsScreenState extends State<BookingDetailsScreen> {
//   final BookingsController controller = Get.put(BookingsController());
//   final HistoryController hiscontroller = Get.put(HistoryController());

//   DateTime? selectedRescheduleDate;
//   List<String> availableSlots = [];
//   String? selectedSlot;
//   int? totalDuration;

//   @override
//   void initState() {
//     super.initState();
//     Future.delayed(Duration.zero, () {
//       controller.fetchBookingDetails(widget.bookingId);
//       hiscontroller.fetchSchedules();
//     });
//   }

//   Widget _editableField({
//     required String title,
//     required String value,
//     required VoidCallback onEdit,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Expanded(
//               child: appText.primaryText(
//                 text: title,
//                 fontSize: 12.sp,
//                 fontWeight: FontWeight.w600,
//                 color: Colors.black,
//               ),
//             ),
//             IconButton(
//               icon: Icon(Icons.edit, size: 16.sp, color: Colors.red),
//               onPressed: onEdit,
//               padding: EdgeInsets.zero,
//               constraints: const BoxConstraints(),
//             ),
//           ],
//         ),
//         appText.primaryText(
//           text: value,
//           fontSize: 14.sp,
//           fontWeight: FontWeight.w400,
//           color: Colors.black87,
//         ),
//         SizedBox(height: 10.h),
//       ],
//     );
//   }

//   void showEditDialog({
//     required BuildContext context,
//     required String fieldName,
//     required String initialValue,
//     required Function(String newValue) onSave,
//   }) {
//     TextEditingController controllerText =
//     TextEditingController(text: initialValue);
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text("Edit $fieldName"),
//         content: TextField(
//           controller: controllerText,
//           decoration: InputDecoration(hintText: "Enter new $fieldName"),
//         ),
//         actions: [
//           TextButton(
//               onPressed: () => Navigator.pop(context), child: Text("Cancel")),
//           TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//                 onSave(controllerText.text.trim());
//               },
//               child: Text("Save")),
//         ],
//       ),
//     );
//   }

//   Widget _infoText({required String title, required String value}) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         appText.primaryText(
//           text: title,
//           fontSize: 12.sp,
//           fontWeight: FontWeight.w600,
//           color: Colors.black,
//         ),
//         SpacerH(12.h),
//         appText.primaryText(
//           text: value,
//           fontSize: 14.sp,
//           fontWeight: FontWeight.w400,
//           color: Colors.black87,
//         ),
//         SizedBox(height: 10.h),
//       ],
//     );
//   }
//   Widget _rowItem(String label, String value) {
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 10.h),
//       child: Row(
//         children: [
//           Expanded(
//             child: Text(
//               label,
//               style: TextStyle(
//                 fontSize: 13.sp,
//                 color: Colors.grey,
//               ),
//             ),
//           ),
//           Expanded(
//             child: Text(
//               value,
//               textAlign: TextAlign.right,
//               style: TextStyle(
//                 fontSize: 14.sp,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }


//   String _getCurrentStatus(BookingDetailModel booking) {
//     if (widget.scheduleId != null) {
//       final historyMatch = hiscontroller.history.firstWhere(
//             (h) => h.id == widget.scheduleId,
//         orElse: () => HistoryModel(status: booking.status),
//       );
//       return historyMatch.status ?? booking.status ?? 'N/A';
//     } else {
//       return booking.status ?? 'N/A';
//     }
//   }

//   void _showCancelDialog(BuildContext context) {
//     final booking = controller.bookingDetail;

//     if (booking?.status == "cancelled" || booking?.status == "completed") {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("This booking cannot be cancelled.")),
//       );
//       return;
//     }

//     bool isLoading = false;

//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text("Cancel Booking"),
//         content: const Text("Are you sure you want to cancel this booking?"),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text("No", style: TextStyle(color: Colors.blue)),
//           ),
//           StatefulBuilder(builder: (context, state) {
//             return TextButton(
//               onPressed: () async {
//                 final bookingId = widget.bookingId;
//                 final type = booking?.type ?? 'subscription';
//                 final currentStatus = 'active';

//                 state(() {
//                   isLoading = true;
//                 });

//                 bool result = await controller.cancelBooking(
//                   bookingId: bookingId,
//                   type: type,
//                 );

//                 state(() {
//                   isLoading = false;
//                 });

//                 if (result) {
//                   Navigator.pop(context);
//                   Get.back();

//                   ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(
//                         content: Text("Booking cancelled successfully")),
//                   );
//                 } else {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(content: Text("Failed to cancel booking")),
//                   );
//                 }
//               },
//               child: (isLoading)
//                   ? LoadingAnimationWidget.staggeredDotsWave(
//                   color: Colors.blue, size: 24.sp)
//                   : const Text("Yes", style: TextStyle(color: Colors.blue)),
//             );
//           }),
//         ],
//       ),
//     );
//   }

//   /// ------------------------ DEBUGGED NEXT SCHEDULE FUNCTION ------------------------
//   DateTime getNextScheduleDate(
//       BookingDetailModel booking, {
//         DateTime? fromDate,
//       }) {
//     final baseDate = fromDate ?? DateTime.now();
//     print("=== getNextScheduleDate called ===");
//     print("Booking ID: ${booking.id}");
//     print("Booking type: ${booking.type}");
//     print("Recurring type: ${booking.reccuingType}");
//     print("From date (baseDate): $baseDate");

//     // ---------------- ONE-TIME ----------------
//     if (booking.type == "one_time" && booking.date != null) {
//       final bookingDate = DateTime.parse(booking.date!).toLocal();
//       print("One-time booking date: $bookingDate");
//       return bookingDate.isAfter(baseDate)
//           ? bookingDate
//           : bookingDate.add(const Duration(days: 1));
//     }

//     // ---------------- RECURRING ----------------
//     if (booking.type == "recurring" &&
//         booking.date != null &&
//         booking.monthSchedules != null &&
//         booking.monthSchedules!.isNotEmpty) {
//       List<DateTime> possibleDates = [];

//       for (var sched in booking.monthSchedules!) {
//         int weekday = sched.dayOfWeek!;
//         var parts = sched.time!.split(":");
//         int hour = int.parse(parts[0]);
//         int minute = int.parse(parts[1]);

//         DateTime startDate = DateTime.parse(booking.date!).toLocal();

//         int daysToAdd = (weekday - startDate.weekday + 7) % 7;
//         DateTime firstSchedule = DateTime(
//           startDate.year,
//           startDate.month,
//           startDate.day,
//           hour,
//           minute,
//         ).add(Duration(days: daysToAdd));

//         int stepDays = 7;
//         if (booking.reccuingType != null) {
//           final normalized = booking.reccuingType!
//               .toLowerCase()
//               .replaceAll(RegExp(r'[\s-]'), '');
//           if (normalized == "biweekly") {
//             stepDays = 14;
//           }
//         }

//         // Move forward until after baseDate
//         while (!firstSchedule.isAfter(baseDate)) {
//           firstSchedule = firstSchedule.add(Duration(days: stepDays));
//         }

//         possibleDates.add(firstSchedule);
//       }

//       possibleDates.sort((a, b) => a.compareTo(b));
//       print("Final next schedule: ${possibleDates.first}");
//       return possibleDates.first;
//     }

//     // ---------------- FALLBACK ----------------
//     print("Fallback: returning baseDate + 1 day");
//     return baseDate.add(const Duration(days: 1));
//   }

//   Future<void> fetchSlotsForDate(DateTime date) async {
//     final booking = controller.bookingDetail!;
//     if (totalDuration == null) {
//       // Calculate estimate first
//       final estimateData = await AppController().calculateEstimate(
//         serviceId: booking.service?.id ?? "",
//         noOfRooms: booking.noOfRooms ?? 0,
//         noOfBathrooms: booking.noOfBathRooms ?? 0,
//         squareFeet: booking.areaSize ?? 0,
//         isEcoCleaning: booking.isEco ?? false,
//         materialsProvidedByClient: booking.materialProvided ?? false,
//       );
//       totalDuration = estimateData['totalDuration'];
//     }

//     final slots = await AppController().fetchTimeSlots(
//       date: date,
//       totalDuration: totalDuration!,
//       recurringTypeId: booking.reccuingType ?? "one_time",
//     );

//     setState(() {
//       availableSlots = slots.map((e) => e['time'].toString()).toList();
//       selectedSlot = null;
//     });
//   }

//   void _showRescheduleSheet(BuildContext context, String bookingId) {
//     final booking = controller.bookingDetail!;
//     final nextSchedule = getNextScheduleDate(booking);

//     int daysRange = 7;
//     if (booking.type == "recurring" && booking.reccuingType == "biweekly") {
//       daysRange = 14;
//     }

//     selectedRescheduleDate = nextSchedule;

//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.vertical(top: Radius.circular(20.r))),
//       builder: (context) {
//         return StatefulBuilder(
//           builder: (context, setStateModal) {
//             return Padding(
//               padding: EdgeInsets.all(20.w),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Text(
//                     "Reschedule Booking",
//                     style:
//                     TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
//                   ),
//                   SizedBox(height: 25.h),
//                   RichText(
//                     text: TextSpan(
//                       children: [
//                         TextSpan(
//                           text: "Next Schedule Date: ", // the label
//                           style: TextStyle(
//                             fontSize: 15.sp,
//                             fontWeight: FontWeight.w600, // bold
//                             color: Colors.black87,
//                           ),
//                         ),
//                         TextSpan(
//                           text: DateFormat("EEE, MMM d, yyyy | hh:mm a")
//                               .format(nextSchedule), // the date
//                           style: TextStyle(
//                             fontSize: 14.sp,
//                             fontWeight: FontWeight.w500, // normal
//                             color: Colors.black87,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),

//                   SizedBox(height: 30.h),

//                   // Dates Grid
//                   GridView.builder(
//                     shrinkWrap: true,
//                     physics: NeverScrollableScrollPhysics(),
//                     itemCount: daysRange,
//                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 7,
//                       mainAxisSpacing: 5,
//                       crossAxisSpacing: 5,
//                       childAspectRatio: 1,
//                     ),
//                     itemBuilder: (context, index) {
//                       DateTime date = nextSchedule.add(Duration(days: index));
//                       bool isSelected = selectedRescheduleDate != null &&
//                           selectedRescheduleDate!.day == date.day &&
//                           selectedRescheduleDate!.month == date.month &&
//                           selectedRescheduleDate!.year == date.year;
//                       return GestureDetector(
//                         onTap: () async {
//                           setStateModal(() {
//                             selectedRescheduleDate = date;
//                             selectedSlot = null;
//                             availableSlots = [];
//                           });
//                           await fetchSlotsForDate(date);
//                           setStateModal(() {});
//                         },
//                         child: Container(
//                           alignment: Alignment.center,
//                           decoration: BoxDecoration(
//                               color: isSelected
//                                   ? Color(0xff19A4C6)
//                                   : Colors.grey[200],
//                               borderRadius: BorderRadius.circular(8.r)),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Text(
//                                 DateFormat("E").format(date),
//                                 style: TextStyle(
//                                     fontSize: 10.sp,
//                                     color: isSelected
//                                         ? Colors.white
//                                         : Colors.black),
//                               ),
//                               Text(
//                                 DateFormat("d").format(date),
//                                 style: TextStyle(
//                                     fontWeight: FontWeight.w600,
//                                     color: isSelected
//                                         ? Colors.white
//                                         : Colors.black),
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                   ),

//                   // Time Slots
//                   if (availableSlots.isNotEmpty) ...[
//                     SizedBox(height: 10.h),
//                     Align(
//                       alignment: Alignment.centerLeft,
//                       child: Text(
//                         "Available Time Slots",
//                         style: TextStyle(
//                             fontSize: 14.sp, fontWeight: FontWeight.w600),
//                       ),
//                     ),
//                     SizedBox(height: 5.h),
//                     Wrap(
//                       spacing: 5.w,
//                       runSpacing: 5.h,
//                       children: availableSlots.map((slot) {
//                         bool isSelected = selectedSlot == slot;
//                         return GestureDetector(
//                           onTap: () {
//                             setStateModal(() {
//                               selectedSlot = slot;
//                             });
//                           },
//                           child: Container(
//                             padding: EdgeInsets.symmetric(
//                                 horizontal: 10.w, vertical: 6.h),
//                             decoration: BoxDecoration(
//                                 color: isSelected
//                                     ? Color(0xff19A4C6)
//                                     : Colors.grey[200],
//                                 borderRadius: BorderRadius.circular(8.r)),
//                             child: Text(
//                               slot,
//                               style: TextStyle(
//                                   color:
//                                   isSelected ? Colors.white : Colors.black,
//                                   fontSize: 12.sp),
//                             ),
//                           ),
//                         );
//                       }).toList(),
//                     ),
//                   ],

//                   SizedBox(height: 25.h),
//                   ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Color(0xff19A4C6),
//                       minimumSize: Size(double.infinity, 50.h),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12.r),
//                       ),
//                     ),
//                     onPressed: (selectedRescheduleDate != null && selectedSlot != null)
//                         ? () async {
//                       String? msg = await hiscontroller.rescheduleBooking(
//                         bookingId: booking.id!,
//                         newDate: selectedRescheduleDate!,
//                         time: selectedSlot!,
//                       );

//                       if (msg == null) {
//                         // SUCCESS
//                         Fluttertoast.showToast(
//                           msg: "Booking rescheduled successfully",
//                         );

//                         await controller.fetchBookingDetails(booking.id!);
//                         await hiscontroller.fetchSchedules(clear: true);
//                         Navigator.pop(context);
//                         setState(() {});
//                       } else {
//                         // FAILURE → Show: "Failed: <backend message>"
//                         Fluttertoast.showToast(
//                           msg: "Failed: $msg",
//                         );
//                       }
//                     }
//                         : null,
//                     child: Text(
//                       "Save",
//                       style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 14.sp,
//                           fontWeight: FontWeight.w600),
//                     ),
//                   ),

//                   SizedBox(height: 10.h),
//                 ],
//               ),
//             );
//           },
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         bottomNavigationBar: BottomNavigationBar(
//           type: BottomNavigationBarType.fixed,
//           currentIndex: 1, // bookings selected
//           selectedItemColor: const Color(0xff19A4C6),
//           unselectedItemColor: Colors.grey,
//           onTap: (index) {
//             switch (index) {
//               case 0:
//                 Get.offAllNamed("/home");
//                 break;

//               case 1:
//               // already here
//                 break;

//               case 2:
//                 Get.to(() => CleaningHistory(bookingId: widget.bookingId));
//                 break;

//               case 3:
//                 Get.offAllNamed("/selfService");
//                 break;
//             }
//           },
//           items: const [
//             BottomNavigationBarItem(
//               icon: Icon(Icons.home),
//               label: "Home",
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.calendar_today),
//               label: "Bookings",
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.history),
//               label: "History",
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.build),
//               label: "Self-Service",
//             ),
//           ],
//         ),


//         appBar: AppBar(
//           backgroundColor: Colors.white,
//           elevation: 0,
//           leading: IconButton(
//             icon: const Icon(Icons.arrow_back_ios_new_outlined,
//                 color: Colors.black),
//             onPressed: () => Navigator.pop(context),
//           ),
//           title: appText.primaryText(
//             text: "Booking Details",
//             fontSize: 18.sp,
//             fontWeight: FontWeight.w600,
//           ),
//         ),

//         body: GetBuilder<BookingsController>(builder: (_) {
//           if (controller.isLoading) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           if (controller.errorMessage.isNotEmpty) {
//             return Center(child: Text(controller.errorMessage));
//           }

//           if (controller.bookingDetail == null) {
//             return const Center(child: Text('No booking details found'));
//           }

//           final detail = controller.bookingDetail!;
//           final customer = detail.customer;
//           final booking = detail;
//           final service = detail.service;

//           return SingleChildScrollView(
//             padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),

//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [

//                 // ================= HEADER =================
//                 Row(
//                   children: [
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           appText.primaryText(
//                             text: customer?.name ?? "N/A",
//                             fontSize: 20.sp,
//                             fontWeight: FontWeight.w700,
//                           ),
//                           SizedBox(height: 4.h),
//                           appText.primaryText(
//                             text: customer?.email ?? "",
//                             fontSize: 13.sp,
//                             color: Colors.grey,
//                           ),
//                         ],
//                       ),
//                     ),

//                     if (customer?.phone != null &&
//                         customer!.phone!.isNotEmpty)
//                       InkWell(
//                         onTap: () {
//                           launchUrl(Uri.parse("tel:${customer.phone!}"));
//                         },
//                         child: CircleAvatar(
//                           radius: 22.r,
//                           backgroundColor: const Color(0xffE9F5FB),
//                           child: const Icon(Icons.call,
//                               color: Color(0xff19A4C6)),
//                         ),
//                       ),
//                   ],
//                 ),

//                 SizedBox(height: 25.h),

//                 // ================= DETAILS =================
//                 _rowItem("Phone", customer?.phone ?? "N/A"),

//                 _rowItem(
//                   "Address",
//                   "${booking.bookingAddress?.address?.line1 ?? ''}, ${booking.bookingAddress?.address?.city ?? ''}",
//                 ),

//                 _rowItem(
//                   "Time",
//                   widget.date ??
//                       DateFormat("EEE, MMM d | hh:mm a")
//                           .format(DateTime.parse(booking.createdAt!).toLocal()),
//                 ),

//                 Divider(height: 30.h),

//                 _rowItem("Status", booking.status ?? "N/A"),

//                 _rowItem("Est. Cost", "₹${booking.price ?? '0'}"),

//                 _rowItem("Est. Sqft", "${booking.areaSize ?? '0'}"),

//                 _rowItem("Payment", booking.paymentMethod ?? "N/A"),

//                 _rowItem("Type", booking.reccuingType ?? "One Time"),

//                 if (widget.date != null)
//                   _rowItem("Cleaned By", widget.staff ?? "N/A"),

//                 SizedBox(height: 20.h),

//                 _rowItem("Service Plan", service?.name ?? ""),

//                 if (detail.isEco ?? false)
//                   Padding(
//                     padding: EdgeInsets.only(top: 8.h),
//                     child: appText.primaryText(
//                       text: "ECO SERVICE",
//                       color: const Color(0xFF1C9F0B),
//                       fontSize: 12.sp,
//                     ),
//                   ),

//                 SizedBox(height: 40.h),

//                 // ================= RESCHEDULE =================
//                 GestureDetector(
//                   onTap: () => _showRescheduleSheet(context, booking.id!),
//                   child: Container(
//                     width: double.infinity,
//                     height: 50.h,
//                     alignment: Alignment.center,
//                     decoration: BoxDecoration(
//                       color: const Color(0xff19A4C6),
//                       borderRadius: BorderRadius.circular(12.r),
//                     ),
//                     child: Text(
//                       "Reschedule",
//                       style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 14.sp,
//                           fontWeight: FontWeight.w600),
//                     ),
//                   ),
//                 ),

//                 SizedBox(height: 25.h),

//                 // ================= CHANGE STATUS =================
//                 GestureDetector(
//                   onTap: () {
//                     Get.bottomSheet(
//                       BookingStatusBottomSheet(
//                         isStaff: widget.isStaff,
//                         sheduleID: booking.id!, // ✅ use booking id directly
//                         currentStatus: booking.status ?? "",
//                         onStatusChanged: (value) {
//                           widget.status = value;
//                           setState(() {});
//                         },
//                       ),
//                       isScrollControlled: true,
//                     );
//                   },
//                   child: Container(
//                     width: double.infinity,
//                     height: 55.h,
//                     alignment: Alignment.center,
//                     decoration: BoxDecoration(
//                       color: const Color(0xff0B1320),
//                       borderRadius: BorderRadius.circular(12.r),
//                     ),
//                     child: Text(
//                       "Change Status",
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 15.sp,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 30.h),
//               ],
//             ),
//           );
//         }),
//       ),
//     );
//   }
// }