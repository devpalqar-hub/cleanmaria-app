import 'dart:ui';

import 'package:cleanby_maria/Screens/admin_cleabby_maria/ClientScreen/Models/BookingDetailModel.dart';
import 'package:cleanby_maria/Screens/admin_cleabby_maria/ClientScreen/Models/bookingModel.dart';
import 'package:cleanby_maria/Screens/admin_cleabby_maria/HistoryScreen/Models/HistoryModel.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart' show get;
import 'package:intl/intl.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cleanby_maria/main.dart';

class BookingsController extends GetxController {
  var bookings = <BookingModel>[].obs;
  BookingDetailModel? bookingDetail;
  bool isLoading = true;
  String errorMessage = '';
  RefreshController refreshCtrl = RefreshController();
  List<HistoryModel> history = [];
  int page = 1;

  String weektoDay(int i) {
    switch (i) {
      case 0:
        return "Sun";
      case 1:
        return "Mon";
      case 2:
        return "Tue";
      case 3:
        return "Wed";
      case 4:
        return "Thu";
      case 5:
        return "Fri";
      case 6:
        return "Sat";
      default:
        return "";
    }
  }

  String WeekDatetoDate({
    required DateTime createdDate,
    required int weekOfMonth,
    required int dayOfWeek,
  }) {
    if (weekOfMonth < 1 || weekOfMonth > 5 || dayOfWeek < 0 || dayOfWeek > 6) {
      return "";
    }

    DateTime calculateTargetDate(int year, int month) {
      DateTime firstOfMonth = DateTime(year, month, 1);

      int firstOfMonthCustomWeekday = (firstOfMonth.weekday % 7);

      int dayOffset = (dayOfWeek - firstOfMonthCustomWeekday + 7) % 7;

      DateTime firstMatch = firstOfMonth.add(Duration(days: dayOffset));

      DateTime targetDate =
          firstMatch.add(Duration(days: (weekOfMonth - 1) * 7));

      if (targetDate.month != month) {
        return DateTime(year, month + 1, 1).subtract(const Duration(days: 1));
      }

      return targetDate;
    }

    int year = createdDate.year;
    int month = createdDate.month;

    DateTime target = calculateTargetDate(year, month);

    if (target.isBefore(createdDate)) {
      // Move to next month
      if (month == 12) {
        year += 1;
        month = 1;
      } else {
        month += 1;
      }
      target = calculateTargetDate(year, month);
    }
    return DateFormat("dd MMM yy | E").format(target);
  }

  Color getStatusColor(String status) {
    switch (status) {
      case "scheduled":
        return Color(0xFFE89F18);
        break;
      case "missed":
        return Color(0xFFAE1D03);
      case "completed":
        return Color(0xFF03AE9D);
    }
    return Color(0xFFE89F18);
  }

  fetchShedules(String bookingId) async {
//history = [];
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("access_token");
    String parms = "";

    final Response = await get(
      Uri.parse(
        baseUrl +
            "/scheduler/schedules?page=$page&limit=10&bookingId=$bookingId",
      ),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    refreshCtrl.refreshCompleted();
    if (Response.statusCode == 200) {
      var data = json.decode(Response.body);
      for (var his in data["data"]["data"]) {
        HistoryModel model = HistoryModel.fromJson(his);
        history.add(model);
      }
      if (data["data"]["data"].isEmpty) {
        refreshCtrl.loadNoData();
      } else {
        page = page + 1;
      }
    }

    update();
  }

  Future<void> fetchBookings(String status, String type) async {
    isLoading = true;
    update();
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("access_token");

    if (token == null || token.isEmpty) {
      errorMessage = 'Access token is missing';
      isLoading = false;
      return;
    }

    final response = await http.get(
      Uri.parse('$baseUrl/bookings?status=$status&type=$type'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      final List<dynamic> data = responseBody["data"];
      bookings.value =
          data.map((booking) => BookingModel.fromJson(booking)).toList();
    } else {
      errorMessage = 'Failed to load bookings (${response.statusCode})';
    }

    isLoading = false;
    update();
  }

  Future<void> fetchBookingDetails(String bookingId) async {
    isLoading = true;

    errorMessage = '';
    update();
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("access_token");

    if (token == null || token.isEmpty) {
      errorMessage = 'Access token is missing';
      isLoading = false;
      return;
    }

    final response = await http.get(
      Uri.parse('$baseUrl/bookings/$bookingId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      print('Booking Detail Response Body: ${response.body}');

      final data = json.decode(response.body);
      bookingDetail = BookingDetailModel.fromJson(data["data"]);
    } else {
      errorMessage = 'Failed to load booking details (${response.statusCode})';
    }

    isLoading = false;
    update();
  }

  bool checkTransation(Transactions tr) {
    DateTime tm = DateTime.parse(tr.createdAt!);
    DateTime cdate = DateTime.now();

    return tm.isBefore(cdate) && tr.status == "pending";
  }

  @override
  void onInit() {
    super.onInit();
    fetchBookings("booked", "subscription");
  }
}
