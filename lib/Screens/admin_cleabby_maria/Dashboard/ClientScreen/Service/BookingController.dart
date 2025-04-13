import 'package:cleanby_maria/Screens/admin_cleabby_maria/Dashboard/ClientScreen/Models/BookingDetailModel.dart';
import 'package:cleanby_maria/Screens/admin_cleabby_maria/Dashboard/ClientScreen/Models/bookingModel.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
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
      case 0: return "Sun";
      case 1: return "Mon";
      case 2: return "Tue";
      case 3: return "Wed";
      case 4: return "Thu";
      case 5: return "Fri";
      case 6: return "Sat";
      default: return "";
    }
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
      bookings.value = data.map((booking) => BookingModel.fromJson(booking)).toList();
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
      errorMessage.value = 'Failed to load booking details (${response.statusCode})';
    }

    isLoading(false);
  }

  @override
  void onInit() {
    super.onInit();
    fetchBookings("booked", "subscription");
  }
}
