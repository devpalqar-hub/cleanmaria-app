import 'package:cleanby_maria/Screens/Admin/ClientScreen/Models/BookingDetailModel.dart';
import 'package:cleanby_maria/Screens/Admin/ScheduleViewScreen/Controller/ScheduleDetailsController.dart';
import 'package:cleanby_maria/Screens/Admin/ScheduleViewScreen/Models/ScheduleItemModel.dart';
import 'package:cleanby_maria/Screens/Admin/ScheduleViewScreen/ScheduleHistoryScreen.dart';
import 'package:cleanby_maria/Screens/Admin/ScheduleViewScreen/Views/BookingBottomBar.dart';
import 'package:cleanby_maria/Screens/Admin/ScheduleViewScreen/Views/PaymentSummaryCard.dart';
import 'package:cleanby_maria/Screens/Admin/ScheduleViewScreen/Views/ProfessionalCard.dart';
import 'package:cleanby_maria/Screens/Admin/ScheduleViewScreen/Views/PropertyDetails.dart';
import 'package:cleanby_maria/Screens/Admin/ScheduleViewScreen/Views/ServiceInfoSection.dart';
import 'package:cleanby_maria/Screens/Admin/ScheduleViewScreen/Views/StatusBanner.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';

// ═══════════════════════════════════════════════════════
// DATA MODELS
// ═══════════════════════════════════════════════════════

// ═══════════════════════════════════════════════════════
// THEME / CONSTANTS
// ═══════════════════════════════════════════════════════

class AppColors {
  static const teal = Color(0xFF18B9C5);
  static const tealLight = Color(0xFFE6F8F9);
  static const dark = Color(0xFF0D0D0D);
  static const grey = Color(0xFF888888);
  static const greyLight = Color(0xFFF5F5F5);
  static const divider = Color(0xFFEEEEEE);
  static const red = Color(0xFFE53935);
  static const amber = Color(0xFFFFC107);
  static const sectionLabel = Color(0xFF888888);
}

// ═══════════════════════════════════════════════════════
// MAIN SCREEN
// ═══════════════════════════════════════════════════════

class ScheduleDetailsScreen extends StatelessWidget {
  String bookingID;
  bool isUser;
  bool isStaff;
  bool isAdmin;
  ScheduleItemModel? schedule;

  ScheduleDetailsScreen(
      {super.key,
      required this.bookingID,
      this.schedule,
      this.isStaff = false,
      this.isAdmin = false,
      this.isUser = false});

  late ScheduleDetailsController ctrl;

  @override
  Widget build(BuildContext context) {
    ctrl = Get.put(ScheduleDetailsController(bookingID, schedule));
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          (schedule != null) ? "Schedule Details" : "Booking Details",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        actions: [
          if (!isStaff)
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: InkWell(
                  onTap: () {
                    Get.to(() => ScheduleHistoryScreen(
                          bookingID: bookingID,
                          isAdmin: isAdmin,
                        ));
                  },
                  child: Image.asset(
                    "assets/v2/schedules.png",
                    width: 24,
                    height: 24,
                    color: Color(0xff17A5C6),
                  )),
            ),
        ],
      ),
      body: GetBuilder<ScheduleDetailsController>(builder: (__) {
        return (ctrl.isLoading)
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 100),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 1 ── Status Banner
                    if (schedule != null)
                      StatusBanner(
                          status: schedule!.status!
                              .toUpperCase()
                              .replaceAll("_", " "),
                          startsIn: ctrl.formatDuration(
                              DateTime.parse(schedule!.startTime!)
                                  .difference(DateTime.now()))),
                    const SizedBox(height: 20),

                    // 2 ── Service Info
                    ServiceInfoSection(
                      serviceType: ctrl.bookingDetail!.service!.name!,
                      date: (schedule != null)
                          ? "${DateFormat("EEEE, dd MMMM yyyy").format(DateTime.parse(ctrl.schedule!.startTime!).toLocal())}"
                          : "${DateFormat("EEEE, dd MMMM yyyy").format(DateTime.parse(ctrl.bookingDetail!.date!).toLocal())}",
                      timeRange: ctrl.getBookingTime(),
                      address: ctrl.getBookinAddress(),
                      entryCode: (ctrl.bookingDetail!.bookingAddress!
                              .specialInstructions ??
                          "No Instruction"),
                    ),
                    const SizedBox(height: 20),

                    // 3 ── Property Details
                    PropertyDetailsSection(property: ctrl.bookingDetail!),
                    const SizedBox(height: 20),

                    // 4 ── Assigned Professional
                    if (schedule != null && isStaff == false) ...[
                      _SectionLabel(label: 'ASSIGNED PROFESSIONAL'),
                      SizedBox(height: 10),
                      ProfessionalCard(
                        name: schedule!.staff!.name!,
                        subname: schedule!.staff!.email!,
                        id: ctrl.schedule!.staff!.id!,
                      ),
                      SizedBox(height: 20),
                    ],

                    if (ctrl.bookingDetail != null && isUser == false) ...[
                      _SectionLabel(label: 'CUSTOMER DETAILS'),
                      SizedBox(height: 10),
                      ProfessionalCard(
                        name: ctrl.bookingDetail!.customer!.name!,
                        subname: ctrl.bookingDetail!.customer!.phone!,
                        id: ctrl.bookingDetail!.customer!.id!,
                      ),
                      SizedBox(height: 20),
                    ],

                    // 5 ── Payment Summary
                    _SectionLabel(label: 'PAYMENT SUMMARY'),
                    const SizedBox(height: 10),
                    PaymentSummaryCard(
                      bookings: ctrl.bookingDetail!,
                      isAdmin: isAdmin,
                      bookingId: bookingID,
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              );
      }),
      bottomNavigationBar: GetBuilder<ScheduleDetailsController>(builder: (__) {
        return __.bookingDetail == null ||
                __.bookingDetail!.status == "canceled"
            ? Container(
                width: 0,
                height: 0,
              )
            : BottomActionBar(
                booking: ctrl.bookingDetail!,
                isStaff: isStaff,
                isAdmin: isAdmin,
                isUser: isUser,
                schedule: schedule,
              );
      }),
    );
  }
}

// ═══════════════════════════════════════════════════════
// SHARED WIDGETS
// ═══════════════════════════════════════════════════════

class _SectionLabel extends StatelessWidget {
  final String label;

  const _SectionLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: const TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w600,
        color: AppColors.sectionLabel,
        letterSpacing: 0.8,
      ),
    );
  }
}

class _ThinDivider extends StatelessWidget {
  const _ThinDivider();

  @override
  Widget build(BuildContext context) {
    return const Divider(height: 1, color: AppColors.divider);
  }
}
