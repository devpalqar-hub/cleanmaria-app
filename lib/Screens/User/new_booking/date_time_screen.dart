import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'location_screen.dart';

class DateTimeScreen extends StatelessWidget {
  const DateTimeScreen({super.key});

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
          _progress("Step 2 of 4"),

          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              "Select date & time",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text("October 2024",
                style: TextStyle(color: Colors.grey)),
          ),

          const SizedBox(height: 12),

          /// DATE ROW
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                _DateChip("Thu", "29", selected: true),
                _DateChip("Fri", "30"),
                _DateChip("Sat", "31"),
                _DateChip("Sun", "1"),
              ],
            ),
          ),

          const SizedBox(height: 24),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text("Available slots",
                style: TextStyle(color: Colors.grey)),
          ),

          const SizedBox(height: 12),

          /// TIME SLOTS
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Wrap(
              spacing: 12,
              runSpacing: 12,
              children: const [
                _TimeChip("09:00 AM", selected: true),
                _TimeChip("11:00 AM"),
                _TimeChip("02:00 PM"),
                _TimeChip("04:00 PM"),
              ],
            ),
          ),

          const Spacer(),

          /// CONTINUE
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
                  Get.to(() =>  LocationScreen());
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
            value: 0.5,
            color: primaryGreen,
            backgroundColor: Colors.grey.shade300,
          ),
        ],
      ),
    );
  }
}

/// DATE CHIP
class _DateChip extends StatelessWidget {
  final String day;
  final String date;
  final bool selected;

  const _DateChip(this.day, this.date, {this.selected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 64,
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: selected ? const Color(0xFFE8F5F2) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: selected ? const Color(0xFF2F7F6F) : Colors.grey.shade300,
        ),
      ),
      child: Column(
        children: [
          Text(day, style: const TextStyle(color: Colors.grey)),
          const SizedBox(height: 4),
          Text(date, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

/// TIME CHIP
class _TimeChip extends StatelessWidget {
  final String text;
  final bool selected;

  const _TimeChip(this.text, {this.selected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      decoration: BoxDecoration(
        color: selected ? const Color(0xFFE8F5F2) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: selected ? const Color(0xFF2F7F6F) : Colors.grey.shade300,
        ),
      ),
      child: Text(text),
    );
  }
}
