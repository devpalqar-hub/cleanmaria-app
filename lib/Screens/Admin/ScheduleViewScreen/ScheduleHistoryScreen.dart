import 'package:cleanby_maria/Screens/Admin/ScheduleViewScreen/Controller/ScheduleHistoryController.dart';
import 'package:cleanby_maria/Screens/Admin/ScheduleViewScreen/Views/ScheduleListCard.dart';
import 'package:cleanby_maria/Screens/Admin/ScheduleViewScreen/Views/ScheduleLogCard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScheduleHistoryScreen extends StatefulWidget {
  final String? bookingID;
  final String? staffID;
  bool isAdmin;
  bool isUser;
  ScheduleHistoryScreen(
      {super.key,
      this.bookingID,
      this.staffID,
      this.isAdmin = false,
      this.isUser = false});

  @override
  State<ScheduleHistoryScreen> createState() => _ScheduleHistoryScreenState();
}

class _ScheduleHistoryScreenState extends State<ScheduleHistoryScreen> {
  late ScheduleHistoryController _ctrl;
  String? _selectedBookingId;
  String? _selectedStaffId;

  @override
  void initState() {
    super.initState();
    _selectedBookingId = widget.bookingID;
    _selectedStaffId = widget.staffID;
    _ctrl = Get.put(ScheduleHistoryController(
        sBID: _selectedBookingId, sSID: _selectedStaffId));
    ;
  }

