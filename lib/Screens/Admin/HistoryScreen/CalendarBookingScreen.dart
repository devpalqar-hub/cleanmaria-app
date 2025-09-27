import 'package:cleanby_maria/Screens/Admin/ClientScreen/BookingDetailsScreen.dart';
import 'package:cleanby_maria/Screens/Admin/HistoryScreen/Controller/HistoryController.dart';
import 'package:cleanby_maria/Screens/Admin/StaffScreen/Service/Controller.dart';
import 'package:cleanby_maria/Screens/Admin/StaffScreen/Models/StaffModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CalendarBookingScreen extends StatefulWidget {
  final bool isStaff;
  final String staffId;

  const CalendarBookingScreen({
    super.key,
    this.isStaff = false,
    this.staffId = "-1",
  });

  @override
  State<CalendarBookingScreen> createState() => _CalendarBookingScreenState();
}

class _CalendarBookingScreenState extends State<CalendarBookingScreen> {
  final DateRangePickerController _pickerController = DateRangePickerController();
  final StaffController staffController = Get.put(StaffController());
  final HistoryController historyController = Get.put(HistoryController());

 DateTime _currentMonth = DateTime.now();
  DateTime? _selectedDate;
  String selectedStaff = "-1";

  @override
  void initState() {
    super.initState();
    _pickerController.displayDate = DateTime(_currentMonth.year, _currentMonth.month, 1);
    selectedStaff = widget.staffId;
    loadSchedules();
  }

  Future<void> loadSchedules() async {
    await staffController.fetchStaffList();

    String staffIdToUse = await getStaffId();

    await historyController.fetchHeatmap(
      year: _currentMonth.year,
      month: _currentMonth.month,
      staffId: staffIdToUse,
    );

    if (_selectedDate != null) {
      historyController.history.clear();
      historyController.update();
      await Future.delayed(const Duration(milliseconds: 300));
      await historyController.fetchSchedulesForDate(_selectedDate!, staffId: staffIdToUse);
    }
  }

  Future<String> getStaffId() async {
    if (widget.isStaff) {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString("user_id") ?? "-1";
    } else {
      return selectedStaff;
    }
  }

