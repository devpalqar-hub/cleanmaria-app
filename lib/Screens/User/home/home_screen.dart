import 'package:cleanby_maria/Screens/Admin/ScheduleViewScreen/ScheduleDetailsScreen.dart';
import 'package:cleanby_maria/Screens/Admin/ScheduleViewScreen/Views/ScheduleLogCard.dart';
import 'package:cleanby_maria/Screens/Chats/Controller/ChatController.dart';
import 'package:cleanby_maria/Screens/User/home/Controllers/HomeController.dart';
import 'package:cleanby_maria/Screens/staff/Views/profileSettingsCard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

// 👉 ADD THESE IMPORTS
import '../new_booking/service_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  Color primaryGreen = AppColors.teal;
  UserHomeController ctrl = Get.put(UserHomeController());
  @override
  Widget build(BuildContext context) {
    ctrl.fetchNextUpCommingSchedules();
    return GetBuilder<UserHomeController>(builder: (__) {
      return (__.user == null)
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// 🔹 HEADER
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Have a good day,".tr, // Added .tr
                                style: GoogleFonts.inter(color: Colors.grey)),
                            SizedBox(height: 4),
                            Text(
                              "${ctrl.user!.name}",
                              style: GoogleFonts.inter(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                showSettingsBottomSheet(context,
                                    ctrl.user!.name!, ctrl.user!.email!);
                              },
                              child: CircleAvatar(
                                radius: 18,
                                child: Text(ctrl.user!.name![0]),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFF18B1C5),
                            AppColors
                                .teal, // Assuming AppColors is defined globally or in another import
                          ],
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Book a cleaning".tr, // Added .tr
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Schedule your next professional home cleaning in seconds."
                                .tr, // Added .tr
                            style: GoogleFonts.inter(color: Colors.white70),
                          ),
                          const SizedBox(height: 16),

                          /// ✅ CLICKABLE NEW BOOKING BUTTON
                          GestureDetector(
                            onTap: () {
                              Get.to(() => CreateBookingScreen(
                                    user: __.user,
                                  ));
                            },
                            child: Container(
                              height: 46,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                "+ New Booking".tr, // Added .tr
                                style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 28),

                    /// 🔹 UPCOMING HEADER
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Upcoming".tr, // Added .tr
                          style: GoogleFonts.inter(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    /// ✅ CLICKABLE UPCOMING CARD
                    for (var data in ctrl.upcommingSchedules)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: GestureDetector(
                            onTap: () {
                              Get.to(() => ScheduleDetailsScreen(
                                    bookingID: data.booking!.id!,
                                    isUser: true,
                                    schedule: data,
                                  ));
                            },
                            child: Schedulelogcard(
                              booking: data,
                              role: CardRole
                                  .user, // Assuming CardRole is defined in ScheduleLogCard.dart
                            )),
                      ),

                    const SizedBox(height: 28),
                  ],
                ),
              ),
            );
    });
  }
}
