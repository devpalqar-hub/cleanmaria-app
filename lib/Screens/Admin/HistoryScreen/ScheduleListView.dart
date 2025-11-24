import 'package:cleanby_maria/Screens/Admin/ClientScreen/BookingDetailsScreen.dart';
import 'package:cleanby_maria/Screens/Admin/ClientScreen/Views/StatusCard.dart';
import 'package:cleanby_maria/Screens/Admin/HistoryScreen/Controller/HistoryController.dart';
import 'package:cleanby_maria/Src/appText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class ScheduleListScreen extends StatefulWidget {
  const ScheduleListScreen({super.key});

  @override
  State<ScheduleListScreen> createState() => _ScheduleListScreenState();
}

class _ScheduleListScreenState extends State<ScheduleListScreen> {
  final HistoryController hisCtrl = Get.find<HistoryController>();

  @override
  void initState() {
    super.initState();

    // 🔹 Default filter: from today to +45 days
    final DateTime today = DateTime.now();
    final DateTime future = today.add(const Duration(days: 45));

    hisCtrl.startDate = today;
    hisCtrl.endDate = future;

    // Fetch schedules automatically
    WidgetsBinding.instance.addPostFrameCallback((_) {
      hisCtrl.fetchSchedules();
    });
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    if (args.value is PickerDateRange) {
      hisCtrl.startDate = args.value.startDate;
      hisCtrl.endDate = args.value.endDate;
    }
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
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
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
              ),
              SizedBox(height: 10.h),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  hisCtrl.fetchSchedules();
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

  Future<void> _openBookingDetails(item) async {
    if (item.booking?.id == null) return;

    await Get.to(() => BookingDetailsScreen(
          bookingId: item.booking!.id!,
          staff: item.staff?.name,
          pCtrl: hisCtrl,
          status: item.status ?? "Unknown",
          scheduleId: item.id,
          date:
              "${DateFormat("EEE, MMM dd, yyyy | hh:mm a").format(DateTime.parse(item.startTime!))} - ${DateFormat("hh:mm a").format(DateTime.parse(item.endTime!))}",
        ));

    // Refresh schedules & heatmap on return
    await hisCtrl.fetchSchedules();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Get.back(),
          ),
          title: appText.primaryText(
            text: "Schedules",
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.filter_list, color: Colors.black),
              onPressed: _showDatePicker,
            ),
          ],
        ),
        body: GetBuilder<HistoryController>(
          builder: (_) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
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
                      for (var data in hisCtrl.history)
                        if (data.booking != null &&
                            data.booking!.customer != null &&
                            data.staff != null)
                          StatusCard(
                            status: data.status ?? "Unknown",
                            color: hisCtrl.getStatusColor(data.status!),
                            customerName: data.booking!.customer!.name!,
                            time:
                                "${DateFormat("EEE, MMM dd, yyyy | hh:mm a").format(DateTime.parse(data.startTime!))} - ${DateFormat("hh:mm a").format(DateTime.parse(data.endTime!))}",
                            location: "Cleaned By : ${data.staff!.name}",
                            onTap: () => _openBookingDetails(data),
                          ),
                      if (hisCtrl.history.isEmpty)
                        Padding(
                          padding: EdgeInsets.only(top: 100.h),
                          child: Center(
                            child: Text(
                              "No schedules found.",
                              style: GoogleFonts.poppins(
                                fontSize: 14.sp,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