  Future<void> _selectDateRange(BuildContext context) async {
    final DateTimeRange? result = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2026),
      lastDate: DateTime.now().add(const Duration(days: 1000)),
      initialDateRange: _ctrl.startDate != null && _ctrl.endDate != null
          ? DateTimeRange(start: _ctrl.startDate!, end: _ctrl.endDate!)
          : null,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF18B9C5),
              onPrimary: Colors.white,
              onSurface: Color(0xFF424242),
              surface: Color(0xFFFFFFFF),
              outline: Color(0xFFDDDDDD),
              outlineVariant: Color(0xFFEEEEEE),
            ),
            dialogBackgroundColor: Color(0xFFFFFFFF),
            scaffoldBackgroundColor: Color(0xFFFFFFFF),
            textTheme: const TextTheme(
              bodyMedium: TextStyle(
                color: Color(0xFF424242),
                fontSize: 14,
              ),
              bodySmall: TextStyle(
                color: Color(0xFF757575),
                fontSize: 12,
              ),
              labelLarge: TextStyle(
                color: Color(0xFF18B9C5),
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
            datePickerTheme: DatePickerThemeData(
              backgroundColor: const Color(0xFFFFFFFF),
              surfaceTintColor: Colors.transparent,
              headerHeadlineStyle: const TextStyle(
                color: Color(0xFF0D0D0D),
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
              headerHelpStyle: const TextStyle(
                color: Color(0xFF757575),
                fontSize: 12,
              ),
              weekdayStyle: const TextStyle(
                color: Color(0xFF757575),
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
              dayStyle: const TextStyle(
                color: Color(0xFF424242),
                fontSize: 13,
              ),
              dayForegroundColor: MaterialStateProperty.resolveWith((states) {
                if (states.contains(MaterialState.selected)) {
                  return Colors.white;
                }
                return const Color(0xFF424242);
              }),
              dayBackgroundColor: MaterialStateProperty.resolveWith((states) {
                if (states.contains(MaterialState.selected)) {
                  return const Color(0xFF18B9C5).withOpacity(.2);
                }
                return Colors.transparent;
              }),
              rangePickerBackgroundColor: Colors.transparent,
              todayBackgroundColor:
                  MaterialStateProperty.all(Colors.transparent),
              todayForegroundColor: MaterialStateProperty.all(
                const Color(0xFF18B9C5),
              ),
              rangeSelectionBackgroundColor: const Color(0xFFE6F8F9),
            ),
          ),
          child: child!,
        );
      },
    );

    if (result != null) {
      _ctrl.setDateRange(result.start, result.end);
    }
  }

  void _applyFilters() {
    if (_ctrl.startDate != null && _ctrl.endDate != null) {
      // if (_selectedBookingId.isNotEmpty) {
      //   _ctrl.setBookingId(_selectedBookingId);
      // }
      // if (_selectedStaffId.isNotEmpty) {
      _ctrl.setStaffId(_selectedStaffId);
      // }
      _ctrl.fetchSchedules();
    }
  }

  void _resetFilters() {
    setState(() {
      _selectedBookingId = "";
      _selectedStaffId = "";
    });
    _ctrl.resetFilters();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: const Text(
          'Schedule History',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xFF0D0D0D),
          ),
        ),
        actions: [
          // Reset Filters Button
          TextButton(
            onPressed: _resetFilters,
            child: const Text(
              'Reset',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Color(0xFF18B9C5),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: GetBuilder<ScheduleHistoryController>(
          builder: (ctrl) {
            return Column(
              children: [
                // ── Filters Section ──
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: Color(0xFFF9FAFB),
                    border: Border(
                      bottom: BorderSide(color: Color(0xFFEEEEEE), width: 1),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Date Range Picker
                      GestureDetector(
                        onTap: () => _selectDateRange(context),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xFFEEEEEE)),
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white,
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.calendar_today_outlined,
                                size: 18,
                                color: Color(0xFF18B9C5),
                              ),
                              const SizedBox(width: 8),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Date Range',
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Color(0xFFAAAAAA),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    ctrl.startDate != null &&
                                            ctrl.endDate != null
                                        ? '${ctrl.formattedStartDate} - ${ctrl.formattedEndDate}'
                                        : 'Select date range',
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: ctrl.startDate != null
                                          ? const Color(0xFF0D0D0D)
                                          : const Color(0xFFAAAAAA),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Apply Filter Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: ctrl.startDate == null ||
                                  ctrl.endDate == null ||
                                  ctrl.isLoading
                              ? null
                              : () => _applyFilters(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF18B9C5),
                            foregroundColor: Colors.white,
                            disabledBackgroundColor: const Color(0xFFCCCCCC),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            elevation: 0,
                          ),
                          child: ctrl.isLoading
                              ? const SizedBox(
                                  height: 18,
                                  width: 18,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white),
                                  ),
                                )
                              : const Text(
                                  'Apply Filters',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),

                // ── Schedules List ──
                Expanded(
                  child: ctrl.schedules.isEmpty && !ctrl.isLoading
                      ? _buildEmptyState()
                      : ListView.separated(
                          controller: ctrl.scrollController,
                          padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
                          itemCount: ctrl.schedules.length +
                              (ctrl.isPaginationLoading ? 1 : 0),
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 10),
                          itemBuilder: (context, index) {
                            // Loading indicator at bottom
                            if (index == ctrl.schedules.length &&
                                ctrl.isPaginationLoading) {
                              return Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    children: [
                                      const SizedBox(
                                        height: 24,
                                        width: 24,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                            Color(0xFF18B9C5),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      const Text(
                                        'Loading more...',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Color(0xFF888888),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }

                            return Schedulelogcard(
                                booking: ctrl.schedules[index],
                                makeClick: false,
                                role: (_selectedStaffId != "" &&
                                        _selectedStaffId != null)
                                    ? CardRole.staff
                                    : (widget.isUser)
                                        ? CardRole.user
                                        : CardRole.admin);
                          },
                        ),
                ),

                // ── Pagination Info ──
                // if (ctrl.schedules.isNotEmpty)
                //   Container(
                //     padding: const EdgeInsets.all(12),
                //     decoration: const BoxDecoration(
                //       color: Color(0xFFF9FAFB),
                //       border: Border(
                //         top: BorderSide(color: Color(0xFFEEEEEE), width: 1),
                //       ),
                //     ),
                //     child: Text(
                //       'Page ${ctrl.currentPage} of ${ctrl.totalPages} • ${ctrl.schedules.length} items',
                //       textAlign: TextAlign.center,
                //       style: const TextStyle(
                //         fontSize: 12,
                //         color: Color(0xFF888888),
                //         fontWeight: FontWeight.w500,
                //       ),
                //     ),
                //   ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: const Color(0xFFE6F8F9),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(
                Icons.calendar_today_outlined,
                color: Color(0xFF18B9C5),
                size: 40,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'No Schedules Found',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF0D0D0D),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Try adjusting your filters\nor date range',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                color: Color(0xFF888888),
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
