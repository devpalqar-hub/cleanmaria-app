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

  final HomeController hctlr = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Obx(() {
        final history = hctlr.history;
        
        if (history == null) {
          return const Center(child: CircularProgressIndicator());
        } else if (history.isEmpty) {
          return const Center(child: Text("No cancellations found"));
        }

        return SingleChildScrollView(
          child: Column(
            children: [
              for (var data in history)
                InkWell(
                  onTap: () {
                    if (data.id != null) {
                      Get.to(() => BookingDetailsScreen(bookingId: data.id!));
                    } else {
                      Get.snackbar("Error", "Booking ID is missing");
                    }
                  },
                  child: BStatusCard(booking: data),
                ),
            ],
          ),
        );
      }),
    );
  }
}
