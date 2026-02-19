import 'dart:convert';
import 'dart:developer';

import 'package:cleanby_maria/Screens/Admin/HistoryScreen/Models/HeatMapModel.dart';
import 'package:cleanby_maria/Screens/Admin/ScheduleViewScreen/Models/ScheduleItemModel.dart';
import 'package:cleanby_maria/main.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class Schedulecontroller extends GetxController {
  DateTime selectedDate = DateTime.now();
  int selectedMonth = DateTime.now().month;
  int selectedYear = DateTime.now().year;
  List<HeatmapDay> calenderItems = [];
  List<ScheduleItemModel> schedules = [];
  bool isloading = false;
  bool isScheduleLoading = false;

  String selectedStaffID = "";

  Schedulecontroller({String staffID = ""}) {
    selectedStaffID = staffID;
  }

  fetchHeatmapData() async {
    calenderItems = [];
    isloading = true;
    update();

    String parms = "";
    if (selectedStaffID != "") {
      parms = "&staffId=$selectedStaffID";
    }
    var response = await get(
      Uri.parse(baseUrl +
          "/bookings/heatmap/calendar?year=${selectedYear}&month=${selectedMonth}$parms"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $authToken',
      },
    );
    log("Fetch HeatMap -->year=${selectedYear}&month=${selectedMonth} ");
    if (response.statusCode == 200 || response.statusCode == 201) {
      var data = json.decode(response.body);
      for (var item in data["data"]["heatmapData"])
        calenderItems.add(HeatmapDay.fromJson(item));
      update();
    } else {
      Fluttertoast.showToast(msg: "Failed to load the calender data");
    }

    isloading = false;
    update();
  }

  fetchSchedules() async {
    schedules = [];
    isScheduleLoading = true;
    String date = DateFormat("yyyy-MM-dd").format(selectedDate);
    String parms = "";
    if (selectedStaffID != "") {
      parms = "&staffId=$selectedStaffID";
    }
    update();
    var response = await get(
      Uri.parse(baseUrl +
          "/scheduler/schedules?startDate=${date}&endDate=${date}&page=1&limit=100"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $authToken',
      },
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      var data = json.decode(response.body);
      for (var item in data["data"]["data"])
        schedules.add(ScheduleItemModel.fromJson(item));
      update();
    } else {
      Fluttertoast.showToast(msg: "Failed to load the schedules");
    }

    isScheduleLoading = false;
    update();
  }
}
