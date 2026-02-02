import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'review_pay_screen.dart';


class LocationScreen extends StatelessWidget {
  const LocationScreen({super.key});

  static const Color primaryGreen = Color(0xFF2F7F6F);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          "New Booking",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _progress("Step 3 of 4"),

          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              "Location details",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),

          _input("Street Address", "123 Main St, Apt 4B"),
          _input("Apartment / Suite", "Apt 4B"),
          _input(
            "Entrance Instructions",
            "Gate code, key location, etc.",
            maxLines: 3,
          ),

          const Spacer(),

          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryGreen,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  Get.to(() =>  ReviewPayScreen());
                },

                child: const Text("Continue"),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _progress(String text) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(text, style: const TextStyle(color: Colors.grey)),
          const SizedBox(height: 6),
          LinearProgressIndicator(
            value: 0.75,
            color: primaryGreen,
            backgroundColor: Colors.grey.shade300,
          ),
        ],
      ),
    );
  }

  Widget _input(String label, String hint, {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: TextField(
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          filled: true,
          fillColor: Colors.grey.shade100,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
