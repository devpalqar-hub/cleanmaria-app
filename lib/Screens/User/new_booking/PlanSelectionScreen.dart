import 'package:cleanby_maria/Screens/User/new_booking/Controllers/CreateBookingController.dart';
import 'package:cleanby_maria/Screens/User/new_booking/Models/UserPlanModel.dart';
import 'package:cleanby_maria/Screens/User/new_booking/components/BookingUtils.dart';
import 'package:cleanby_maria/Screens/User/new_booking/location_screen.dart';
import 'package:cleanby_maria/Screens/User/new_booking/service_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:google_fonts/google_fonts.dart';

class PlanSelectionScreen extends StatelessWidget {
  const PlanSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: SafeArea(
        child: bottomButton("Continue", () {
          // ✅ FIXED (NO const)
          Get.to(() => LocationScreen());
        }),
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: Text(
          "Plan Selection",
          style: GoogleFonts.inter(
              color: Colors.black, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: SafeArea(child: GetBuilder<CreateBookingController>(builder: (__) {
        if (__.isLoadingPlans) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(color: primaryGreen),
                SizedBox(height: 16),
                Text(
                  "Calculating prices...",
                  style: GoogleFonts.inter(color: Colors.grey),
                ),
              ],
            ),
          );
        }
        return Column(
          children: [
            progress("Step 2 of 4"),
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  for (var data in __.planList)
                    InkWell(
                      splashColor: Colors.transparent,
                      onTap: () {
                        __.selectedPlan = data;
                        __.update();
                      },
                      child: serviceCard(
                          service: data, isSelected: data == __.selectedPlan),
                    )
                ],
              ),
            ))
          ],
        );
      })),
    );
  }
}

Widget serviceCard({
  required UserPlanModel service,
  required bool isSelected,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(.02),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isSelected ? primaryGreen : Colors.grey.withOpacity(.03),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(service.title!,
                    style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600, fontSize: 14)),
                SizedBox(height: 6),
                Text(service.description ?? "",
                    style: const TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          ),
          Text(service.finalPrice.toString(),
              style:
                  GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 14)),
        ],
      ),
    ),
  );
}
