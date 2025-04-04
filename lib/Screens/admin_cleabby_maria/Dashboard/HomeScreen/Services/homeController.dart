import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class HomeController {
  // Date controllers
  final TextEditingController fromDateController = TextEditingController();
  final TextEditingController toDateController = TextEditingController();

  // User data
  ValueNotifier<String> userName = ValueNotifier("User");

  // Business overview data
  ValueNotifier<int> totalBookings = ValueNotifier(0);
  ValueNotifier<int> totalRevenue = ValueNotifier(0);
  ValueNotifier<int> totalStaff = ValueNotifier(0);

  HomeController() {
    _fetchUserName();
    _initializeDateFields();
    fetchBusinessOverview();
  }

  // Fetch user name from SharedPreferences
  Future<void> _fetchUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userName.value = prefs.getString("user_name") ?? "User";
  }

  // Initialize date fields with today's date
  void _initializeDateFields() {
    String today = DateFormat('dd/MM/yyyy').format(DateTime.now());
    fromDateController.text = today;
    toDateController.text = today;
  }

  // Fetch business overview data
  Future<void> fetchBusinessOverview() async {
    final String apiUrl = "{{base_url}}/analytics/business-overview";
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        totalBookings.value = data['totalBookings'] ?? 0;
        totalRevenue.value = data['totalRevenue'] ?? 0;
        totalStaff.value = data['totalStaff'] ?? 0;
      }
    } catch (e) {
      print("Error fetching business overview: $e");
    }
  }

  // Date Picker for selecting a date
  Future<void> selectDate(BuildContext context, TextEditingController controller) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      controller.text = DateFormat('dd/MM/yyyy').format(pickedDate);
    }
  }

  // Reset both date fields to today's date
  void setTodayDate() {
    String today = DateFormat('dd/MM/yyyy').format(DateTime.now());
    fromDateController.text = today;
    toDateController.text = today;
  }

  // Dispose controllers when no longer needed
  void dispose() {
    fromDateController.dispose();
    toDateController.dispose();
  }
}
