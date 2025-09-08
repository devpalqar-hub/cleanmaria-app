import 'dart:convert';
import 'dart:ui';

import 'package:cleanby_maria/Screens/AuthenticationScreen/AutheticationScreen.dart';
import 'package:cleanby_maria/Screens/Admin/HistoryScreen/Controller/HistoryController.dart';
import 'package:cleanby_maria/Screens/Admin/HistoryScreen/Models/HistoryModel.dart';
import 'package:cleanby_maria/Screens/staff/Models/StaffHeatMap.dart';
import 'package:cleanby_maria/main.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart' show Fluttertoast;
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StaffHomeController extends GetxController {
  String userName = "user";
  String email = "";

  RefreshController refreshCtrl = RefreshController();
  int page = 1;
  List<HistoryModel> history = [];
  List<HistoryModel> todayHistory = [];
  String selectedFilter = "All Duty";

  loadUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    userName = pref.getString("user_name") ?? "--:--";
    email = pref.getString("email") ?? "--:--";
    update();
  }

  int completeTask = 0;
  int total = 0;

  StaffHeatmapData? staffHeatmap;
  bool isLoadingHeatmap = false;

  reload() {
    history.clear();
    todayHistory.clear();
    history = [];
    todayHistory = [];
    update();
    refreshCtrl.resetNoData();

    page = 1;
    fetchTodayShedule();
    fetchShdedule();
  }

  fetchShdedule({String? userId}) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("access_token");
    String parms =
        selectedFilter != "All Duty" ? "&status=$selectedFilter" : "";
    final url = "$baseUrl/scheduler/schedules?page=$page&limit=10$parms";

    print("[GET] $url");
    print("Headers: Authorization Bearer $token");

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    refreshCtrl.refreshCompleted();
    refreshCtrl.loadComplete();

    print("Status Code: ${response.statusCode}");
    print("Response Body: ${response.body}");

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      for (var his in data["data"]["data"]) {
        history.add(HistoryModel.fromJson(his));
      }

      if (data["data"]["data"].isNotEmpty) {
        page += 1;
      } else {
        refreshCtrl.loadNoData();
      }
    } else {
      print("Error: ${response.reasonPhrase}");
    }

    update();
  }

  fetchTodayShedule({String? userId}) async {
    todayHistory = [];
    completeTask = 0;
    total = 0;

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("access_token");
    final startDate = DateFormat("yyyy-MM-dd").format(DateTime.now());

    final endDate =
        DateFormat("yyyy-MM-dd").format(DateTime.now().add(Duration(days: 1)));
    final url =
        "$baseUrl/scheduler/schedules?page=1&limit=30&startDate=$startDate&endDate=$endDate&status=scheduled";

    print("[GET] $url");
    print("Headers: Authorization Bearer $token");

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    print("Status Code: ${response.statusCode}");
    print("Response Body: ${response.body}");

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      for (var his in data["data"]["data"]) {
        final model = HistoryModel.fromJson(his);
        total += 1;
        if (model.status == "scheduled") todayHistory.add(model);
        if (model.status == "completed") completeTask += 1;
      }
    } else if (response.statusCode == 401) {
      var body = json.decode(response.body);
      if (body["message"] == "User is not active") {
        Fluttertoast.showToast(msg: "Staff is not active");
      } else {
        Fluttertoast.showToast(msg: "Logout Successfully");
      }

      prefs.setString("LOGIN", "OUT");
      Get.offAll(() => AuthenticationScreen(),
          transition: Transition.rightToLeft);
    } else {
      print("Error: ${response.reasonPhrase}");
    }

    update();
  }
 Future<void> fetchStaffHeatmap(
      {required int year,
      required int month,
      required String staffId}) async {
    isLoadingHeatmap = true;
    update();

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("access_token");

      final url =
          "$baseUrl/analytics/booking-heatmap?year=$year&month=$month&staffId=$staffId";

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        staffHeatmap = StaffHeatmapData.fromJson(data["data"]);
      } else {
        staffHeatmap = null;
        print("❌ Failed to fetch staff heatmap: ${response.body}");
      }
    } catch (e) {
      staffHeatmap = null;
      print("❌ Error fetching staff heatmap: $e");
    }

    isLoadingHeatmap = false;
    update();
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
    }
    return Color(0xFFE89F18);
  }

  @override
  void onInit() {
    print("init");
    // TODO: implement onInit
    super.onInit();
    loadUser();
    fetchShdedule();
    fetchTodayShedule();
  }
}
