import 'dart:ui';

import 'package:cleanby_maria/Screens/User/new_booking/Models/UserPlanModel.dart';
import 'package:cleanby_maria/Screens/User/new_booking/service_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget bottomButton(String text, VoidCallback onTap) {
  return Padding(
    padding: const EdgeInsets.all(16),
    child: SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          textStyle: GoogleFonts.inter(color: Colors.white),
          backgroundColor: primaryGreen,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        onPressed: onTap,
        child: Text(
          text,
          style: GoogleFonts.inter(
              color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
    ),
  );
}

Widget progress(String text) {
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
