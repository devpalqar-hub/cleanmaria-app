import 'package:cleanby_maria/Screens/admin_cleabby_maria/Dashboard/ClientScreen/Models/BookingDetailModel.dart';
import 'package:cleanby_maria/Screens/admin_cleabby_maria/Dashboard/ClientScreen/Models/bookingModel.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cleanby_maria/main.dart';

class BookingsController extends GetxController {
  var bookings = <BookingModel>[].obs;
  var bookingDetail = Rxn<BookingDetail>();
  var isLoading = true.obs;
  var errorMessage = ''.obs;

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

      if (targetDate.month != month)
        return DateTime(year, month + 1, 1).subtract(const Duration(days: 1));

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

  Future<void> fetchBookings(String status, String type) async {
    isLoading(true);
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("access_token");

    if (token == null || token.isEmpty) {
      errorMessage.value = 'Access token is missing';
      isLoading(false);
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
      errorMessage.value = 'Failed to load bookings (${response.statusCode})';
    }

    isLoading(false);
  }

  Future<void> fetchBookingDetails(String bookingId) async {
    isLoading(true);
    errorMessage.value = '';
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("access_token");

    if (token == null || token.isEmpty) {
      errorMessage.value = 'Access token is missing';
      isLoading(false);
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
      bookingDetail.value = BookingDetail.fromJson(data);
    } else {
      errorMessage.value =
          'Failed to load booking details (${response.statusCode})';
    }

    isLoading(false);
  }

  @override
  void onInit() {
    super.onInit();
    fetchBookings("booked", "subscription");
  }
}
