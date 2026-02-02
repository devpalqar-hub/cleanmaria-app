import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookingDetailsScreen extends StatelessWidget {
  const BookingDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text("Booking #1"),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      backgroundColor: const Color(0xFFF8F8F8),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _statusCard(),
            SizedBox(height: 16.h),
            _infoCard(),
            SizedBox(height: 16.h),
            _professionalCard(),
            SizedBox(height: 16.h),
            _paymentCard(),
            SizedBox(height: 24.h),
            _actionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _statusCard() {
    return _card(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Chip(
            label: Text("Upcoming", style: TextStyle(color: Colors.green)),
            backgroundColor: Color(0xFFE8F5E9),
          ),
          SizedBox(height: 10),
          Text("Standard Cleaning",
              style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 6),
          Text(
            "Today, October 24\n2:00 PM - 5:00 PM",
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _infoCard() {
    return _card(
      const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Location", style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 6),
          Text("123 Main St, Apt 4B",
              style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _professionalCard() {
    return _card(
      Row(
        children: [
          const CircleAvatar(radius: 22),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Assigned Professional",
                    style: TextStyle(color: Colors.grey)),
                SizedBox(height: 4),
                Text("Sarah Jenkins",
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Icon(Icons.chat_bubble_outline, color: Colors.green.shade600),
        ],
      ),
    );
  }

  Widget _paymentCard() {
    return _card(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text("Payment Summary",
              style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          _PriceRow("Base price", "\$75.00"),
          _PriceRow("Service fee", "\$5.00"),
          _PriceRow("Tax", "\$5.00"),
          Divider(),
          _PriceRow("Total", "\$85.00", bold: true),
        ],
      ),
    );
  }

  Widget _actionButtons() {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () {},
            child: const Text("Reschedule"),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade100,
              foregroundColor: Colors.red,
              elevation: 0,
            ),
            child: const Text("Cancel Booking"),
          ),
        ),
      ],
    );
  }

  Widget _card(Widget child) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: child,
    );
  }
}

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
          Text(value,
              style:
              TextStyle(fontWeight: bold ? FontWeight.bold : null)),
        ],
      ),
    );
  }
}
