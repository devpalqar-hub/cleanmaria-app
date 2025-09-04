import 'package:cleanby_maria/Screens/Admin/ClientScreen/BookingDetailsScreen.dart';
import 'package:cleanby_maria/Screens/Admin/ClientScreen/Views/StatusCard.dart';
import 'package:cleanby_maria/Screens/Admin/HistoryScreen/Controller/HistoryController.dart';
import 'package:cleanby_maria/Screens/Admin/HistoryScreen/SchedulesScreen.dart';
import 'package:cleanby_maria/Src/appText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class BookingsaScreen extends StatefulWidget {
  const BookingsaScreen({super.key});

  @override
  _BookingsaScreenState createState() => _BookingsaScreenState();
}

class _BookingsaScreenState extends State<BookingsaScreen> {
  final HistoryController hisCtrl = Get.put(HistoryController());

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      if (args.value is PickerDateRange) {
        hisCtrl.startDate = args.value.startDate;
        hisCtrl.endDate = args.value.endDate;
      }
    });
  }

  void _showDatePicker() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Select Booking Dates",
                style: GoogleFonts.poppins(
                    fontSize: 16.sp, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 10.h),
              SfDateRangePicker(
                selectionMode: DateRangePickerSelectionMode.range,
                onSelectionChanged: _onSelectionChanged,
                startRangeSelectionColor: Colors.blue,
                endRangeSelectionColor: Colors.blue,
                rangeSelectionColor: Colors.blue.withOpacity(0.2),
                todayHighlightColor: Colors.blue,
                backgroundColor: Colors.white,
                initialSelectedRange: PickerDateRange(
                  hisCtrl.startDate ?? DateTime.now(),
                  hisCtrl.endDate ?? DateTime.now().add(Duration(days: 7)),
                ),
              ),
              SizedBox(height: 10.h),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  hisCtrl.fetchSchedules(); // Apply filter
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF19A4C6),
                ),
                child: const Text(
                  "Apply",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

@override
Widget build(BuildContext context) {
  return SafeArea(
    child: Scaffold(
      backgroundColor: Colors.white,
      appBar:  AppBar(
          backgroundColor: Colors.white,
          title: appText.primaryText(
            text: "Cleaning History",
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
          actions: [
    IconButton(
      icon: Icon(Icons.calendar_today, color: Colors.black, size: 20.sp),
      onPressed: () {
        // Navigate to your target screen
        Get.to(() => CalendarBookingScreen()); 
      },
    ),
  ],
        ),
      body: GetBuilder<HistoryController>(builder: (_) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: SmartRefresher(
            controller: hisCtrl.refreshController,
            onRefresh: hisCtrl.reload,
            onLoading: hisCtrl.fetchNextSchedules,
            enablePullUp: true,
            enablePullDown: true,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h),
                  Container(
                    height: 50.h,
                    width: 360.w,
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF7F6F5),
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        appText.primaryText(
                          text: 'Schedules',
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            elevation: 0,
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.w, vertical: 5.h),
                          ),
                          onPressed: _showDatePicker,
                          icon: Icon(Icons.filter_list,
                              color: const Color(0xFF77838F), size: 18.sp),
                          label: Text('Filter',
                              style: GoogleFonts.poppins(
                                  fontSize: 12.sp, color: Colors.black)),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15.h),

                  /// Schedule list
                  for (var data in hisCtrl.history)
                    if (data.booking != null &&
                        data.booking!.customer != null &&
                        data.staff != null)
                      StatusCard(
                        status: data.status ?? "Unknown",
                        color: hisCtrl.getStatusColor(data.status!),
                        customerName: data.booking!.customer!.name!,
                        onTap: () {
                          Get.to(() => BookingDetailsScreen(
                                bookingId: data.booking!.id!,
                                staff: data.staff!.name,
                                pCtrl: hisCtrl,
                                status: data.status ?? "Unknown",
                                scheduleId: data.id,
                                date:
                                    "${DateFormat("EEE, MMM dd, yyyy | hh:mm a").format(DateTime.parse(data.startTime!))} - ${DateFormat("hh:mm a").format(DateTime.parse(data.endTime!))}",
                              ))?.then((value) {
                            hisCtrl.reload(); // Refresh after return
                          });
                        },
                        time:
                            "${DateFormat("EEE, MMM dd, yyyy | hh:mm a").format(DateTime.parse(data.startTime!))} - ${DateFormat("hh:mm a").format(DateTime.parse(data.endTime!))}",
                        location: "Cleaned By : ${data.staff!.name}",
                      ),

                  if (hisCtrl.history.isEmpty)
                    Padding(
                      padding: EdgeInsets.only(top: 100.h),
                      child: Center(
                        child: Text(
                          "No schedules found.",
                          style: GoogleFonts.poppins(
                              fontSize: 14.sp, color: Colors.grey),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      }),
    ),
  );
}
}