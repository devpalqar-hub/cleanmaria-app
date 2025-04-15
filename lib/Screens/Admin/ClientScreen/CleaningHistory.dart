import 'package:cleanby_maria/Screens/Admin/ClientScreen/Service/BookingController.dart';
import 'package:cleanby_maria/Screens/Admin/ClientScreen/Views/StatusCard.dart';
import 'package:cleanby_maria/Src/appText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/utils.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class CleaningHistory extends StatefulWidget {
  String bookingId;
  CleaningHistory({super.key, required this.bookingId});

  @override
  State<CleaningHistory> createState() => _CleaningHistoryState();
}

class _CleaningHistoryState extends State<CleaningHistory> {
  BookingsController ctrl = Get.put(BookingsController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    ctrl.page = 1;
    ctrl.refreshCtrl.resetNoData();
    ctrl.history.clear();
    ctrl.fetchShedules(widget.bookingId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_outlined,
              color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: appText.primaryText(
            text: "Cleaning History",
            fontSize: 18.sp,
            fontWeight: FontWeight.w700),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20.h,
          ),
          // Container(
          //   width: 345.w,
          //   height: 50.h,
          //   margin: EdgeInsets.symmetric(horizontal: 20.w),
          //   decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(10.w),
          //       color: Colors.grey.shade200),
          //   child: Padding(
          //     padding: const EdgeInsets.all(10.0),
          //     child: Row(
          //       children: [
          //         Icon(Icons.search),
          //         SizedBox(
          //           width: 15.w,
          //         ),
          //         appText.primaryText(text: "Search for booking"),
          //       ],
          //     ),
          //   ),
          // ),
          // SizedBox(
          //   height: 20.h,
          // ),
          Expanded(
            child: GetBuilder<BookingsController>(builder: (_) {
              return SmartRefresher(
                controller: ctrl.refreshCtrl,
                enablePullUp: true,
                enablePullDown: false,
                onLoading: () {
                  ctrl.fetchShedules(widget.bookingId);
                },
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      for (var data in ctrl.history)
                        StatusCard(
                            status: data.status ?? "Unknown",
                            color: ctrl.getStatusColor(data.status!),
                            customerName: data.booking!.customer!.name!,
                            time:
                                "${DateFormat("MMM dd,yyyy | hh:mm a").format(DateTime.parse(data.startTime!))} - ${DateFormat("hh:mm a").format(DateTime.parse(data.endTime!))}",
                            location: "Cleaned By : ${data.staff!.name}"),
                      SizedBox(height: 10.h),
                    ],
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
