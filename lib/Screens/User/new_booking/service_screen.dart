import 'package:cleanby_maria/Screens/Admin/ScheduleViewScreen/ScheduleDetailsScreen.dart';
import 'package:cleanby_maria/Screens/User/home/Models/UserProfileModel.dart';
import 'package:cleanby_maria/Screens/User/new_booking/Controllers/CreateBookingController.dart';
import 'package:cleanby_maria/Screens/User/new_booking/Models/UserServiceModel.dart';
import 'package:cleanby_maria/Screens/User/new_booking/PlanSelectionScreen.dart';
import 'package:cleanby_maria/Screens/User/new_booking/components/BookingUtils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

final Color primaryGreen = AppColors.teal;

class CreateBookingScreen extends StatelessWidget {
  bool isAdmin = false;
  UserProfileModel? user;
  CreateBookingScreen({super.key, this.isAdmin = false, this.user = null});

  @override
  Widget build(BuildContext context) {
    CreateBookingController ctrl =
        Get.put(CreateBookingController(isAdminUser: isAdmin, user: user));
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: SafeArea(
        child: bottomButton("Continue", () {
          // ✅ FIXED (NO const)
          ctrl.fetchPlans();
          Get.to(() => PlanSelectionScreen());
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
          "New Booking",
          style: GoogleFonts.inter(
              color: Colors.black, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: GetBuilder<CreateBookingController>(builder: (__) {
          if (__.isLoadingServices) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(color: primaryGreen),
                  SizedBox(height: 16),
                  Text(
                    "Loading services...",
                    style: GoogleFonts.inter(color: Colors.grey),
                  ),
                ],
              ),
            );
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              progress("Step 1 of 4"),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(16),
                        child: Text(
                          "Choose a service",
                          style: GoogleFonts.inter(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                      ),
                      for (var data in __.serviceList)
                        InkWell(
                            splashColor: Colors.transparent,
                            onTap: () {
                              __.selectedService = data;
                              __.update();
                            },
                            child: serviceCard(
                                service: data,
                                isSelected: __.selectedService == data)),

                      // Property Details Section
                      Padding(
                        padding: EdgeInsets.fromLTRB(16, 24, 16, 16),
                        child: Text(
                          "Property Details",
                          style: GoogleFonts.inter(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                      ),

                      // Number of Bedrooms
                      _sliderField(
                        label: "Number of Bedrooms",
                        value: __.numberOfBedrooms.toDouble(),
                        min: 1,
                        max: 10,
                        divisions: 9,
                        onChanged: (value) {
                          __.numberOfBedrooms = value.toInt();
                          __.update();
                        },
                      ),

                      // Number of Bathrooms
                      _counterField(
                        label: "Number of Bathrooms",
                        value: __.numberOfBathrooms,
                        onIncrement: () {
                          if (__.numberOfBathrooms < 10) {
                            __.numberOfBathrooms++;
                            __.update();
                          }
                        },
                        onDecrement: () {
                          if (__.numberOfBathrooms > 1) {
                            __.numberOfBathrooms--;
                            __.update();
                          }
                        },
                      ),

                      // Property Type
                      _propertyTypeSelector(
                        selectedType: __.propertyType,
                        onTypeSelected: (type) {
                          __.propertyType = type;
                          __.update();
                        },
                      ),

                      // Square Feet
                      _squareFeetSlider(
                        value: __.squareFeet,
                        onChanged: (value) {
                          __.squareFeet = value;
                          __.update();
                        },
                      ),

                      // Additional Options
                      Padding(
                        padding: EdgeInsets.fromLTRB(16, 24, 16, 16),
                        child: Text(
                          "Additional Options",
                          style: GoogleFonts.inter(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                      ),

                      // Eco Cleaning
                      _optionTile(
                        title: "Eco-Friendly Cleaning",
                        subtitle:
                            "Use environmentally friendly cleaning products",
                        value: __.ecoCleaning,
                        onChanged: (value) {
                          if (__.materialProvide) {
                            __.materialProvide = false;
                          }
                          __.ecoCleaning = value;
                          __.update();
                        },
                      ),

                      // Material Provide
                      _optionTile(
                        title: "Material Provide",
                        subtitle:
                            "We provide all cleaning materials and equipment",
                        value: __.materialProvide,
                        onChanged: (value) {
                          if (__.ecoCleaning) {
                            __.ecoCleaning = false;
                          }
                          __.materialProvide = value;
                          __.update();
                        },
                      ),

                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget serviceCard({
    required UserServiceModel service,
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
                  Text(service.name!,
                      style: GoogleFonts.inter(
                          fontWeight: FontWeight.w600, fontSize: 14)),
                  SizedBox(height: 6),
                  Text(service.description ?? "",
                      style: const TextStyle(color: Colors.grey, fontSize: 12)),
                ],
              ),
            ),
            Text(service.basePrice ?? "",
                style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600, fontSize: 14)),
          ],
        ),
      ),
    );
  }

  Widget _sliderField({
    required String label,
    required double value,
    required double min,
    required double max,
    required int divisions,
    required ValueChanged<double> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: primaryGreen.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  value.toInt().toString(),
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryGreen,
                  ),
                ),
              ),
            ],
          ),
          Slider(
            value: value,
            min: min,
            max: max,
            divisions: divisions,
            activeColor: primaryGreen,
            inactiveColor: Colors.grey.shade300,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  Widget _counterField({
    required String label,
    required int value,
    required VoidCallback onIncrement,
    required VoidCallback onDecrement,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(.02),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.withOpacity(.1)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            Row(
              children: [
                InkWell(
                  onTap: onDecrement,
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.remove, size: 20),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    value.toString(),
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                InkWell(
                  onTap: onIncrement,
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: primaryGreen,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.add, size: 20, color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _propertyTypeSelector({
    required String selectedType,
    required ValueChanged<String> onTypeSelected,
  }) {
    final propertyTypes = ['Apartment', 'Studio', 'House'];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Property Type",
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: propertyTypes.map((type) {
              final isSelected = selectedType == type;
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: InkWell(
                    onTap: () => onTypeSelected(type),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? primaryGreen
                            : Colors.grey.withOpacity(.02),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected
                              ? primaryGreen
                              : Colors.grey.withOpacity(.2),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          type,
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: isSelected ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _squareFeetSlider({
    required double value,
    required ValueChanged<double> onChanged,
  }) {
    String displayValue;
    if (value >= 6500) {
      displayValue = "6500+ sq ft";
    } else {
      displayValue = "${value.toInt()} sq ft";
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Size (Square Feet)",
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: primaryGreen.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  displayValue,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryGreen,
                  ),
                ),
              ),
            ],
          ),
          Slider(
            value: value.clamp(500, 6500),
            min: 500,
            max: 6500,
            divisions: 120,
            activeColor: primaryGreen,
            inactiveColor: Colors.grey.shade300,
            onChanged: onChanged,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "500",
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  "6500+",
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _optionTile({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(.02),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: value ? primaryGreen : Colors.grey.withOpacity(.1),
            width: value ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            Switch(
              value: value,
              activeColor: primaryGreen,
              onChanged: onChanged,
            ),
          ],
        ),
      ),
    );
  }
}
