import 'dart:convert';

import 'package:cleanby_maria/Screens/Admin/ClientScreen/Models/BookingDetailModel.dart';
import 'package:cleanby_maria/main.dart';
import 'package:get/state_manager.dart';
import 'package:http/http.dart';

class bookingDetailsController extends GetxController {
  BookingDetailModel? bookingDetail;
  bool isLoading = false;
  String errorMessage = '';
  fetchBookingDetails(String bookingId) async {
    isLoading = true;
    update();
    final bookingResponse = await get(
      Uri.parse('$baseUrl/bookings/$bookingId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $authToken',
      },
    );

    if (bookingResponse.statusCode == 200) {
      final bookingData = json.decode(bookingResponse.body);
      bookingDetail = BookingDetailModel.fromJson(bookingData["data"]);
      isLoading = false;
      update();
    } else {
      errorMessage =
          'Failed to load booking details (${bookingResponse.statusCode})';
      print("Booking Detail Response Body: ${bookingResponse.body}");
      isLoading = false;
      update();
      return;
    }
  }
}
