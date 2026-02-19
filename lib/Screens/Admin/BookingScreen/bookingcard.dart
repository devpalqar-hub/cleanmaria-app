// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';

// class BookingCard extends StatelessWidget {
//   final Map<String, dynamic> booking;
//   final VoidCallback onTap;
//   final VoidCallback onCall;

//   const BookingCard({
//     super.key,
//     required this.booking,
//     required this.onTap,
//     required this.onCall,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         margin: EdgeInsets.only(bottom: 12.h),
//         padding: EdgeInsets.all(14.w),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(14.r),
//           border: Border.all(color: Colors.teal.shade100),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.08),
//               blurRadius: 4,
//               offset: const Offset(0, 2),
//             )
//           ],
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [

//             /// NAME + CALL
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Expanded(
//                   child: Text(
//                     booking['name'] ?? '',
//                     style: GoogleFonts.poppins(
//                       fontSize: 15.sp,
//                       fontWeight: FontWeight.w600,
//                       color: const Color(0xff19A4C6),
//                     ),
//                   ),
//                 ),
//                 IconButton(
//                   icon: const Icon(Icons.call, color: Color(0xff19A4C6)),
//                   onPressed: onCall,
//                 )
//               ],
//             ),

//             SizedBox(height: 6.h),

//             /// TYPE
//             Text(
//               booking['recurringType'] ?? '',
//               style: GoogleFonts.poppins(
//                 fontSize: 13.sp,
//                 color: Colors.teal,
//               ),
//             ),

//             SizedBox(height: 6.h),

//             /// ADDRESS
//             Text(
//               "${booking['address']?['city']}, ${booking['address']?['zip']}",
//               style: GoogleFonts.poppins(fontSize: 12.sp),
//             ),

//             SizedBox(height: 10.h),

//             /// PRICE ROW (GRID FEEL)
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 _infoBox("Price", "\$${booking['price']}"),
//                 _infoBox("Payment", booking['paymentMethod'] ?? 'offline'),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _infoBox(String label, String value) {
//     return Expanded(
//       child: Container(
//         margin: EdgeInsets.symmetric(horizontal: 4.w),
//         padding: EdgeInsets.symmetric(vertical: 10.h),
//         decoration: BoxDecoration(
//           color: Colors.teal.shade50,
//           borderRadius: BorderRadius.circular(8.r),
//           border: Border.all(color: Colors.teal.shade100),
//         ),
//         child: Column(
//           children: [
//             Text(
//               label,
//               style: GoogleFonts.poppins(fontSize: 12.sp),
//             ),
//             SizedBox(height: 4.h),
//             Text(
//               value,
//               style: GoogleFonts.poppins(
//                 fontSize: 14.sp,
//                 fontWeight: FontWeight.w600,
//                 color: const Color(0xff19A4C6),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
