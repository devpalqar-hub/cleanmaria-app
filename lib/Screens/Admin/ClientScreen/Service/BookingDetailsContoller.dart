import 'dart:convert';
import 'dart:developer';

import 'package:cleanby_maria/Screens/Admin/ClientScreen/Models/BookingDetailModel.dart';
import 'package:cleanby_maria/main.dart';
import 'package:get/state_manager.dart';
import 'package:http/http.dart';

class BookingDetailsController extends GetxController {
  BookingDetailModel? bookingDetail;
  bool isLoading = false;
  bool isCancelLoading = false;
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
      log("Booking Detail Response Body: ${bookingResponse.body}");
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

  Future<bool> cancelBooking(String bookingId) async {
    if (isCancelLoading) return false;
    isCancelLoading = true;
    update();

    final cancelResponse = await post(
      Uri.parse('$baseUrl/bookings/$bookingId/cancel'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $authToken',
      },
    );

    if (cancelResponse.statusCode == 200 || cancelResponse.statusCode == 201) {
      if (bookingDetail != null) {
        bookingDetail!.status = 'CANCELLED';
      }
      isCancelLoading = false;
      update();
      return true;
    }

    errorMessage = 'Failed to cancel booking (${cancelResponse.statusCode})';
    log('Cancel Booking Response Body: ${cancelResponse.body}');
    isCancelLoading = false;
    update();
    return false;
  }
}
