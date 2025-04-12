import 'dart:convert';
import 'package:cleanby_maria/main.dart';
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
  ValueNotifier<String> userEmail = ValueNotifier("user@example.com");

  // Business overview data
  ValueNotifier<int> totalBookings = ValueNotifier(0);
  ValueNotifier<int> totalRevenue = ValueNotifier(0);
  ValueNotifier<int> totalStaff = ValueNotifier(0);

  // Business summary data
  ValueNotifier<int> totalClients = ValueNotifier(0);
  ValueNotifier<int> summaryEarnings = ValueNotifier(0);
  ValueNotifier<int> summaryStaff = ValueNotifier(0);

  // Performance data
  ValueNotifier<Map<String, dynamic>> performanceData = ValueNotifier({});


  HomeController() {
    _fetchUserData();
    _initializeDateFields();
    fetchBusinessSummary();
    fetchPerformanceData();
  }

  Future<void> _fetchUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userName.value = prefs.getString("user_name") ?? "name";
    userEmail.value = prefs.getString("email") ?? "email";
  }

  // Initialize date fields with today's date
  void _initializeDateFields() {
    String today = DateFormat('dd/MM/yyyy').format(DateTime.now());
    fromDateController.text = today;
    toDateController.text = today;
  }

  // Fetch business summary report based on selected date range
  Future<void> fetchBusinessSummary() async {
    try {
      final DateFormat apiFormat = DateFormat('yyyy-MM-dd');
      final DateFormat inputFormat = DateFormat('dd/MM/yyyy');

      final startDate = apiFormat.format(inputFormat.parse(fromDateController.text));
      final endDate = apiFormat.format(inputFormat.parse(toDateController.text));

      final String apiUrl = "$baseUrl/analytics/summary?startDate=$startDate&endDate=$endDate";

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('auth_token');

      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final summaryData = data['data'] ?? {};

        totalClients.value = summaryData['totalClients'] ?? 0;
        summaryEarnings.value = summaryData['totalEarnings'] ?? 0;
        summaryStaff.value = summaryData['totalStaff'] ?? 0;
      } else {
        print("Error: ${response.body}");
      }
    } catch (e) {
      print("Error fetching business summary: $e");
    }
  }

  // Fetch performance data based on selected date range
  Future<void> fetchPerformanceData() async {
    try {
      final DateFormat apiFormat = DateFormat('yyyy-MM-dd');
      final DateFormat inputFormat = DateFormat('dd/MM/yyyy');

      final startDate = apiFormat.format(inputFormat.parse(fromDateController.text));
      final endDate = apiFormat.format(inputFormat.parse(toDateController.text));

      final String apiUrl = "$baseUrl/analytics/performance?startDate=$startDate&endDate=$endDate";

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('auth_token');

      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        performanceData.value = data['data'] ?? {};
      } else {
        print("Error fetching performance data: ${response.body}");
      }
    } catch (e) {
      print("Exception in fetchPerformanceData: $e");
    }
  }

  // Set date range based on selected option
  void setDateRangeFromDropdown(String selectedOption) {
    DateTime today = DateTime.now();
    DateTime fromDate;
    DateTime toDate = today;

    if (selectedOption == "Last 7 Days") {
      fromDate = today.subtract(Duration(days: 6));
    } else if (selectedOption == "This Week") {
      fromDate = DateTime(today.year, today.month, today.day - today.weekday + 1); // Start of the week
      toDate = today;
    } else if (selectedOption == "This Month") {
      fromDate = DateTime(today.year, today.month, 1);
      toDate = DateTime(today.year, today.month + 1, 0); // End of the month
    } else {
      fromDate = today;
    }

    fromDateController.text = DateFormat('dd/MM/yyyy').format(fromDate);
    toDateController.text = DateFormat('dd/MM/yyyy').format(toDate);

    fetchBusinessSummary();
    fetchPerformanceData();
  }

  // Open a date picker and set the selected date to the controller
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

  // Set today's date to the date fields
  void setTodayDate() {
    String today = DateFormat('dd/MM/yyyy').format(DateTime.now());
    fromDateController.text = today;
    toDateController.text = today;
  }

  // Dispose controllers and notifiers when no longer needed
  void dispose() {
    fromDateController.dispose();
    toDateController.dispose();
    userName.dispose();
    userEmail.dispose();
    totalBookings.dispose();
    totalRevenue.dispose();
    totalStaff.dispose();
    totalClients.dispose();
    summaryEarnings.dispose();
    summaryStaff.dispose();
    performanceData.dispose();
  }
}
