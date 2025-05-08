import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ClientDetailsScreen extends StatelessWidget {
  const ClientDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('client details', style: TextStyle(fontWeight: FontWeight.w600)),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0.5,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildTextField(label: "First Name", hint: "Enter First Name"),
              _buildTextField(label: "Last Name", hint: "Enter Last Name"),
              _buildTextField(label: "Email", hint: "Enter Email"),
              _buildTextField(label: "Phone", hint: "Enter Phone"),
              _buildTextField(label: "Address", hint: "Enter Address"),
              _buildTextField(label: "Address 2", hint: "Enter Address Second Line"),
              _buildTextField(label: "City", hint: "Enter City"),
              _buildTextField(label: "Zip Code", hint: "Enter Zip Code"),
              _buildTextField(label: "Landmark", hint: "Enter Landmark"),
              _buildTextField(label: "Payment Method", hint: "Enter Payment Method"),
              SizedBox(height: 16.h),
              _buildServiceDateCard(),
              SizedBox(height: 20.h),
              SizedBox(
                width: double.infinity,
                height: 50.h,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal.shade600,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {
                    // Handle submission
                  },
                  child: const Text("Book", style: TextStyle(fontSize: 16, color: Colors.white)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({required String label, required String hint}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
        SizedBox(height: 6.h),
        TextField(
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey.shade500),
            filled: true,
            fillColor: Colors.grey.shade100,
            contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
          ),
        ),
        SizedBox(height: 12.h),
      ],
    );
  }

  Widget _buildServiceDateCard() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          const Icon(Icons.calendar_today, size: 24, color: Colors.teal),
          SizedBox(width: 12.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Service Date", style: TextStyle(fontWeight: FontWeight.w600)),
              Text("Select Date", style: TextStyle(color: Colors.grey.shade600)),
            ],
          )
        ],
      ),
    );
  }
}
