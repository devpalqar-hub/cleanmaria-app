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
  static const Color primaryGreen = Color(0xFF2F7F6F);
  final _formKey = GlobalKey<FormState>();
  final CreateBookingController ctrl = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: SafeArea(
        child: bottomButton("Continue", () {
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
          "New Booking",
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
              progress("Step 3 of 4"),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (ctrl.isAdmin) ...[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            "Customer Information",
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryGreen,
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                        _buildTextField(
                          label: "First Name*",
                          hint: "Enter customer's first name",
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter customer\'s first name';
                            }
                            return null;
                          },
                          onSaved: (value) =>
                              ctrl.customerFirstName = value ?? '',
                        ),
                        _buildTextField(
                          label: "Last Name*",
                          hint: "Enter customer's last name",
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter customer\'s last name';
                            }
                            return null;
                          },
                          onSaved: (value) =>
                              ctrl.customerLastName = value ?? '',
                        ),
                        _buildTextField(
                          label: "Email*",
                          hint: "customer@example.com",
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter customer\'s email';
                            }
                            if (!GetUtils.isEmail(value)) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                          onSaved: (value) => ctrl.customerEmail = value ?? '',
                        ),
                        _buildTextField(
                          label: "Phone*",
                          hint: "Enter customer's phone number",
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter customer\'s phone number';
                            }
                            if (value.length < 10) {
                              return 'Please enter a valid phone number';
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
                        label: "Address*",
                        hint: "123 Main St, Apt 4B",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your address';
                          }
                          return null;
                        },
                        onSaved: (value) => ctrl.address = value ?? '',
                      ),
                      _buildTextField(
                        label: "City*",
                        hint: "Enter your city",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your city';
                          }
                          return null;
                        },
                        onSaved: (value) => ctrl.city = value ?? '',
                      ),
                      _buildTextField(
                        label: "Zipcode*",
                        hint: "12345",
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your zipcode';
                          }
                          if (value.length < 5) {
                            return 'Please enter a valid zipcode';
                          }
                          return null;
                        },
                        onSaved: (value) => ctrl.zipcode = value ?? '',
                      ),
                      _buildTextField(
                        label: "Special Instructions",
                        hint: "Gate code, parking info, pet details, etc.",
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
            label,
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
              hintText: hint,
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
