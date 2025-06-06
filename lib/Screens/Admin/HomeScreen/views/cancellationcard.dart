import 'package:cleanby_maria/Screens/Admin/ClientScreen/BookingDetailsScreen.dart';
import 'package:cleanby_maria/Screens/Admin/ClientScreen/Views/BStatusCard.dart';
import 'package:cleanby_maria/Screens/Admin/ClientScreen/Views/StatusCard.dart';
import 'package:cleanby_maria/Screens/Admin/HomeScreen/Services/homeController.dart';
import 'package:cleanby_maria/Src/appText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';

class Cancellationcard extends StatelessWidget {
  Cancellationcard({super.key});

  HomeController hctlr = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: SingleChildScrollView(
        child: Column(
          children: [
            for (var data in hctlr.history)
              InkWell(
                onTap: () {
                  Get.to(() => BookingDetailsScreen(bookingId: data.id!));
                },
                child: BStatusCard(
                  booking: data,
                ),
              )
          ],
        ),
      ),
    );
  }
}
