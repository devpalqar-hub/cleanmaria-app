import 'dart:convert';
import 'dart:developer';

import 'package:cleanby_maria/Screens/Admin/ClientScreen/Models/BookingDetailModel.dart';
import 'package:cleanby_maria/Screens/Admin/ScheduleViewScreen/Models/ScheduleItemModel.dart';
import 'package:cleanby_maria/main.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class ScheduleDetailsController extends GetxController {
  ScheduleItemModel? schedule;
  BookingDetailModel? bookingDetail;
  bool isLoading = true;

  ScheduleDetailsController(
      String bookingID, ScheduleItemModel? scheduleDetals) {
    fetchBookingDetails(bookingID);

    schedule = scheduleDetals;
  }

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
      print("Booking Detail Response Body: ${bookingResponse.body}");
      isLoading = false;
      update();
      return;
    }
  }

  String getBookinAddress() {
    var address = bookingDetail!.bookingAddress!.address;
    return "${address!.street}, ${address!.city} - ${address!.zip}  ";
  }

  String getBookingTime() {
    try {
      var date = "";
      if (bookingDetail != null) {
        date = date + "${bookingDetail!.monthSchedules!.first!.time}";
      }

      if (schedule != null && schedule!.endTime != null) {
        date = date +
            " - ${DateFormat("hh:mm").format(DateTime.parse(schedule!.endTime!))} ";
      }
      return date + " ( ${bookingDetail!.reccuingType!.capitalize!} )";
    } catch (e) {
      if (bookingDetail!.nextSchedule == null) {
        return "Completed";
      } else {
        return "${DateFormat("hh:mm").format(DateTime.parse(bookingDetail!.nextSchedule!.startTime!))} - ${DateFormat("hh:mm").format(DateTime.parse(bookingDetail!.nextSchedule!.endTime!))} ";
      }
      return "";
    }
  }

  String formatDuration(Duration duration) {
    // Handle negative duration
    if (duration.isNegative) {
      return "Completed";
    }

    if (duration.inDays > 0) {
      final days = duration.inDays;
      final hours = duration.inHours.remainder(24);
      return hours > 0 ? "${days}d ${hours}h" : "${days}d";
    }

    if (duration.inHours > 0) {
      final hours = duration.inHours;
      final minutes = duration.inMinutes.remainder(60);
      return minutes > 0 ? "${hours}h ${minutes}m" : "${hours}h";
    }

    if (duration.inMinutes > 0) {
      final minutes = duration.inMinutes;
      final seconds = duration.inSeconds.remainder(60);
      return seconds > 0 ? "${minutes}m ${seconds}s" : "${minutes}m";
    }

    final seconds = duration.inSeconds;
    return "${seconds}s";
  }

  Future<bool> updateScheduleStatus(String scheduleId, String status) async {
    isLoading = true;
    update();

    final response = await patch(
      Uri.parse('$baseUrl/scheduler/schedules/$scheduleId/change-status'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $authToken',
      },
      body: jsonEncode({'status': status}),
    );
    print(response.body + "$status");
    isLoading = false;
    if (response.statusCode == 200 || response.statusCode == 201) {
      if (schedule != null) {
        schedule!.status = status;
      }
      update();
      return true;
    }

    log('Update Status Error: ${response.body}');
    update();
    return false;
  }

  Future<bool> cancelBooking(String bookingId) async {
    if (isLoading) return false;
    isLoading = true;
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
      isLoading = false;
      update();
      Fluttertoast.showToast(msg: "Booking canceled successfully");
      return true;
    } else {
      Fluttertoast.showToast(msg: "Failed to cancel booking");
    }

    log('Cancel Booking Response Body: ${cancelResponse.body}');
    isLoading = false;
    update();
    return false;
  }

  Future<bool> updateBookingPrice(String bookingId, double newPrice) async {
    if (isLoading) return false;
    isLoading = true;
    update();

    final response = await patch(
      Uri.parse('$baseUrl/bookings/$bookingId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $authToken',
      },
      body: jsonEncode({'finalAmount': newPrice}),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      if (bookingDetail != null) {
        bookingDetail!.price = newPrice.toString();
      }
      isLoading = false;
      update();
      Fluttertoast.showToast(msg: "Price updated successfully");
      return true;
    } else {
      Fluttertoast.showToast(msg: "Failed to update price");
    }

    log('Update Price Response Body: ${response.body}');
    isLoading = false;
    update();
    return false;
  }

  Future<bool> updatePaymentMethod(
      String bookingId, String paymentMethod) async {
    if (isLoading) return false;
    isLoading = true;
    update();

    final response = await post(
      Uri.parse('$baseUrl/bookings/$bookingId/update-payment-method'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $authToken',
      },
      body: jsonEncode({'paymentMethod': paymentMethod}),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final responseData = json.decode(response.body);
      final message =
          responseData['message'] ?? 'Payment method updated successfully';
      Fluttertoast.showToast(msg: message);

      // Reload booking details
      await fetchBookingDetails(bookingId);
      return true;
    } else {
      Fluttertoast.showToast(msg: "Failed to update payment method");
    }

    log('Update Payment Method Response Body: ${response.body}');
    isLoading = false;
    update();
    return false;
  }
}
