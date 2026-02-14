import 'package:cleanby_maria/Screens/Admin/ClientScreen/Service/BookingDetailsContoller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class ClientBookingDetailsScreen extends StatelessWidget {
  String bookingID;
  ClientBookingDetailsScreen({super.key, required this.bookingID});
  bookingDetailsController ctrl = Get.put(bookingDetailsController());
  @override
  Widget build(BuildContext context) {
    // ctrl.fetchBookingDetails(bookingID);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Booking Details",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [],
      ),
      body: GetBuilder<bookingDetailsController>(builder: (__) {
        return SafeArea(
          child: (__.isLoading || __.bookingDetail == null)
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Text(
                                    __.bookingDetail!.customer?.name ?? "N/A",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 22),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    __.bookingDetail!.customer?.email ?? "N/A",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey,
                                        fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                            if (__.bookingDetail!.customer!.phone != null &&
                                __.bookingDetail!.customer!.phone!.isNotEmpty)
                              Center(
                                child: InkWell(
                                  onTap: () {
                                    launchUrl(Uri.parse(
                                        "tel:${__.bookingDetail!.customer!.phone!}"));
                                  },
                                  child: Container(
                                    width: 40,
                                    height: 40,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                        border:
                                            Border.all(color: Colors.black12)),
                                    child: const Icon(Icons.call,
                                        color: Color(0xff19A4C6)),
                                  ),
                                ),
                              ),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        _itemRow(
                            "Start Date",
                            DateFormat(
                              "yyyy-MM-dd",
                            ).format(DateTime.parse(__.bookingDetail!.date!!))),

                        _itemRow(
                            "Service Day",
                            DateFormat(
                              "EEEE",
                            )
                                .format(
                                    DateTime.parse(__.bookingDetail!.date!!))
                                .toUpperCase()),
                        _itemRow(
                            "Service Time",
                            DateFormat(
                              "hh:mm a",
                            ).format(DateTime.parse(__.bookingDetail!.date!!))),
                        _itemRow(
                            "Service Type", __.bookingDetail!.service!.name!!),

                        _itemRow("Recurring Type",
                            __.bookingDetail!.reccuingType ?? "One Time"),
                        _itemRow("No of Rooms",
                            (__.bookingDetail!.noOfRooms ?? 0).toString()),
                        _itemRow("No of Bathrooms",
                            (__.bookingDetail!.noOfBathRooms ?? 0).toString()),
                        _itemRow(
                            "Total Area",
                            (__.bookingDetail!.areaSize ?? 0).toString() +
                                " Sqft"),

                        _itemRow("Address",
                            "   ${__.bookingDetail!.bookingAddress!.address!.line1!} , ${__.bookingDetail!.bookingAddress!.address!.city!} - ${__.bookingDetail!.bookingAddress!.address!.state ?? ""}  ${__.bookingDetail!.bookingAddress!.address!.zip!}"),
                        _itemRow(
                            "Add Ons",
                            (__.bookingDetail!.isEco ?? false)
                                ? "Eco Cleaning"
                                : (__.bookingDetail!.materialProvided ?? false)
                                    ? "Material Provided"
                                    : "No Add ons",
                            color: Colors.green),
                        _itemRow(
                          "Service Price",
                          "\$ " + (__.bookingDetail!.price ?? "--:--"),
                        )

                        // DateFormat(
                        //   "hh mm ss",
                        // )
                        //     .format(
                        //         DateTime.parse(__.bookingDetail!.date!!))
                        //     .toUpperCase())
                      ],
                    ),
                  ),
                ),
        );
      }),
    );
  }
}

Widget _itemRow(String label, String value, {Color? color = null}) {
  return Container(
    padding: EdgeInsets.only(bottom: 24),
    child: Row(
      children: [
        Text(
          "$label",
          style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Color(0xff64748B),
              fontSize: 14),
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: Text(
            "$value",
            textAlign: TextAlign.right,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: (color != null) ? color : Colors.black,
            ),
          ),
        ),
      ],
    ),
  );
}
