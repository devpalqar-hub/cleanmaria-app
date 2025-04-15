import 'dart:convert';

import 'package:cleanby_maria/Screens/Admin/HistoryScreen/Models/HistoryModel.dart';
import 'package:cleanby_maria/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
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

  fetchShedules() async {
    history.clear();
    update();
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("access_token");
    String parms = "";
    page = 1;
    if (startDate != null && endDate != null) {
      parms =
          "&startDate=${DateFormat("yyyy/MM/dd").format(startDate!)}&endDate=${DateFormat("yyyy/MM/dd").format(endDate!)}";
    }
    print(parms);
    final Response = await get(
      Uri.parse(
        baseUrl + "/scheduler/schedules?page=1&limit=10$parms",
      ),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    print(Response.body);
    print(Response.statusCode);
    refreshController.refreshCompleted();
    if (Response.statusCode == 200) {
      var data = json.decode(Response.body);
      for (var his in data["data"]["data"]) {
        HistoryModel model = HistoryModel.fromJson(his);
        history.add(model);
      }

      if (data["data"]["data"].isEmpty) {
        refreshController.loadNoData();
      } else {
        page = page + 1;
      }
    } else {
      refreshController.loadNoData();
    }

    update();
  }

  fetchNextShedules() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("access_token");
    String parms = "";
    if (startDate != null && endDate != null) {
      parms =
          "&startDate=${DateFormat("yyyy/MM/dd").format(startDate!)}&endDate=${DateFormat("yyyy/MM/dd").format(endDate!)}";
    }

    print(page);
    final Response = await get(
      Uri.parse(
        baseUrl + "/scheduler/schedules?page=$page&limit=10$parms",
      ),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    refreshController.loadComplete();
    if (Response.statusCode == 200) {
      var data = json.decode(Response.body);
      for (var his in data["data"]["data"]) {
        HistoryModel model = HistoryModel.fromJson(his);
        history.add(model);
      }
      if (data["data"]["data"].isEmpty) {
        refreshController.loadNoData();
      } else {
        page = page + 1;
      }
    }
    update();
  }

  Color getStatusColor(String status) {
    switch (status) {
      case "Scheduled":
        return Color(0xFFE89F18);
        break;
      case "Missed":
        return Color(0xFFAE1D03);
      case "Completed":
        return Color(0xFF03AE9D);
    }
    return Color(0xFFE89F18);
  }
}
