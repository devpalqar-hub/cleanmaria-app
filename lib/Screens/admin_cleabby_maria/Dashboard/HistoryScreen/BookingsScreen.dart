import 'package:cleanby_maria/Screens/admin_cleabby_maria/Dashboard/ClientScreen/CleaningDetails.dart';
import 'package:cleanby_maria/Screens/admin_cleabby_maria/Dashboard/ClientScreen/Views/StatusCard.dart';
import 'package:cleanby_maria/Screens/admin_cleabby_maria/Dashboard/ClientScreen/Service/BookingController.dart';
import 'package:cleanby_maria/Src/appButton.dart';
import 'package:get/get.dart';
import 'package:cleanby_maria/Src/appText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class BookingsaScreen extends StatefulWidget {
  const BookingsaScreen({super.key});

  @override
  _BookingsaScreenState createState() => _BookingsaScreenState();
}

class _BookingsaScreenState extends State<BookingsaScreen> {
  final BookingsController bookingsController = Get.put(BookingsController());
  DateTime? startDate;
  DateTime? endDate;

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      if (args.value is PickerDateRange) {
        startDate = args.value.startDate;
        endDate = args.value.endDate;
      }
    });
  }

  void _showDatePicker() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Select Booking Dates",
                style: GoogleFonts.poppins(
                    fontSize: 16.sp, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 10.h),
              SfDateRangePicker(
                selectionMode: DateRangePickerSelectionMode.range,
                onSelectionChanged: _onSelectionChanged,
                startRangeSelectionColor: Colors.blue,
                endRangeSelectionColor: Colors.blue,
                rangeSelectionColor: Colors.blue.withOpacity(0.2),
                todayHighlightColor: Colors.blue,
                backgroundColor: Colors.white,
                initialSelectedRange: PickerDateRange(
                  startDate ?? DateTime.now(),
                  endDate ?? DateTime.now().add(Duration(days: 7)),
                ),
              ),
              SizedBox(height: 10.h),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); 
                  setState(() {}); 
                },
                child: Text("Apply"),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back_ios),
        title: appText.primaryText(
          text: "Bookings",
          fontSize: 18.sp,
          fontWeight: FontWeight.w700,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 47.h,
              width: 358.w,
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: const Color(0xFFF7F6F5),
                borderRadius: BorderRadius.circular(14.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  appText.primaryText(
                    text: 'Bookings',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      elevation: 0,
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                    ),
                    onPressed: _showDatePicker, // Open the filter modal
                    icon: Icon(Icons.filter_list,
                        color: const Color(0xFF77838F), size: 18.sp),
                    label: Text('Filter',
                        style: GoogleFonts.poppins(
                            fontSize: 12.sp, color: Colors.black)),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15.h),
            StatusCard(status:"Completed", color: Color(0xFF03AE9D) , customerName: "Customer name", time: "10:00 AM - 11:00 AM", location: "Los Angeles, USA, 955032 - Washington DC."),
         
           
             
          ],
        ),
      ),
    );
  }
}
