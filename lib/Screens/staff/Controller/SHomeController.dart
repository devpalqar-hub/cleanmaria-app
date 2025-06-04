import 'dart:convert';
import 'dart:ui';

import 'package:cleanby_maria/Screens/AuthenticationScreen/AutheticationScreen.dart';
import 'package:cleanby_maria/Screens/Admin/HistoryScreen/Controller/HistoryController.dart';
import 'package:cleanby_maria/Screens/Admin/HistoryScreen/Models/HistoryModel.dart';
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

  fetchShdedule() async {
    // history = [];
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("access_token");
    String parms = "";
    if (selectedFilter != "All Duty") parms = "&status=$selectedFilter";
    final Response = await http.get(
      Uri.parse(
        baseUrl + "/scheduler/schedules?page=${page}&limit=10$parms",
      ),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    refreshCtrl.refreshCompleted();
   refreshCtrl.loadComplete();

    print(Response.body);
    print(Response.statusCode);
    if (Response.statusCode == 200) {
      print("Access Token: $token");

      var data = json.decode(Response.body);
      for (var his in data["data"]["data"]) {
        HistoryModel model = HistoryModel.fromJson(his);
        history.add(model);
      }

      if (data["data"]["data"].isNotEmpty) {
        page = page + 1;
      } else {
        refreshCtrl.loadNoData();
      }
    }
    update();
  }

  fetchTodayShedule() async {
    todayHistory = [];
    completeTask = 0;
  
  total = 0; 

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("access_token");
    final Response = await http.get(
      Uri.parse(
        baseUrl +
            "/scheduler/schedules?page=1&limit=30&startDate=${DateFormat("yyyy-MM-dd").format(DateTime.now())}",
      ),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (Response.statusCode == 200) {
      var data = json.decode(Response.body);
      for (var his in data["data"]["data"]) {
        HistoryModel model = HistoryModel.fromJson(his);
        total = total + 1;
        if (model.status == "scheduled") todayHistory.add(model);

        if (model.status == "completed") completeTask = completeTask + 1;
      }
    } else if (Response.statusCode == 401) {
      var body = json.decode(Response.body);
    if (body["message"] == "User is not active") {
      Fluttertoast.showToast(msg: "Staff is not active");
    }else{
      Fluttertoast.showToast(msg: "Logout Suceesfully");
    }
      prefs.setString("LOGIN", "OUT");
      Get.offAll(() => AuthenticationScreen(),
          transition: Transition.rightToLeft);
    }
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
