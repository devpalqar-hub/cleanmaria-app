import 'package:cleanby_maria/Screens/admin_cleabby_maria/Dashboard/ClientScreen/Models/bookingModel.dart';
import 'package:cleanby_maria/main.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class BookingsController extends GetxController {
  var bookings = <Booking>[].obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;

Future<void> fetchBookings(String status, String type) async {
  isLoading(true);
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString("accessToken");

 
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

  print('🔁 Request URL: $baseUrl/bookings?status=booked&type=instant');
  print('🧾 Request headers: ${response.request?.headers}');
  print('📥 Response status: ${response.statusCode}');
  print('📥 Response body: ${response.body}');

  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    bookings.value = data.map((booking) => Booking.fromJson(booking)).toList();
  } else {
    errorMessage.value = 'Failed to load bookings';
  }

  isLoading(false);
}
}