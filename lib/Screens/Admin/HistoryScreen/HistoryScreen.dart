import 'package:cleanby_maria/Screens/Admin/ClientScreen/BookingDetailsScreen.dart';
import 'package:cleanby_maria/Screens/Admin/ClientScreen/Views/StatusCard.dart';
import 'package:cleanby_maria/Screens/Admin/ClientScreen/Service/BookingController.dart';
import 'package:cleanby_maria/Screens/Admin/HistoryScreen/Controller/HistoryController.dart';
import 'package:get/get.dart';
import 'package:cleanby_maria/Src/appText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class BookingsaScreen extends StatefulWidget {
  const BookingsaScreen({super.key});

  @override
  _BookingsaScreenState createState() => _BookingsaScreenState();
}

class _BookingsaScreenState extends State<BookingsaScreen> {
  HistoryController hisCtrl = Get.put(HistoryController());
  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      if (args.value is PickerDateRange) {
        hisCtrl.startDate = args.value.startDate;
        hisCtrl.endDate = args.value.endDate;

        print("working");
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
                  hisCtrl.startDate ?? DateTime.now(),
                  hisCtrl.endDate ?? DateTime.now().add(Duration(days: 7)),
                ),
              ),
              SizedBox(height: 10.h),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  setState(() {});
                  hisCtrl.fetchShedules();
                },
                style: ElevatedButton.styleFrom(
                   backgroundColor: const Color(0xFF19A4C6), ),
                child: Text("Apply",style: TextStyle(color:  Colors.white),),
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
      // appBar: AppBar(
      //   leading: const Icon(Icons.arrow_back_ios),
      //   title: appText.primaryText(
      //     text: "Bookings",
      //     fontSize: 18.sp,
      //     fontWeight: FontWeight.w700,
      //   ),
      // ),
      body: GetBuilder<HistoryController>(builder: (_) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: SmartRefresher(
            controller: hisCtrl.refreshController,
            onRefresh: () {
              hisCtrl.refreshController.resetNoData();
              hisCtrl.fetchShedules();
            },
            onLoading: () {
              hisCtrl.fetchNextShedules();
            },
            enablePullUp: true,
            enablePullDown: true,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  Container(
                    height: 50.h,
                    width: 360.w,
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF7F6F5),
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        appText.primaryText(
                          text: 'Schedules',
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            elevation: 0,
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.w, vertical: 5.h),
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
                  for (var data in hisCtrl.history)
                    StatusCard(
                        status: data.status ?? "Unknown",
                        color: hisCtrl.getStatusColor(data.status!),
                        customerName: data.booking!.customer!.name!,
                        onTap: () {
                          Get.to(
                              () => BookingDetailsScreen(
                                    bookingId: data.booking!.id!,
                                    staff: data.staff!.name,
                                    status: data.status ?? "Unknown",
                                    scheduleId: data.id,
                                    date:
                                        "${DateFormat("MMM dd,yyyy | hh:mm a").format(DateTime.parse(data.startTime!))} - ${DateFormat("hh:mm a").format(DateTime.parse(data.endTime!))}",
                                  ),
                              transition: Transition.rightToLeft);
                        },
                        time:
                            "${DateFormat("MMM dd,yyyy | hh:mm a").format(DateTime.parse(data.startTime!))} - ${DateFormat("hh:mm a").format(DateTime.parse(data.endTime!))}",
                        location: "Cleaned By : ${data.staff!.name}"),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
