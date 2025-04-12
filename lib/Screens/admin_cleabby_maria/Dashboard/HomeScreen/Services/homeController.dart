import 'dart:convert';
import 'package:cleanby_maria/Screens/AuthenticationScreen/AutheticationScreen.dart';
import 'package:cleanby_maria/Screens/admin_cleabby_maria/Dashboard/HomeScreen/Model/PerformanceOverTimeModel.dart';
import 'package:cleanby_maria/main.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  // Date controllers
  TextEditingController fromDateController = TextEditingController(
      text: DateFormat('yyyy-MM-dd').format(DateTime.now()));
  TextEditingController toDateController = TextEditingController(
      text: DateFormat('yyyy-MM-dd').format(DateTime.now()));
  String filterRange = "Last Week";
  Map<String, String> authHeader = {};

  String userName = "";
  String userEmail = "";

  int totalBookings = 0;
  int avgStaff = 0;
  int totalCancel = 0;

  int totalClients = 0;
  int summaryEarnings = 0;
  int summaryStaff = 0;

  List<PerformanceOverTimeModel> GraphData = [];

  Future<void> fetchBusinessSummary(String startDate, String endDate) async {
    try {
      final String apiUrl =
          "$baseUrl/analytics/summary?startDate=$startDate&endDate=$endDate";

      final response = await http.get(Uri.parse(apiUrl), headers: authHeader);
      print(response.body);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final summaryData = data['data'] ?? {};

        totalClients = summaryData['totalClients'] ?? 0;
        summaryEarnings = summaryData['totalEarnings'] ?? 0;
        summaryStaff = summaryData['totalStaff'] ?? 0;
      } else if (response.statusCode == 401) {
        Fluttertoast.showToast(msg: "Session Expired");
        Get.offAll(() => AuthenticationScreen(),
            transition: Transition.rightToLeft);
      } else {
        print("Error: ${response.body}");
      }
    } catch (e) {
      print("Error fetching business summary: $e");
    }
    update();
  }

  // Fetch performance data based on selected date range
  Future<void> fetchPerformanceData() async {
    final String apiUrl =
        "$baseUrl/analytics/performance?startDate=${fromDateController.text}&endDate=${toDateController.text}";

    final response = await http.get(Uri.parse(apiUrl), headers: authHeader);
    print(authHeader);
    print(response.body);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if (data["data"] != null) {
        totalBookings = data["data"]["avgBookingPerDay"];
        avgStaff = data["data"]["avgStaffPerBooking"];
        totalCancel = data["data"]["canceledBookings"];
      }
    } else {
      print("Error fetching performance data: ${response.body}");
    }

    update();
  }

  // Set date range based on selected option
  void setDateRangeFromDropdown(String selectedOption) {
    DateTime today = DateTime.now();

    DateTime toDate = today;

    if (selectedOption == "Last Week") {
      toDate = today.subtract(Duration(days: 7));
    } else if (selectedOption == "Last Month") {
      toDate = today.subtract(Duration(days: 30)); // Start of the week
    } else if (selectedOption == "Last Year") {
      toDate = today.subtract(Duration(days: 365)); // End of the month
    }

    String startDate = DateFormat('yyyy-MM-dd').format(toDate);
    String endDate = DateFormat('yyyy-MM-dd').format(toDate);
    // fromDateController.text = startDate;
    // toDateController.text = endDate;

    fetchBusinessSummary(endDate, startDate);
    update();
  }

  // Open a date picker and set the selected date to the controller
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
    //fetchChartData();
    update();
  }

  bool isChartLoader = false;
  Future<void> fetchChartData() async {
    isChartLoader = true;
    update();
    final url = Uri.parse(
      '$baseUrl/analytics/bookings-over-time?startDate=${fromDateController.text}&endDate=${toDateController.text}',
    );

    final response = await http.get(url, headers: authHeader);
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      for (var data in jsonData["data"]) {
        GraphData.add(PerformanceOverTimeModel.fromJson(data));
      }

      update();
    }
    isChartLoader = false;
    update();
  }

  // Set today's date to the date fields
  void setTodayDate() {
    String today = DateFormat('yyyy-MM/-dd').format(DateTime.now());
    fromDateController.text = today;
    toDateController.text = today;
    update();
  }

  // Dispose controllers and notifiers when no longer needed

  loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');
    userName = prefs.getString("user_name") ?? "name";
    userEmail = prefs.getString("email") ?? "email";
    authHeader = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
    update();

    setDateRangeFromDropdown(filterRange);
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    print("init");
    loadUser();
    fetchPerformanceData();
    fetchChartData();
  }
}
