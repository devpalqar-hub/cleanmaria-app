import 'package:cleanby_maria/Screens/Admin/ScheduleViewScreen/Controller/ScheduleController.dart';
import 'package:cleanby_maria/Screens/Admin/ScheduleViewScreen/Views/MonthYearPickerSheet.dart';
import 'package:cleanby_maria/Screens/Admin/ScheduleViewScreen/Views/ScheduleListCard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';

class ScheduleViewScreen extends StatefulWidget {
  const ScheduleViewScreen({super.key});

  @override
  State<ScheduleViewScreen> createState() => _ScheduleViewScreenState();
}

class _ScheduleViewScreenState extends State<ScheduleViewScreen> {
  // int _currentMonth = 1; // January
  // int _currentYear = 2026;

  static const List<String> _months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  static const List<String> _weekDays = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];

  int get _daysInMonth =>
      DateTimeHelper.daysInMonth(ctrl.selectedMonth, ctrl.selectedYear);
  int get _firstWeekday =>
      DateTime(ctrl.selectedYear, ctrl.selectedMonth, 1).weekday % 7;

  void _showMonthYearPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => SafeArea(
        child: MonthYearPickerSheet(
          currentMonth: ctrl.selectedMonth,
          currentYear: ctrl.selectedYear,
          onSelected: (month, year) {
            setState(() {
              ctrl.selectedMonth = month;
              ctrl.selectedYear = year;
            });
            ctrl.update();
            ctrl.fetchHeatmapData();

            Navigator.pop(ctx);
          },
        ),
      ),
    );
  }

  Schedulecontroller ctrl = Get.put(Schedulecontroller());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ctrl.fetchHeatmapData();
    ctrl.fetchSchedules();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'History',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xFF0D0D0D),
            // letterSpacing: -0.5,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: _showMonthYearPicker,
            child: Row(
              children: [
                Text(
                  '${_months[ctrl.selectedMonth - 1]} ${ctrl.selectedYear}',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF0D0D0D),
                  ),
                ),
                const SizedBox(width: 4),
                const Icon(Icons.keyboard_arrow_down_rounded,
                    size: 20, color: Color(0xFF0D0D0D)),
              ],
            ),
          ),
          SizedBox(
            width: 20,
          )
        ],
      ),
      body: SafeArea(
        child: GetBuilder<Schedulecontroller>(builder: (context) {
          return Column(
            children: [
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: _buildCalendar(),
              ),

              const SizedBox(height: 8),
              const Divider(height: 1, color: Color(0xFFEEEEEE)),
              const SizedBox(height: 12),

              // ── Day Label ───────────────────────────────
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    DateFormat("dd MMMM, EEEE ").format(ctrl.selectedDate),
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF555555),
                      letterSpacing: 0.6,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // ── Booking Cards ────────────────────────────
              if (ctrl.isScheduleLoading)
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                    ],
                  ),
                )
              else
                Expanded(
                  child: ctrl.schedules.isEmpty
                      ? _buildEmptyState()
                      : ListView.separated(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                          itemCount: ctrl.schedules.length,
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 12),
                          itemBuilder: (ctx, i) =>
                              ScheduleListCard(booking: ctrl.schedules[i]),
                        ),
                ),
            ],
          );
        }),
      ),
    );
  }

  // ─── Calendar Grid ────────────────────────────────────────────────────────

  Widget _buildCalendar() {
    return Column(
      children: [
        // Weekday headers
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: _weekDays
              .map((d) => SizedBox(
                    width: 40,
                    child: Center(
                      child: Text(
                        d,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF999999),
                        ),
                      ),
                    ),
                  ))
              .toList(),
        ),
        const SizedBox(height: 6),
        // Day grid
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            mainAxisSpacing: 0,
            crossAxisSpacing: 0,
            childAspectRatio: 0.85,
          ),
          itemCount: _firstWeekday + _daysInMonth,
          itemBuilder: (ctx, index) {
            if (index < _firstWeekday) return const SizedBox();
            final day = index - _firstWeekday + 1;
            return _buildDayCell(day);
          },
        ),
      ],
    );
  }

  Widget _buildDayCell(int day) {
    final isSelected = ctrl.selectedDate.day == day &&
        (ctrl.selectedDate.year == ctrl.selectedYear &&
            ctrl.selectedDate.month == ctrl.selectedMonth);
    int bookingCount = 0;
    if (ctrl.calenderItems.length > day) {
      bookingCount = ctrl.calenderItems[day - 1].bookingCount;
    }

    return GestureDetector(
      onTap: () => setState(() {
        ctrl.selectedDate =
            DateTime(ctrl.selectedYear, ctrl.selectedMonth, day);
        ctrl.update();
        ctrl.fetchSchedules();
      }),
      child: Container(
        margin: const EdgeInsets.all(2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color:
                    isSelected ? const Color(0xFF0D0D0D) : Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '$day',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: isSelected ? Colors.white : const Color(0xFF0D0D0D),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 2),
            if (bookingCount > 0)
              Text(
                '${bookingCount}bk',
                style: const TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF18B9C5),
                  letterSpacing: 0.2,
                ),
              )
            else
              const SizedBox(height: 11),
          ],
        ),
      ),
    );
  }

  // ─── Empty State ──────────────────────────────────────────────────────────

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(Icons.calendar_today_outlined,
                color: Color(0xFFBBBBBB), size: 28),
          ),
          const SizedBox(height: 16),
          const Text(
            'No bookings on this day',
            style: TextStyle(
                fontSize: 15,
                color: Color(0xFF999999),
                fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}

class DateTimeHelper {
  static int daysInMonth(int month, int year) {
    return DateTime(year, month + 1, 0).day;
  }
}
