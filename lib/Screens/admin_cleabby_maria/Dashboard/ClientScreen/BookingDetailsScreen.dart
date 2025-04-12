//import 'package:cleanby_maria/Screens/admin_cleabby_maria/Dashboard/ClientScreen/CleaningHistory.dart';
import 'package:cleanby_maria/Screens/admin_cleabby_maria/Dashboard/ClientScreen/CleaningHistory.dart';
import 'package:cleanby_maria/Src/appButton.dart';
import 'package:cleanby_maria/Src/appText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class BookingDetailsScreen extends StatelessWidget {
  const BookingDetailsScreen({super.key});

  Widget _infoText({required String title, required String value}) {
    return Column(
     crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        appText.primaryText(
          text: title,
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
        appText.primaryText(
          text: value,
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          color: const Color(0xFF757D7F),
        ),
        SizedBox(height: 10.h),
      ],
    );
  }
  void _showCancelDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Cancel Subscription"),
        content: Text("Are you sure you want to cancel?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), // Close dialog
            child: Text("No", style: TextStyle(color: Colors.black)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Subscription Cancelled")),
              );
            },
            child: Text("Yes", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:AppBar(
         leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_outlined, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
        title: appText.primaryText(text: "Booking Details",fontSize: 18.sp,fontWeight: FontWeight.w700 ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 15.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: _infoText(title: "Name", value: "Jhane Doe"),
                ),
                Image.asset(
                  'assets/call.png',
                  width: 30.w,
                  height: 30.h,
                ),
              ],
            ),
            _infoText(title: "Contact Number", value: "+91 237384855555"),
            _infoText(title: "Email", value: "johndeb@gmail.com"),
            _infoText(
              title: "Address",
              value: "House name, House number, Street name\nCity name, and all the address details",
            ),
            _infoText(
              title: "Booking Date",
              value: "WEEK 1 | MONDAY | 10:00 - 13:00\nWEEK 3 | FRIDAY | 10:00 - 13:00",
            ),
             Row(
               children:[ Expanded(
                    child: _infoText(title: "Service Cost", value: "Estimated Cost :250"),
                  ),
                Container(
                  width: 65.w,
                  height: 19.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: Color(0xFF19A4C6),
                  ),
                  child: Center(
                    child: appText.primaryText(text: "NOT PAID",
                    fontSize:8.sp,fontWeight:FontWeight.w500,color:Colors.white ),
                  ),
                ),
               ],
             ),
              _infoText(
              title: "Total Sq",
              value: "Estimated sqft : 2500",
            ), 
             _infoText(
              title: "Type of cleaning",
              value: "Regular",
            ),
            _infoText(
              title: "Type of property",
              value: "House",
            ),
            Row(children: [appText.primaryText(text: "Rooms: 5"),SizedBox(width:69.w),appText.primaryText(text:"Bathrooms: 5")],),
            SizedBox(height:10.h ,),
             Row(
               children:[ Expanded(
                    child: _infoText(title: "Service plan", value: "Plan name"),
                  ),
                Container(
                  width: 65.w,
                  height: 19.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: Color(0xFF1C9F0B),
                  ),
                  child: Center(
                    child: appText.primaryText(text: "ECO SERVICE",
                    fontSize:8.sp,fontWeight:FontWeight.w500,color:Colors.white ),
                  ),
                ),
               ],
             ),
             appText.primaryText(text: "Cleaning items given",color: Color(0xFF1C9F0B),fontSize:1.sp, ),
             SizedBox(height:40.h),
               GestureDetector(onTap: () {
               Navigator.push(context,MaterialPageRoute(builder: (context) => CleaningHistory()),);
 
              },
                child: Center(child: appText.primaryText(text: "View Cleaning History",color: Colors.black,fontSize:12.sp,fontWeight: FontWeight.w600 ))),
                SizedBox(height:10.h),
               GestureDetector(
                onTap: () => _showCancelDialog(context),
                child: Center(child: appText.primaryText(text: "Cancelation of Subscription",color: Colors.red,fontSize:12.sp,fontWeight: FontWeight.w600 ))),
          ],
          
             
        ),
      ),
    );
  }
}
