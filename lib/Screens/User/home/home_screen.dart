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
                            Text("Have a good day,",
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
                            //  Icon(Icons.notifications_none),
                            //      SizedBox(width: 12),
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

                    /// 🔹 BOOK A CLEANING CARD
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFF18B1C5),
                            AppColors.teal,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Book a cleaning",
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Schedule your next professional home cleaning in seconds.",
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
                                "+ New Booking",
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
                          "Upcoming",
                          style: GoogleFonts.inter(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        // Text(
                        //   "See all",
                        //   style: GoogleFonts.inter(color: primaryGreen),
                        // ),
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
                              role: CardRole.user,
                            )
                            //  Container(
                            //   padding: const EdgeInsets.all(14),
                            //   decoration: BoxDecoration(
                            //     color: Colors.white,
                            //     borderRadius: BorderRadius.circular(16),
                            //   ),
                            //   child: Row(
                            //     children: [
                            //       Container(
                            //         padding: const EdgeInsets.all(10),
                            //         decoration: const BoxDecoration(
                            //           color: Color(0xFFE8F5F2),
                            //           shape: BoxShape.circle,
                            //         ),
                            //         child: const Icon(Icons.star, color: primaryGreen),
                            //       ),
                            //       const SizedBox(width: 12),
                            //       Expanded(
                            //         child: Column(
                            //           crossAxisAlignment: CrossAxisAlignment.start,
                            //           children: [
                            //             Text(
                            //               data.,
                            //               style: GoogleFonts.inter(
                            //                   fontWeight: FontWeight.bold),
                            //             ),
                            //             SizedBox(height: 4),
                            //             Text(
                            //               "Today, 2:00 PM",
                            //               style: GoogleFonts.inter(color: Colors.grey),
                            //             ),
                            //             SizedBox(height: 4),
                            //             Text(
                            //               "123 Main St, Apt 4B",
                            //               style: GoogleFonts.inter(color: Colors.grey),
                            //             ),
                            //           ],
                            //         ),
                            //       ),
                            //       Container(
                            //         padding: const EdgeInsets.symmetric(
                            //             horizontal: 12, vertical: 4),
                            //         decoration: BoxDecoration(
                            //           color: const Color(0xFFE8F5F2),
                            //           borderRadius: BorderRadius.circular(20),
                            //         ),
                            //         child: Text(
                            //           "Confirmed",
                            //           style: GoogleFonts.inter(
                            //             color: primaryGreen,
                            //             fontSize: 12,
                            //           ),
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            ),
                      ),

                    const SizedBox(height: 28),

                    /// 🔹 YOUR STATUS
                    // Text(
                    //   "Your Status",
                    //   style: GoogleFonts.inter(
                    //       fontSize: 16, fontWeight: FontWeight.bold),
                    // ),

                    // const SizedBox(height: 12),

                    // Row(
                    //   children: [
                    //     _statusCard(
                    //       value: "12",
                    //       label: "Total Hours Saved",
                    //       bgColor: Color(0xFFF3F5FF),
                    //       icon: Icons.access_time,
                    //       iconColor: Colors.blue,
                    //     ),
                    //     const SizedBox(width: 12),
                    //     _statusCard(
                    //       value: "4.9",
                    //       label: "Average Rating",
                    //       bgColor: Color(0xFFF1FBF6),
                    //       icon: Icons.star,
                    //       iconColor: primaryGreen,
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ),
            );
    });
  }
}
