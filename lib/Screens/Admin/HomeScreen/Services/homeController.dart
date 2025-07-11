import 'dart:convert';
import 'package:cleanby_maria/Screens/Admin/ClientScreen/Models/bookingModel.dart';
import 'package:cleanby_maria/Screens/AuthenticationScreen/AutheticationScreen.dart';
import 'package:cleanby_maria/Screens/Admin/HomeScreen/Model/PerformanceOverTimeModel.dart';
import 'package:cleanby_maria/main.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  TextEditingController fromDateController = TextEditingController(
      text: DateFormat('yyyy/MM/dd').format(DateTime.now().subtract(Duration(days: 7))));
  TextEditingController toDateController = TextEditingController(
      text: DateFormat('yyyy/MM/dd').format(DateTime.now()));
  String filterRange = "Last Week";

  String userName = "";
  String userEmail = "";

  int totalBookings = 0;
  int avgStaff = 0;
  int totalCancel = 0;

  int totalClients = 0;
  double totalEarnings = 0.0;
  int totalStaff = 0;

  var isChartLoader = false.obs;
  List<PerformanceOverTimeModel> GraphData = [];

  var history = <BookingModel>[].obs;

  Future<void> fetchCancelBooking() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("access_token");

    if (token == null || token.isEmpty) return;

    final response = await http.get(
      Uri.parse("$baseUrl/bookings?status=canceled"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      history.value = data["data"]
          .map<BookingModel>((booking) => BookingModel.fromJson(booking))
          .toList();
    }
  }

  reload() {
    history.clear();
    fetchCancelBooking();
  }

  Color getStatusColor(String status) {
    switch (status) {
      case "scheduled":
        return Color(0xFFE89F18);
      case "missed":
        return Color(0xFFAE1D03);
      case "completed":
        return Color(0xFF03AE9D);
      case "refunded":
        return Colors.blue;
      default:
        return Color(0xFFE89F18);
    }
  }

  Future<void> fetchBusinessSummary(String startDate, String endDate) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("access_token");

    try {
      final String apiUrl = "$baseUrl/analytics/summary?endDate=$startDate&startDate=$endDate";

      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final summaryData = data['data'] ?? {};

        totalClients = summaryData['totalClients'] ?? 0;
        totalEarnings = (summaryData['totalEarnings'] ?? 0).toDouble();
        totalStaff = summaryData['totalStaff'] ?? 0;
      } else if (response.statusCode == 401) {
        Fluttertoast.showToast(msg: "Logout Successful");
        prefs.setString("LOGIN", "OUT");
        Get.offAll(() => AuthenticationScreen(), transition: Transition.rightToLeft);
      }
    } catch (e) {
      print("❗ Exception: $e");
    }
    update();
  }

  Future<void> fetchPerformanceData() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("access_token");
    final String apiUrl =
        "$baseUrl/analytics/performance?startDate=${fromDateController.text}&endDate=${toDateController.text}";

    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data["data"] != null) {
        totalBookings = data["data"]["avgBookingPerDay"];
        avgStaff = data["data"]["avgStaffPerBooking"];
        totalCancel = data["data"]["canceledBookings"];
      }
    }
    update();
  }

  void setDateRangeFromDropdown(String selectedOption) {
    DateTime today = DateTime.now();
    DateTime toDate = today;

    if (selectedOption == "Last Week") {
      toDate = today.subtract(Duration(days: 7));
    } else if (selectedOption == "Last Month") {
      toDate = today.subtract(Duration(days: 30));
    } else if (selectedOption == "Last Year") {
      toDate = today.subtract(Duration(days: 365));
    }

    String startDate = DateFormat('yyyy-MM-dd').format(toDate);
    String endDate = DateFormat('yyyy-MM-dd').format(today);
    fetchBusinessSummary(endDate, startDate);
    fetchChartData();
    update();
  }

  Future<void> selectDate(
      BuildContext context, TextEditingController controller) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      controller.text = DateFormat('yyyy/MM/dd').format(pickedDate);
    }

    fetchPerformanceData();
    fetchChartData();
    update();
  }

  Future<void> fetchChartData() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("access_token");

    isChartLoader.value = true;

    final url = Uri.parse(
      '$baseUrl/analytics/bookings-over-time?startDate=${fromDateController.text}&endDate=${toDateController.text}',
    );

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      GraphData = jsonData["data"]
          .map<PerformanceOverTimeModel>((d) => PerformanceOverTimeModel.fromJson(d))
          .toList();
    }

    isChartLoader.value = false;
    update();
  }

  void setTodayDate() {
    String today = DateFormat('yyyy/MM/dd').format(DateTime.now());
    fromDateController.text = today;
    toDateController.text = today;
    update();
  }

  loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    userName = prefs.getString("user_name") ?? "name";
    userEmail = prefs.getString("email") ?? "email";
    update();
    setDateRangeFromDropdown(filterRange);
  }

  @override
  void onInit() {
    super.onInit();
    loadUser();
    fetchPerformanceData();
    fetchChartData();
    fetchCancelBooking();
  }
}
