import 'package:cleanby_maria/Screens/Admin/HistoryScreen/Controller/HistoryController.dart';

import 'package:cleanby_maria/Screens/Admin/StaffScreen/Service/Controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:cleanby_maria/Screens/Admin/StaffScreen/Models/StaffModel.dart';

class CalendarBookingScreen extends StatefulWidget {
  const CalendarBookingScreen({super.key});

  @override
  State<CalendarBookingScreen> createState() => _CalendarBookingScreenState();
}

class _CalendarBookingScreenState extends State<CalendarBookingScreen> {
  final DateRangePickerController _pickerController =
      DateRangePickerController();

  final StaffController staffController = Get.put(StaffController());
  final HistoryController historyController = Get.put(HistoryController());

  DateTime _currentMonth = DateTime.now();
  Staff? selectedStaff;

  @override
  void initState() {
    super.initState();
    _pickerController.displayDate =
        DateTime(_currentMonth.year, _currentMonth.month, 1);

    staffController.fetchStaffList();

    // ✅ fetch initial heatmap
    historyController.fetchHeatmap(
      year: _currentMonth.year,
      month: _currentMonth.month,
    );
  }

  void _onViewChanged(DateRangePickerViewChangedArgs args) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final newMonth = args.visibleDateRange.startDate ?? _currentMonth;
      setState(() {
        _currentMonth = newMonth;
      });

      // ✅ fetch heatmap for new month
      historyController.fetchHeatmap(
        year: _currentMonth.year,
        month: _currentMonth.month,
      );
    });
  }

  void _goToPrevMonth() {
    final prev = DateTime(_currentMonth.year, _currentMonth.month - 1, 1);
    setState(() {
      _currentMonth = prev;
      _pickerController.displayDate = prev;
    });
    historyController.fetchHeatmap(year: prev.year, month: prev.month);
  }

  void _goToNextMonth() {
    final next = DateTime(_currentMonth.year, _currentMonth.month + 1, 1);
    setState(() {
      _currentMonth = next;
      _pickerController.displayDate = next;
    });
    historyController.fetchHeatmap(year: next.year, month: next.month);
  }

  /// Custom heatmap cell
  Widget _cellBuilder(BuildContext context, DateRangePickerCellDetails details) {
  final DateTime date = details.date;
  final displayed = _pickerController.displayDate ?? _currentMonth;
  final bool isSameMonth =
      date.month == displayed.month && date.year == displayed.year;

  final key = DateFormat('yyyy-MM-dd').format(date);

  // ✅ Build map from heatmapDays
  final heatmapDays = historyController.heatmapData?.heatmapDays ?? [];
  final Map<String, int> heatmap = {
    for (final day in heatmapDays)
      DateFormat('yyyy-MM-dd').format(day.date): day.bookingCount,
  };

  final int bookingCount = heatmap[key] ?? 0;

  // ✅ calculate opacity scale
  final int maxBookings = heatmap.values.isNotEmpty
      ? heatmap.values.reduce((a, b) => a > b ? a : b)
      : 1;

  final double opacity = bookingCount > 0
      ? (0.1 + (bookingCount / maxBookings) * 0.9)
      : 0.05;

  final Color bookingColor = const Color(0xFF086989);

  final Color bgColor = !isSameMonth
      ? Colors.transparent
      : bookingColor.withOpacity(opacity);

  final Color textColor =
      !isSameMonth ? Colors.black26 : Colors.white;

  return AspectRatio(
    aspectRatio: 1,
    child: Container(
      margin: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (bookingCount > 0)
            Text(
              "$bookingCount Bk",
              style: GoogleFonts.poppins(
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                color: textColor,
              ),
            ),
          SizedBox(height: 6.h),
          Text(
            date.day.toString(),
            style: GoogleFonts.poppins(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: textColor,
            ),
          ),
        ],
      ),
    ),
  );
}


  @override
  Widget build(BuildContext context) {
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
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 12.h),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(6.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F7F8),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: const Icon(Icons.calendar_today_outlined, size: 18),
                ),
                SizedBox(width: 10.w),

                InkWell(onTap: _goToPrevMonth, child: const Icon(Icons.chevron_left)),
                SizedBox(width: 6.w),

                Text(
                  DateFormat("MMMM yyyy").format(_currentMonth),
                  style: GoogleFonts.poppins(
                      fontSize: 16.sp, fontWeight: FontWeight.w600),
                ),

                SizedBox(width: 6.w),
                InkWell(onTap: _goToNextMonth, child: const Icon(Icons.chevron_right)),

                const Spacer(),

                GetBuilder<StaffController>(
                  builder: (controller) {
                    if (controller.isLoading) {
                      return const CircularProgressIndicator();
                    }
                    if (controller.staffList.isEmpty) {
                      return Text("No staff", style: GoogleFonts.poppins(fontSize: 14.sp));
                    }
                    selectedStaff ??= controller.staffList.first;
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F7F8),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<Staff>(
                          value: selectedStaff,
                          items: controller.staffList
                              .map((s) => DropdownMenuItem(
                                    value: s,
                                    child: Text(s.name ?? "",
                                        style: GoogleFonts.poppins(fontSize: 14.sp)),
                                  ))
                              .toList(),
                          onChanged: (v) {
                            if (v == null) return;
                            setState(() => selectedStaff = v);
                          },
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),

            SizedBox(height: 12.h),

            Row(
              children: ['S', 'M', 'T', 'W', 'T', 'F', 'S']
                  .map((label) => Expanded(
                        child: Center(
                          child: Text(label,
                              style: GoogleFonts.poppins(
                                  fontSize: 12.sp, fontWeight: FontWeight.w600)),
                        ),
                      ))
                  .toList(),
            ),

            SizedBox(height: 8.h),

            Expanded(
              child: GetBuilder<HistoryController>(
                builder: (_) {
                  if (_.isLoadingHeatmap) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return SfDateRangePicker(
                    controller: _pickerController,
                    view: DateRangePickerView.month,
                    selectionMode: DateRangePickerSelectionMode.single,
                    headerHeight: 0,
                    showNavigationArrow: false,
                    onViewChanged: _onViewChanged,
                    cellBuilder: _cellBuilder,
                    monthViewSettings: const DateRangePickerMonthViewSettings(
                      showTrailingAndLeadingDates: true,
                    ),
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
