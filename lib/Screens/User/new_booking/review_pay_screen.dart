import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReviewPayScreen extends StatelessWidget {
  const ReviewPayScreen({super.key});

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
          _progress("Step 4 of 4"),

          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              "Review & Pay",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),

          _card(
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                _RowItem(Icons.cleaning_services, "Standard Clean", "3.5 Hours • One-time"),
                SizedBox(height: 12),
                _RowItem(Icons.schedule, "Jan 29, 2024", "09:00 AM"),
                SizedBox(height: 12),
                _RowItem(Icons.home, "Home", "123 Main St, Apt 4B"),
              ],
            ),
          ),

          const SizedBox(height: 16),

          _card(
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                _PriceRow("Subtotal", "\$85.00"),
                _PriceRow("Taxes & Fees (10%)", "\$8.50"),
                Divider(height: 24),
                _PriceRow("Total", "\$93.50", bold: true),
              ],
            ),
          ),

          const SizedBox(height: 16),

          /// INFO BOX
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFE8F1FF),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                "By confirming, you agree to our cancellation policy. "
                    "You can cancel up to 24 hours before service for free.",
                style: TextStyle(fontSize: 12, color: Colors.blue),
              ),
            ),
          ),

          const Spacer(),

          /// CONFIRM BUTTON
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
                  // PAYMENT LOGIC LATER
                },
                child: const Text("Confirm & Pay"),
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
            value: 1.0,
            color: primaryGreen,
            backgroundColor: Colors.grey.shade300,
          ),
        ],
      ),
    );
  }

  Widget _card(Widget child) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(16),
        ),
        child: child,
      ),
    );
  }
}

/// ROW ITEM
class _RowItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _RowItem(this.icon, this.title, this.subtitle);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: ReviewPayScreen.primaryGreen),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 2),
              Text(subtitle, style: const TextStyle(color: Colors.grey)),
            ],
          ),
        ),
      ],
    );
  }
}

/// PRICE ROW
class _PriceRow extends StatelessWidget {
  final String label;
  final String value;
  final bool bold;

  const _PriceRow(this.label, this.value, {this.bold = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(
            value,
            style: TextStyle(fontWeight: bold ? FontWeight.bold : FontWeight.normal),
          ),
        ],
      ),
    );
  }
}
