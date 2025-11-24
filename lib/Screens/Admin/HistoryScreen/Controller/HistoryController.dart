import 'dart:convert';
import 'package:cleanby_maria/Screens/Admin/HistoryScreen/Models/HeatMapModel.dart';
import 'package:cleanby_maria/Screens/Admin/HistoryScreen/Models/HistoryModel.dart';
import 'package:cleanby_maria/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryController extends GetxController {
  int page = 1;
  DateTime? startDate;
  DateTime? endDate;
  List<HistoryModel> history = [];
  int total = 0;

  RefreshController refreshController = RefreshController(initialRefresh: true);
  HeatmapData? heatmapData;
  bool isLoadingHeatmap = false;

  /// Reload entire list
  void reload() {
    page = 1;
    history.clear();
    refreshController.resetNoData();
    fetchSchedules(clear: true);
    update();
  }

  /// Fetch initial schedules
  Future<void> fetchSchedules({bool clear = true}) async {
    if (clear) {
      page = 1;
      history.clear();
      update();
    }

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("access_token");
    String parms = "";

    if (startDate != null && endDate != null) {
      parms =
          "&startDate=${DateFormat("yyyy/MM/dd").format(startDate!)}&endDate=${DateFormat("yyyy/MM/dd").format(endDate!)}";
    }

    final url = "$baseUrl/scheduler/schedules?page=$page&limit=10$parms";
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    try {
      final response = await get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final items = data["data"]["data"] as List;

        for (var his in items) {
          HistoryModel model = HistoryModel.fromJson(his);
          if (!history.any((h) => h.id == model.id)) {
            history.add(model);
          }
        }

        if (items.isEmpty) {
          refreshController.loadNoData();
        } else {
          page += 1;
          refreshController.refreshCompleted();
        }
      } else {
        refreshController.loadNoData();
      }
    } catch (e) {
      print(" Error fetching schedules: $e");
      refreshController.loadNoData();
    }

    update();
  }

  /// Fetch next page
  Future<void> fetchNextSchedules() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("access_token");
    String parms = "";

    if (startDate != null && endDate != null) {
      parms =
          "&startDate=${DateFormat("yyyy/MM/dd").format(startDate!)}&endDate=${DateFormat("yyyy/MM/dd").format(endDate!)}";
    }

    try {
      final response = await get(
        Uri.parse("$baseUrl/scheduler/schedules?page=$page&limit=10$parms"),

         
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        debugPrint("Schedules API raw response: ${response.body}");
        final items = data["data"]["data"] as List;
        debugPrint("Fetched ${items.length} schedules on page $page");


        for (var his in items) {
          HistoryModel model = HistoryModel.fromJson(his);
          if (!history.any((h) => h.id == model.id)) {
            history.add(model);
          }
        }

        if (items.isEmpty) {
          refreshController.loadNoData();
        } else {
          page += 1;
          refreshController.loadComplete();
        }
      } else {
        refreshController.loadNoData();
      }
    } catch (e) {
      print(" Error fetching next schedules: $e");
      refreshController.loadNoData();
    }

    update();
  }
Future<void> fetchSchedulesForDate(DateTime date, {String staffId = "-1"}) async {
  isLoadingHeatmap = true;
  update();

  try {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("access_token");

    String start = DateFormat("yyyy/MM/dd").format(date);
    String end = DateFormat("yyyy/MM/dd").format(date);

    String parms = "&startDate=$start&endDate=$end";
    if (staffId != "-1") {
      parms += "&staffId=$staffId";
    }

    final url = "$baseUrl/scheduler/schedules?page=1&limit=50$parms";
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final response = await get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final items = data["data"]["data"] as List;

      history.clear();
      for (var his in items) {
        history.add(HistoryModel.fromJson(his));
      }

      debugPrint("✅ ${history.length} schedules found for $start");
    } else {
      debugPrint("❌ Failed fetch for date $start → ${response.body}");
      history.clear();
    }
  } catch (e) {
    debugPrint("⚠️ Error fetching date schedules: $e");
    history.clear();
  }

  isLoadingHeatmap = false;
  update();
}
Future<String?> rescheduleBooking({
  required String bookingId,
  required DateTime newDate,
  required String time,
}) async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString("access_token");

  final url = "$baseUrl/scheduler/reschedule/$bookingId";

  final body = {
    "newDate": DateFormat("yyyy-MM-dd").format(newDate),
    "time": time,
  };

  try {
    final response = await patch(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(body),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return null; // success
    } else {
      final decoded = jsonDecode(response.body);

      // return ONLY message field
      return decoded["message"]?.toString() ?? "Something went wrong";
    }
  } catch (e) {
    return e.toString();
  }
}



  Future<void> fetchHeatmap(
    {required int year, required int month, String staffId = "-1"}) async {
  isLoadingHeatmap = true;
  update();

  print("Fetching heatmap → year=$year, month=$month, staffId=$staffId");

  try {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("access_token");

    String parms = "";
    if (staffId != "-1") {
      parms = "&staffId=$staffId";   
    }

    final url =
        "$baseUrl/bookings/heatmap/calendar?year=$year&month=$month$parms";

    print("Final Heatmap URL → $url"); 

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final response = await get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      heatmapData = HeatmapData.fromJson(data["data"]);
      total = heatmapData!.totalBookings ?? 0;
    } else {
      print(" Failed to fetch heatmap: ${response.body}");
      heatmapData = null;
    }
  } catch (e) {
    print("Error fetching heatmap: $e");
    heatmapData = null;
  }

  isLoadingHeatmap = false;
  update();
}


  Color getHeatMapColor(int count, int total) {
    // Clamp values
    if (total <= 0) total = 1;
    if (count < 0) count = 0;
    if (count > total) count = total;

    // Base color (low intensity)
    final Color lowColor = Color(0xFFEBF7F9); // light blue
    // High intensity color
    final Color highColor = Color(0xFF086989); // dark blue

    // Normalized value from 0 to 1
    double t = count / total;

    // Linear interpolation between the two colors
    int r = (lowColor.red + (highColor.red - lowColor.red) * t).round();
    int g = (lowColor.green + (highColor.green - lowColor.green) * t).round();
    int b = (lowColor.blue + (highColor.blue - lowColor.blue) * t).round();

    return Color.fromARGB(255, r, g, b);
  }

  int fetchCountFromDate(DateTime date) {
    int count = 0;
    if (heatmapData != null) {
      for (HeatmapDay dt in heatmapData!.heatmapDays ?? []) {
        if (dt.date.day == date.day) {
          count = dt.bookingCount;
          return count;
        }
      }
    }
    return count;
  }

  /// Get color by status
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
      case "inprogress":
        return Colors.orange;
      case "payment_failed":
        return Colors.deepOrange;
      case "rescheduled":
        return Colors.blueGrey;
      case "payment_success":
        return Colors.green;
      default:
        return Color(0xFFE89F18);
    }
  }
}