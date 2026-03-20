import 'package:cleanby_maria/Screens/User/new_booking/service_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cleanby_maria/Screens/User/new_booking/Controllers/CreateBookingController.dart';
import 'package:cleanby_maria/Screens/User/new_booking/components/BookingUtils.dart';
import 'date_time_screen.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  final _formKey = GlobalKey<FormState>();
  final CreateBookingController ctrl = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: SafeArea(
        child: bottomButton("Continue".tr, () {
          // ✅ Added .tr
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();
            Get.to(() => DateTimeScreen());
          }
        }),
      ),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: Text(
          "New Booking".tr, // ✅ Added .tr
          style: GoogleFonts.inter(
              color: Colors.black, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              progress("Step 3 of 4".tr), // ✅ Added .tr
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (ctrl.isAdmin) ...[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            "Customer Information".tr, // ✅ Added .tr
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryGreen,
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                        _buildTextField(
                          label: "First Name*".tr, // ✅ Added .tr
                          hint: "Enter customer's first name".tr, // ✅ Added .tr
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter customer\'s first name'
                                  .tr; // ✅ Added .tr
                            }
                            return null;
                          },
                          onSaved: (value) =>
                              ctrl.customerFirstName = value ?? '',
                        ),
                        _buildTextField(
                          label: "Last Name*".tr, // ✅ Added .tr
                          hint: "Enter customer's last name".tr, // ✅ Added .tr
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter customer\'s last name'
                                  .tr; // ✅ Added .tr
                            }
                            return null;
                          },
                          onSaved: (value) =>
                              ctrl.customerLastName = value ?? '',
                        ),
                        _buildTextField(
                          label: "Email*".tr, // ✅ Added .tr
                          hint: "customer@example.com".tr, // ✅ Added .tr
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter customer\'s email'
                                  .tr; // ✅ Added .tr
                            }
                            if (!GetUtils.isEmail(value)) {
                              return 'Please enter a valid email'
                                  .tr; // ✅ Added .tr
                            }
                            return null;
                          },
                          onSaved: (value) => ctrl.customerEmail = value ?? '',
                        ),
                        _buildTextField(
                          label: "Phone*".tr, // ✅ Added .tr
                          hint:
                              "Enter customer's phone number".tr, // ✅ Added .tr
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter customer\'s phone number'
                                  .tr; // ✅ Added .tr
                            }
                            if (value.length < 10) {
                              return 'Please enter a valid phone number'
                                  .tr; // ✅ Added .tr
                            }
                            return null;
                          },
                          onSaved: (value) => ctrl.customerPhone = value ?? '',
                        ),
                        SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Divider(),
                        ),
                        SizedBox(height: 8),
                      ],
                      _buildTextField(
                        label: "Address*".tr, // ✅ Added .tr
                        hint: "123 Main St, Apt 4B".tr, // ✅ Added .tr
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your address'
                                .tr; // ✅ Added .tr
                          }
                          return null;
                        },
                        onSaved: (value) => ctrl.address = value ?? '',
                      ),
                      _buildTextField(
                        label: "City*".tr, // ✅ Added .tr
                        hint: "Enter your city".tr, // ✅ Added .tr
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your city'.tr; // ✅ Added .tr
                          }
                          return null;
                        },
                        onSaved: (value) => ctrl.city = value ?? '',
                      ),
                      _buildTextField(
                        label: "Zipcode*".tr, // ✅ Added .tr
                        hint:
                            "12345", // Intentionally left un-translated (it's just a number)
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your zipcode'
                                .tr; // ✅ Added .tr
                          }
                          if (value.length < 5) {
                            return 'Please enter a valid zipcode'
                                .tr; // ✅ Added .tr
                          }
                          return null;
                        },
                        onSaved: (value) => ctrl.zipcode = value ?? '',
                      ),
                      _buildTextField(
                        label: "Special Instructions".tr, // ✅ Added .tr
                        hint: "Gate code, parking info, pet details, etc."
                            .tr, // ✅ Added .tr
                        maxLines: 4,
                        onSaved: (value) =>
                            ctrl.specialInstructions = value ?? '',
                      ),
                      SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required String hint,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
    void Function(String?)? onSaved,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label, // Already has .tr passed into it
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8),
          TextFormField(
            maxLines: maxLines,
            keyboardType: keyboardType,
            validator: validator,
            onSaved: onSaved,
            decoration: InputDecoration(
              hintText: hint, // Already has .tr passed into it
              hintStyle: GoogleFonts.inter(
                color: Colors.grey,
                fontSize: 14,
              ),
              filled: true,
              fillColor: Colors.grey.shade100,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.red.shade300, width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: primaryGreen, width: 2),
              ),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            ),
          ),
        ],
      ),
    );
  }
}
