import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'date_time_screen.dart';

class ServiceScreen extends StatelessWidget {
  ServiceScreen({super.key});

  final Color primaryGreen = const Color(0xFF2F7F6F);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
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
          _progress("Step 1 of 4"),

          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              "Choose a service",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),

          _serviceCard(
            title: "Standard Clean",
            desc: "Dusting, vacuuming,\nkitchen, bathroom & rooms",
            price: "\$85",
            selected: true,
          ),

          _serviceCard(
            title: "Deep Clean",
            desc: "Inside kitchen cabinets,\nappliances & detailed scrubbing",
            price: "\$140",
          ),

          _serviceCard(
            title: "Move In/Out",
            desc: "Empty home cleaning, heavy duty\nfor vacancy",
            price: "\$190",
          ),

          const Spacer(),

          _bottomButton("Continue", () {
            // ✅ FIXED (NO const)
            Get.to(() => DateTimeScreen());
          }),
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
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: 0.25,
            color: primaryGreen,
            backgroundColor: Colors.grey.shade300,
          ),
        ],
      ),
    );
  }

  Widget _serviceCard({
    required String title,
    required String desc,
    required String price,
    bool selected = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: selected ? primaryGreen : Colors.transparent,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 14)),
                  const SizedBox(height: 6),
                  Text(desc,
                      style:
                      const TextStyle(color: Colors.grey, fontSize: 12)),
                ],
              ),
            ),
            Text(price,
                style:
                const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          ],
        ),
      ),
    );
  }

  Widget _bottomButton(String text, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryGreen,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          onPressed: onTap,
          child: Text(text),
        ),
      ),
    );
  }
}
