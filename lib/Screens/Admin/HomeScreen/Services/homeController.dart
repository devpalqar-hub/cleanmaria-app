import 'dart:async';
import 'dart:convert';
import 'package:cleanby_maria/Screens/AuthenticationScreen/AutheticationScreen.dart';
import 'package:cleanby_maria/Screens/Admin/HistoryScreen/Models/HistoryModel.dart';
import 'package:cleanby_maria/Screens/Admin/HomeScreen/Model/PerformanceOverTimeModel.dart';
import 'package:cleanby_maria/main.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  // Controllers
  TextEditingController fromDateController = TextEditingController(
    text: DateFormat('yyyy/MM/dd')
        .format(DateTime.now().subtract(Duration(days: 7))),
  );
  TextEditingController toDateController = TextEditingController(
    text: DateFormat('yyyy/MM/dd').format(DateTime.now()),
  );

  String filterRange = "Last Week";
  String userName = "";
  String userEmail = "";

  int totalBookings = 0;
  int avgStaff = 0;
  int totalCancel = 0;

  int totalClients = 0;
  int totalEarnings = 0;
  int totalStaff = 0;

  List<PerformanceOverTimeModel> GraphData = [];
  List<HistoryModel> history = [];

  Timer? _refreshTimer; // ⏱ For auto-refresh

  // Fetch missed/cancelled schedules
  fetchShdedule() async {
    history.clear(); // Clear old data

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("access_token");
    if (token == null || token.isEmpty) {
      print("Missing token, skipping API call.");
      return;
    }

    final response = await http.get(
      Uri.parse(
        "$baseUrl/scheduler/schedules?page=1&limit=30&status=missed",
      ),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      for (var his in data["data"]["data"]) {
        HistoryModel model = HistoryModel.fromJson(his);
        if (model.status == "missing" || model.status == "cancelled") {
          history.add(model);
        }
      }
    } else {
      print("Error fetching schedule: ${response.body}");
    }

    update();
  }

  reload() {
    history.clear();
    update();
    fetchShdedule();
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
      final String apiUrl =
          "$baseUrl/analytics/summary?startDate=$startDate&endDate=$endDate";

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
        totalEarnings = summaryData['totalEarnings'] ?? 0;
        totalStaff = summaryData['totalStaff'] ?? 0;
      } else if (response.statusCode == 401) {
        Fluttertoast.showToast(msg: "Logout Successful");
        prefs.setString("LOGIN", "OUT");
        Get.offAll(() => AuthenticationScreen(),
            transition: Transition.rightToLeft);
      } else {
        print("Summary API Error: ${response.body}");
      }
    } catch (e) {
      print("Error fetching business summary: $e");
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
    } else {
      print("Performance data error: ${response.body}");
    }

    update();
  }

  void setDateRangeFromDropdown(String selectedOption) {
    DateTime today = DateTime.now();
    DateTime fromDate;

    if (selectedOption == "Last Week") {
      fromDate = today.subtract(Duration(days: 7));
    } else if (selectedOption == "Last Month") {
      fromDate = today.subtract(Duration(days: 30));
    } else if (selectedOption == "Last Year") {
      fromDate = today.subtract(Duration(days: 365));
    } else {
      fromDate = today.subtract(Duration(days: 7));
    }

    String startDate = DateFormat('yyyy-MM-dd').format(fromDate);
    String endDate = DateFormat('yyyy-MM-dd').format(today);

    filterRange = selectedOption;
    fetchBusinessSummary(startDate, endDate);
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
    update();
  }

  bool isChartLoader = false;

  Future<void> fetchChartData() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("access_token");

    isChartLoader = true;
    update();

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

    print("Chart Response: ${response.body}");

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      GraphData.clear();

      for (var data in jsonData["data"]) {
        GraphData.add(PerformanceOverTimeModel.fromJson(data));
      }
    }

    isChartLoader = false;
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

  void startAutoRefresh() {
    _refreshTimer?.cancel();
    _refreshTimer = Timer.periodic(Duration(minutes: 5), (timer) {
      fetchShdedule();
      print("Auto-refreshed missed schedules");
    });
  }

  @override
  void onInit() {
    super.onInit();
    print("HomeController initialized");
    loadUser();
    fetchPerformanceData();
    fetchChartData();
    fetchShdedule();
    startAutoRefresh();
  }

  @override
  void onClose() {
    _refreshTimer?.cancel(); 
    super.onClose();
  }
}
