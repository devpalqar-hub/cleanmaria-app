import 'dart:convert';

import 'package:cleanby_maria/Screens/Admin/ClientScreen/Models/BookingDetailModel.dart';
import 'package:cleanby_maria/Screens/Admin/ClientScreen/Models/bookingModel.dart';
import 'package:cleanby_maria/main.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

class UserBookingcontroller extends GetxController {
  List<BookingDetailModel> myBookings = [];
  bool isLoading = false;
  fetchUserBooking() async {
    myBookings = [];
    isLoading = true;
    update();
    final response = await get(
      Uri.parse(baseUrl + "/bookings"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $authToken',
      },
    );
    print(response.body);
    if (response.statusCode == 200) {
      for (var data in json.decode(response.body)["data"])
        myBookings.add(BookingDetailModel.fromJson(data));
    }
    isLoading = false;
    update();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    // fetchUserBooking();
  }
}
