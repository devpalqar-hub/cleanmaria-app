import 'package:cleanby_maria/Screens/User/new_booking/Controllers/CreateBookingController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'review_pay_screen.dart';

class DateTimeScreen extends StatefulWidget {
  const DateTimeScreen({super.key});

  @override
  State<DateTimeScreen> createState() => _DateTimeScreenState();
}

class _DateTimeScreenState extends State<DateTimeScreen> {
  static const Color primaryGreen = Color(0xFF2F7F6F);
  late DateTime selectedDate;
  late DateTime displayMonth;
  late DateTime minimumDate;

  @override
  void initState() {
    super.initState();
    minimumDate = DateTime.now().add(Duration(days: 2));
    selectedDate = minimumDate;
    displayMonth = DateTime(minimumDate.year, minimumDate.month, 1);
  }

  List<DateTime> generateDates() {
    List<DateTime> dates = [];
    DateTime firstDayOfMonth =
        DateTime(displayMonth.year, displayMonth.month, 1);
    DateTime lastDayOfMonth =
        DateTime(displayMonth.year, displayMonth.month + 1, 0);

    for (int i = 0; i <= lastDayOfMonth.day - 1; i++) {
      DateTime date = firstDayOfMonth.add(Duration(days: i));
      // Only add dates that are >= minimumDate
      if (date.isAfter(minimumDate.subtract(Duration(days: 1)))) {
        dates.add(date);
      }
    }
    return dates;
  }

  bool canNavigateToPreviousMonth() {
    DateTime previousMonth =
        DateTime(displayMonth.year, displayMonth.month - 1, 1);
    return previousMonth.year > minimumDate.year ||
        (previousMonth.year == minimumDate.year &&
            previousMonth.month >= minimumDate.month);
  }

  void changeMonth(int direction) {
    if (direction < 0 && !canNavigateToPreviousMonth()) {
      return; // Don't allow navigation to previous month
    }

    setState(() {
      displayMonth =
          DateTime(displayMonth.year, displayMonth.month + direction, 1);
      // If selected date is not in the new month or is before minimum date, select the first available day
      if (selectedDate.month != displayMonth.month ||
          selectedDate.year != displayMonth.year ||
          selectedDate.isBefore(minimumDate)) {
        List<DateTime> availableDates = generateDates();
        if (availableDates.isNotEmpty) {
          selectedDate = availableDates.first;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: Text(
          "New Booking",
          style: GoogleFonts.inter(
              color: Colors.black, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: GetBuilder<CreateBookingController>(builder: (___) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _progress("Step 4 of 4"),

              Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  "Select date & time",
                  style: GoogleFonts.inter(
                      fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      DateFormat('MMMM yyyy').format(displayMonth),
                      style: GoogleFonts.inter(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Row(
                      children: [
                        InkWell(
                          onTap: canNavigateToPreviousMonth()
                              ? () => changeMonth(-1)
                              : null,
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              Icons.chevron_left,
                              color: canNavigateToPreviousMonth()
                                  ? primaryGreen
                                  : Colors.grey.withOpacity(0.4),
                              size: 20,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        InkWell(
                          onTap: () => changeMonth(1),
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              Icons.chevron_right,
                              color: primaryGreen,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              /// HORIZONTAL CALENDAR
              SizedBox(
                height: 70,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: generateDates().length,
                  itemBuilder: (context, index) {
                    final date = generateDates()[index];
                    final isSelected = DateFormat('yyyy-MM-dd').format(date) ==
                        DateFormat('yyyy-MM-dd').format(selectedDate);
                    final isPastDate = date.isBefore(minimumDate);
                    final isMinimumDate =
                        DateFormat('yyyy-MM-dd').format(date) ==
                            DateFormat('yyyy-MM-dd').format(minimumDate);

                    return GestureDetector(
                      onTap: isPastDate
                          ? null
                          : () {
                              setState(() {
                                selectedDate = date;
                                print("working");
                                ___.fetchAvalibility(DateFormat("yyyy-MM-dd")
                                    .format(selectedDate));
                              });
                            },
                      child: Opacity(
                        opacity: isPastDate ? 0.3 : 1.0,
                        child: Container(
                          width: 60,
                          margin: const EdgeInsets.only(right: 12),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? primaryGreen
                                : Colors.grey.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: isSelected
                                  ? primaryGreen
                                  : isMinimumDate
                                      ? primaryGreen.withOpacity(0.3)
                                      : Colors.grey.withOpacity(0.2),
                              width: isSelected ? 2 : 1,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                DateFormat('EEE').format(date),
                                style: GoogleFonts.inter(
                                  color:
                                      isSelected ? Colors.white : Colors.grey,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                DateFormat('d').format(date),
                                style: GoogleFonts.inter(
                                  color:
                                      isSelected ? Colors.white : Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 4),
                              if (isMinimumDate && !isSelected)
                                Container(
                                  width: 6,
                                  height: 6,
                                  decoration: BoxDecoration(
                                    color: primaryGreen,
                                    shape: BoxShape.circle,
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

              const SizedBox(height: 24),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  "Available slots",
                  style: GoogleFonts.inter(color: Colors.grey, fontSize: 14),
                ),
              ),

              const SizedBox(height: 12),

              /// TIME SLOTS
              ___.isLoadingTimeSlots
                  ? Padding(
                      padding: const EdgeInsets.all(32),
                      child: Center(
                        child: Column(
                          children: [
                            CircularProgressIndicator(color: primaryGreen),
                            SizedBox(height: 16),
                            Text(
                              "Loading time slots...",
                              style: GoogleFonts.inter(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        children:
                            [for (var data in ___.timeSlots) data].map((time) {
                          final isSelected = ___.selectedTimeSlot == time;
                          final isAvailable = time.isAvailable ?? false;
                          return GestureDetector(
                            onTap: isAvailable
                                ? () {
                                    ___.selectedTimeSlot = time;
                                    ___.update();
                                  }
                                : null,
                            child: Opacity(
                              opacity: isAvailable ? 1.0 : 0.4,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 18, vertical: 12),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? primaryGreen.withOpacity(0.1)
                                      : isAvailable
                                          ? Colors.white
                                          : Colors.grey.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: isSelected
                                        ? primaryGreen
                                        : isAvailable
                                            ? Colors.grey.shade300
                                            : Colors.grey.shade200,
                                    width: isSelected ? 1 : 1,
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      time.time ?? "",
                                      style: GoogleFonts.inter(
                                        fontSize: 12.sp,
                                        color: isSelected
                                            ? primaryGreen
                                            : isAvailable
                                                ? Colors.black
                                                : Colors.grey,
                                        fontWeight: isSelected
                                            ? FontWeight.w600
                                            : FontWeight.w500,
                                        decoration: isAvailable
                                            ? TextDecoration.none
                                            : TextDecoration.lineThrough,
                                      ),
                                    ),
                                    // if (!isAvailable) ...[
                                    //   SizedBox(width: 6),
                                    //   Icon(
                                    //     Icons.lock,
                                    //     size: 14.sp,
                                    //     color: Colors.grey,
                                    //   ),
                                    // ],
                                  ],
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),

              const Spacer(),

              /// CONTINUE
              Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryGreen,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      Get.to(() => ReviewPayScreen());
                    },
                    child: Text(
                      "Continue",
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _progress(String text) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: GoogleFonts.inter(color: Colors.grey, fontSize: 14),
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: 0.5,
            color: primaryGreen,
            backgroundColor: Colors.grey.shade300,
          ),
        ],
      ),
    );
  }
}
