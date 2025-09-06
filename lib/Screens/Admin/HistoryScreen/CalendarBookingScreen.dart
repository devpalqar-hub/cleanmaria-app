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
  String? selectedStaff = "-1";

  @override
  void initState() {
    super.initState();
    _pickerController.displayDate =
        DateTime(_currentMonth.year, _currentMonth.month, 1);

    loadSchedules();
  }

  loadSchedules() async {
    await staffController.fetchStaffList();
    await historyController.fetchHeatmap(
      year: _currentMonth.year,
      month: _currentMonth.month,
    );
  }

  void _onViewChanged(DateRangePickerViewChangedArgs args) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final newMonth = args.visibleDateRange.startDate;

      if (newMonth != null && newMonth.month != _currentMonth.month) {
        setState(() {
          _currentMonth = newMonth!;
          historyController.fetchHeatmap(
              year: _currentMonth.year,
              month: _currentMonth.month,
              staffId: selectedStaff ?? "-1");
        });
      }
    });
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
        actions: [
          GetBuilder<StaffController>(
            builder: (controller) {
              if (controller.isLoading) {
                return const CircularProgressIndicator();
              }
              if (controller.staffList.isEmpty) {
                return Text("No staff",
                    style: GoogleFonts.poppins(fontSize: 14.sp));
              }
              selectedStaff ??= "";
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
                width: 100.w,
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F7F8),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    isExpanded: false,
                    isDense: true,
                    value: selectedStaff,
                    items: [
                      Staff(
                          id: "-1",
                          name: "All",
                          email: "",
                          phone: "",
                          status: "",
                          priority: 1),
                      for (var data in staffController.staffList) data
                    ]
                        .map((s) => DropdownMenuItem(
                              value: s.id,
                              child: Text(s.name ?? "",
                                  style: GoogleFonts.poppins(fontSize: 14.sp)),
                            ))
                        .toList(),
                    onChanged: (v) {
                      if (v == null) return;
                      setState(() => selectedStaff = v);
                      historyController.fetchHeatmap(
                          year: _currentMonth.year,
                          month: _currentMonth.day,
                          staffId: selectedStaff ?? "-1");
                    },
                  ),
                ),
              );
            },
          ),
          SizedBox(
            width: 20.h,
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 12.h),
        child: Column(
          children: [
            SizedBox(height: 12.h),
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
                    headerHeight: 40,
                    showNavigationArrow: true,
                    toggleDaySelection: true,
                    enablePastDates: false,
                    backgroundColor: Colors.white,
                    onViewChanged: _onViewChanged,
                    cellBuilder: (context, DateRangePickerCellDetails data) =>
                        (data.date.month ==
                                _pickerController.displayDate!.month)
                            ? Container(
                                height: 30.h,
                                margin: EdgeInsets.all(2.h),
                                decoration: BoxDecoration(
                                    color: historyController.getHeatMapColor(
                                        historyController
                                            .fetchCountFromDate(data.date),
                                        historyController.total),
                                    borderRadius: BorderRadius.circular(5.r)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "${historyController.fetchCountFromDate(data.date)} bk",
                                      style: GoogleFonts.poppins(
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      DateFormat("dd").format(data.date),
                                      style: GoogleFonts.poppins(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w500),
                                    )
                                  ],
                                ),
                              )
                            : Container(),
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