  void _onViewChanged(DateRangePickerViewChangedArgs args) async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!mounted) return;

      final visibleRange = args.visibleDateRange;
      if (visibleRange == null || visibleRange.startDate == null) return;

      final start = visibleRange.startDate!;
      final end = visibleRange.endDate ?? start;
      final midDate = start.add(Duration(days: ((end.difference(start).inDays) ~/ 2)));

      final newMonth = DateTime(midDate.year, midDate.month, 1);

      if (newMonth.month != _currentMonth.month || newMonth.year != _currentMonth.year) {
        setState(() {
          _currentMonth = newMonth;
          _selectedDate = null;
        });

        String staffIdToUse = await getStaffId();

        historyController.history.clear();
        historyController.update();

        await historyController.fetchHeatmap(
          year: _currentMonth.year,
          month: _currentMonth.month,
          staffId: staffIdToUse,
        );
      }
    });
  }

  void _onDateSelected(DateRangePickerSelectionChangedArgs args) async {
    if (args.value is DateTime) {
      final selected = args.value as DateTime;

      if (_selectedDate != null && _selectedDate == selected) return;

      setState(() => _selectedDate = selected);

      String staffIdToUse = await getStaffId();

      historyController.history.clear();
      historyController.update();

      await Future.delayed(const Duration(milliseconds: 300));

      await historyController.fetchSchedulesForDate(selected, staffId: staffIdToUse);
    }
  }

  @override
  Widget build(BuildContext context) {
    final firstDayOfMonth = DateTime(_currentMonth.year, _currentMonth.month, 1);
    final lastDayOfMonth = DateTime(_currentMonth.year, _currentMonth.month + 1, 0);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Schedules",
          style: GoogleFonts.poppins(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        actions: [
          if (!widget.isStaff)
            GetBuilder<StaffController>(
              builder: (controller) {
                if (controller.isLoading) {
                  return const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(),
                  );
                }

                if (controller.staffList.isEmpty) return const SizedBox.shrink();

                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
                  width: 120.w,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F7F8),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: selectedStaff,
                      items: [
                        Staff(id: "-1", name: "All", email: "", phone: "", status: "", priority: 1),
                        ...controller.staffList
                      ].map((s) => DropdownMenuItem(
                            value: s.id,
                            child: Text(
                              s.name ?? "",
                              style: GoogleFonts.poppins(fontSize: 14.sp),
                            ),
                          )).toList(),
                      onChanged: (v) async {
                        if (v == null) return;
                        setState(() => selectedStaff = v);
                        await loadSchedules();
                      },
                    ),
                  ),
                );
              },
            ),
          SizedBox(width: 20.w),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 12.h),
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: GetBuilder<HistoryController>(
                builder: (_) {
                  if (_.isLoadingHeatmap) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  return SfDateRangePicker(
                    controller: _pickerController,
                    view: DateRangePickerView.month,
                    selectionMode: DateRangePickerSelectionMode.single,
                    headerHeight: 40,
                    showNavigationArrow: true,
                    toggleDaySelection: true,
                    enablePastDates: true,
                    backgroundColor: Colors.white,
                    onViewChanged: _onViewChanged,
                    onSelectionChanged: _onDateSelected,
                    cellBuilder: (context, DateRangePickerCellDetails data) {
                      if (data.date.isBefore(firstDayOfMonth) || data.date.isAfter(lastDayOfMonth)) {
                        return Container();
                      }

                      int scheduleCount = historyController.fetchCountFromDate(data.date);

                      return GestureDetector(
                        onTap: () => _onDateSelected(DateRangePickerSelectionChangedArgs(data.date)),
                        child: Container(
                          height: 40.h,
                          margin: EdgeInsets.all(2.h),
                          decoration: BoxDecoration(
                            color: historyController.getHeatMapColor(scheduleCount, historyController.total),
                            borderRadius: BorderRadius.circular(5.r),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "$scheduleCount bk",
                                style: GoogleFonts.poppins(
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                DateFormat("dd").format(data.date),
                                style: GoogleFonts.poppins(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    monthViewSettings: const DateRangePickerMonthViewSettings(
                      showTrailingAndLeadingDates: false,
                    ),
                  );
                },
              ),
            ),
            Expanded(
              flex: 1,
              child: GetBuilder<HistoryController>(
                builder: (_) {
                  if (_.isLoadingHeatmap) return const Center(child: CircularProgressIndicator());
                  if (_selectedDate == null) return const SizedBox.shrink();
                  if (_.history.isEmpty) {
                    return Center(
                      child: Text(
                        "No schedules for this date",
                        style: GoogleFonts.poppins(fontSize: 14.sp),
                      ),
                    );
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        DateFormat("d MMMM, EEEE").format(_selectedDate!),
                        style: GoogleFonts.poppins(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Expanded(
                        child: ListView.builder(
                          itemCount: _.history.length,
                          itemBuilder: (context, index) {
                            final item = _.history[index];

                            String start = item.startTime != null
                                ? DateFormat("hh:mm a").format(DateTime.parse(item.startTime!))
                                : "-";
                            String end = item.endTime != null
                                ? DateFormat("hh:mm a").format(DateTime.parse(item.endTime!))
                                : "-";

                            return Padding(
                              padding: EdgeInsets.all(10.h),
                              child: InkWell(
                                onTap: () {
  final bookingId = item.booking?.id;
  if (bookingId != null) {
    // Format the schedule date and time
   String formattedDate = _selectedDate != null
        ? "${DateFormat('EEE, MMM d, yyyy').format(_selectedDate!)} | ${start} - ${end}"
        : "";

    Get.to(
      () => BookingDetailsScreen(
        bookingId: bookingId,
        date: formattedDate,  // Pass the formatted string
        staff: item.staff?.name,
      ),
    );
  } else {
    Get.snackbar("Error", "Booking details not available");
  }
},

                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    CircleAvatar(
                                      radius: 20.sp,
                                      backgroundColor: const Color(0xff17A5C6),
                                      child: Text(
                                        (item.booking?.customer?.name ?? "U").substring(0, 1).toUpperCase(),
                                        style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 12.w),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            item.booking?.customer?.name ?? "Unknown Customer",
                                            style: GoogleFonts.poppins(
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          SizedBox(height: 4.h),
                                          Text(
                                            "Time: $start - $end",
                                            style: GoogleFonts.poppins(
                                              fontSize: 14.sp,
                                              color: Colors.grey[600],
                                            ),
                                          ),
                                          SizedBox(height: 2.h),
                                          Text(
                                            "Staff: ${item.staff?.name ?? "N/A"}",
                                            style: GoogleFonts.poppins(
                                              fontSize: 14.sp,
                                              color: Colors.grey[600],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
