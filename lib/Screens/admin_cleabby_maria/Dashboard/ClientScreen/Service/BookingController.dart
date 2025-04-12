import 'package:cleanby_maria/Screens/admin_cleabby_maria/Dashboard/ClientScreen/Models/bookingModel.dart';
import 'package:cleanby_maria/main.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class BookingsController extends GetxController {
  var bookings = <BookingModel>[].obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;

  Future<void> fetchBookings(String status, String type) async {
    isLoading(true);
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("access_token");

    if (token == null || token.isEmpty) {
      print(" No token found in SharedPreferences!");
      errorMessage.value = 'Access token is missing';
      isLoading(false);
      return;
    } else {
      print("Token retrieved: $token");
    }

    final response = await http.get(
      Uri.parse('$baseUrl/bookings?status=booked&type=instant'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body)["data"];
      bookings.value =
          data.map((booking) => BookingModel.fromJson(booking)).toList();
    } else {
      errorMessage.value = 'Failed to load bookings';
    }

    isLoading(false);
  }

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
        return "Thru";
      case 5:
        return "Fir";
      case 6:
        return "Sat";
    }
    return "";
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    fetchBookings("booked", "subscription");
  }
}
