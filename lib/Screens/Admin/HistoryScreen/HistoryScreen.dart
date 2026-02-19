// import 'package:cleanby_maria/Screens/Admin/HistoryScreen/ScheduleListView.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:cleanby_maria/Screens/Admin/HistoryScreen/Models/CalendarBookingScreen.dart';
// import 'package:cleanby_maria/Src/appText.dart';
// import 'package:google_fonts/google_fonts.dart';

// class BookingsaScreen extends StatefulWidget {
//   const BookingsaScreen({super.key});

//   @override
//   State<BookingsaScreen> createState() => _BookingsaScreenState();
// }

// class _BookingsaScreenState extends State<BookingsaScreen> {
//   final GlobalKey calendarKey = GlobalKey(); // Use plain GlobalKey

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         appBar: AppBar(
//           backgroundColor: Colors.white,
//           title: appText.primaryText(
//             text: "Cleaning History",
//             fontSize: 18.sp,
//             fontWeight: FontWeight.w600,
//           ),
//           actions: [
//             IconButton(
//               icon: const Icon(Icons.note_alt, color: Colors.black),
//               onPressed: () {
//                 Get.to(() => const ScheduleListScreen())?.then((_) async {
//                   // Refresh calendar when returning from ScheduleListScreen
//                   if (calendarKey.currentState != null) {
//                     // Call your loadSchedules method via the key
//                     dynamic state = calendarKey.currentState;
//                     if (state != null && state.loadSchedules != null) {
//                       await state.loadSchedules();
//                     }
//                   }
//                 });
//               },
//             ),
//           ],
//         ),
//         body: CalendarBookingScreen(
//           key: calendarKey, // attach the key here
//           isStaff: false,
//         ),
//       ),
//     );
//   }
// }