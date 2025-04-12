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
  final token = prefs.getString('token') ?? '';
     print('Token: $token');
  final response = await http.get(
    Uri.parse('$baseUrl/bookings?status=booked&type=instant'),
    headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    },
  );

    print('Response body: ${response.body}');

  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    bookings.value = data.map((booking) => Booking.fromJson(booking)).toList();
  } else {
    errorMessage.value = 'Failed to load bookings';
  }

  isLoading(false);
}
}