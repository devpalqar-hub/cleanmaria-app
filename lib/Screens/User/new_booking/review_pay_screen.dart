import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:cleanby_maria/Screens/User/new_booking/Controllers/CreateBookingController.dart';
import 'package:cleanby_maria/Screens/User/new_booking/components/BookingUtils.dart';

class ReviewPayScreen extends StatefulWidget {
  const ReviewPayScreen({super.key});

  @override
  State<ReviewPayScreen> createState() => _ReviewPayScreenState();
}

class _ReviewPayScreenState extends State<ReviewPayScreen> {
  static const Color primaryGreen = Color(0xFF2F7F6F);
  final CreateBookingController ctrl = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar:
          GetBuilder<CreateBookingController>(builder: (_ctrl) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  textStyle: GoogleFonts.inter(color: Colors.white),
                  backgroundColor: primaryGreen,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: _ctrl.isCreatingBooking
                    ? null
                    : () {
                        _ctrl.createBoooking();
                      },
                child: _ctrl.isCreatingBooking
                    ? LoadingAnimationWidget.staggeredDotsWave(
                        color: Colors.white, size: 24)
                    : Text(
                        "Confirm & Pay",
                        style: GoogleFonts.inter(
                            color: Colors.white, fontWeight: FontWeight.w600),
                      ),
              ),
            ),
          ),
        );
      }),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
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
        child: GetBuilder<CreateBookingController>(builder: (_) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              progress("Step 4 of 4"),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(16),
                        child: Text(
                          "Review & Pay",
                          style: GoogleFonts.inter(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                      ),

                      // Service Summary
                      _sectionCard(
                        title: "Service Details",
                        children: [
                          _infoRow(
                            Icons.cleaning_services,
                            ctrl.selectedService?.name ?? "Service",
                            "${ctrl.selectedPlan?.title ?? 'Plan'} • ${ctrl.propertyType}",
                          ),
                          SizedBox(height: 12),
                          _infoRow(
                            Icons.home_outlined,
                            "Property Details",
                            "${ctrl.numberOfBedrooms} BR • ${ctrl.numberOfBathrooms} BA • ${ctrl.squareFeet.toInt()} sq ft",
                          ),
                          if (ctrl.ecoCleaning || ctrl.materialProvide) ...[
                            SizedBox(height: 12),
                            _infoRow(
                              Icons.eco_outlined,
                              "Additional Options",
                              [
                                if (ctrl.ecoCleaning) "Eco Cleaning",
                                if (ctrl.materialProvide) "Materials Provided"
                              ].join(" • "),
                            ),
                          ],
                        ],
                      ),

                      SizedBox(height: 16),

                      // Date & Time
                      _sectionCard(
                        title: "Schedule",
                        children: [
                          _infoRow(
                            Icons.schedule,
                            "Date & Time",
                            ctrl.selectedDate != null
                                ? "${DateFormat('EEEE, MMMM d, yyyy').format(ctrl.selectedDate!)} at ${ctrl.selectedTimeSlot?.time ?? 'Not selected'}"
                                : "${ctrl.selectedTimeSlot?.time ?? 'Not selected'}",
                          ),
                        ],
                      ),

                      SizedBox(height: 16),

                      // Location
                      _sectionCard(
                        title: "Location",
                        children: [
                          _infoRow(
                            Icons.location_on_outlined,
                            ctrl.address.isEmpty ? "Address" : ctrl.address,
                            "${ctrl.city}, ${ctrl.zipcode}",
                          ),
                          if (ctrl.specialInstructions.isNotEmpty) ...[
                            SizedBox(height: 12),
                            _infoRow(
                              Icons.info_outline,
                              "Special Instructions",
                              ctrl.specialInstructions,
                            ),
                          ],
                        ],
                      ),

                      SizedBox(height: 16),

                      // Payment Method
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          "Payment Method",
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(height: 12),

                      _paymentOption(
                        icon: Icons.credit_card,
                        title: "Card Payment",
                        subtitle: "Pay securely with credit/debit card",
                        value: "card",
                      ),

                      _paymentOption(
                        icon: Icons.money,
                        title: "Cash/Vellom",
                        subtitle: "Pay after service completion",
                        value: "cash",
                      ),

                      SizedBox(height: 16),

                      // Price Summary
                      _card(
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Price Summary",
                                  style: GoogleFonts.inter(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                if (ctrl.isAdmin)
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: primaryGreen.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text(
                                      "ADMIN",
                                      style: GoogleFonts.inter(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        color: primaryGreen,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            SizedBox(height: 12),
                            if (ctrl.isAdmin) ...[
                              Text(
                                "Base Price",
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                "\$${ctrl.selectedPlan?.finalPrice?.toStringAsFixed(2) ?? '0.00'}",
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                              SizedBox(height: 12),
                              Text(
                                "Custom Price (editable)*",
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 8),
                              TextFormField(
                                initialValue:
                                    ctrl.customPrice?.toStringAsFixed(2) ??
                                        ctrl.selectedPlan?.finalPrice
                                            ?.toStringAsFixed(2) ??
                                        '0.00',
                                keyboardType: TextInputType.numberWithOptions(
                                    decimal: true),
                                decoration: InputDecoration(
                                  prefixText: '\$ ',
                                  hintText: 'Enter custom price',
                                  hintStyle: GoogleFonts.inter(
                                    color: Colors.grey,
                                    fontSize: 14,
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide:
                                        BorderSide(color: Colors.grey.shade300),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                        color: primaryGreen, width: 2),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 12),
                                ),
                                onChanged: (value) {
                                  ctrl.customPrice = double.tryParse(value);
                                  ctrl.update();
                                },
                              ),
                              SizedBox(height: 12),
                              Divider(height: 24),
                            ],
                            _priceRow(
                              "Total",
                              "\$${(ctrl.customPrice ?? ctrl.selectedPlan?.finalPrice ?? 0).toStringAsFixed(2)}",
                              bold: true,
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 16),

                      // Info Box
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: primaryGreen.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: primaryGreen.withOpacity(0.3),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(Icons.info_outline,
                                  color: primaryGreen, size: 20),
                              SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  "By confirming, you agree to our cancellation policy. You can cancel up to 24 hours before service for free.",
                                  style: GoogleFonts.inter(
                                    fontSize: 12,
                                    color: primaryGreen,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 16),
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

  Widget _sectionCard({
    required String title,
    required List<Widget> children,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: primaryGreen,
              ),
            ),
            SizedBox(height: 12),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _infoRow(IconData icon, String title, String subtitle) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: Colors.grey.shade600, size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: GoogleFonts.inter(
                  color: Colors.grey.shade600,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _paymentOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required String value,
  }) {
    return GetBuilder<CreateBookingController>(builder: (_) {
      final isSelected = _.paymentMethod == value;
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: InkWell(
          onTap: () {
            _.paymentMethod = value;
            _.update();
          },
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isSelected
                  ? primaryGreen.withOpacity(0.05)
                  : Colors.grey.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected ? primaryGreen : Colors.grey.shade300,
                width: isSelected ? 2 : 1,
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? primaryGreen.withOpacity(0.1)
                        : Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    icon,
                    color: isSelected ? primaryGreen : Colors.grey.shade700,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: isSelected ? primaryGreen : Colors.black,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: GoogleFonts.inter(
                          color: Colors.grey.shade600,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                if (isSelected)
                  Icon(
                    Icons.check_circle,
                    color: primaryGreen,
                    size: 24,
                  )
                else
                  Icon(
                    Icons.circle_outlined,
                    color: Colors.grey.shade400,
                    size: 24,
                  ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _card(Widget child) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: child,
      ),
    );
  }

  Widget _priceRow(String label, String value, {bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: bold ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: bold ? FontWeight.w600 : FontWeight.w400,
              color: bold ? primaryGreen : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
