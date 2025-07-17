import 'dart:convert';
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

  RefreshController refreshController = RefreshController(initialRefresh: true);

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
      print("❌ Error fetching schedules: $e");
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
          refreshController.loadComplete();
        }
      } else {
        refreshController.loadNoData();
      }
    } catch (e) {
      print("❌ Error fetching next schedules: $e");
      refreshController.loadNoData();
    }

    update();
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
