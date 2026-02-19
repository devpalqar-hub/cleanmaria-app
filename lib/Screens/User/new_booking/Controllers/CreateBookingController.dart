import 'dart:convert';

import 'package:cleanby_maria/Screens/Admin/ClientScreen/Service/BookingController.dart';
import 'package:cleanby_maria/Screens/Admin/ClientScreen/Service/BookingDetailsContoller.dart';
import 'package:cleanby_maria/Screens/Admin/ScheduleViewScreen/Controller/ScheduleDetailsController.dart';
import 'package:cleanby_maria/Screens/Admin/ScheduleViewScreen/ScheduleDetailsScreen.dart';
import 'package:cleanby_maria/Screens/User/home/Models/UserProfileModel.dart';
import 'package:cleanby_maria/Screens/User/new_booking/Models/UserPlanModel.dart';
import 'package:cleanby_maria/Screens/User/new_booking/Models/UserServiceModel.dart';
import 'package:cleanby_maria/Screens/User/new_booking/Models/UserTimeSlotModel.dart';
import 'package:cleanby_maria/main.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class CreateBookingController extends GetxController {
  CreateBookingController({bool isAdminUser = false, UserProfileModel? user}) {
    isAdmin = isAdminUser;

    if (user != null) {
      isUser = true;

      customerFirstName = user.name ?? "";
      customerEmail = user.email ?? "";
      customerPhone = user.phone ?? "";
      print("Accssed Here");
      print(customerFirstName);
      print(customerLastName);
      print(customerEmail);
    }
    update();
  }

  bool isUser = false;
  bool isAdmin = false;
  List<UserServiceModel> serviceList = [];
  UserServiceModel? selectedService = null;
  List<UserPlanModel> planList = [];
  UserPlanModel? selectedPlan = null;
  List<UsertimeSlotModel> timeSlots = [];
  UsertimeSlotModel? selectedTimeSlot = null;

  // New property fields
  int numberOfBedrooms = 1;
  int numberOfBathrooms = 0;
  String propertyType = 'Apartment';
  double squareFeet = 1000;
  bool ecoCleaning = false;
  bool materialProvide = false;

  // Location fields
  String address = '';
  String city = '';
  String zipcode = '';
  String specialInstructions = '';

  // Admin-only customer fields
  String customerFirstName = '';
  String customerLastName = '';
  String customerEmail = '';
  String customerPhone = '';

  // Booking date
  DateTime? selectedDate;

  // Payment fields
  String paymentMethod = 'cash'; // 'card' or 'cash'
  double? customPrice; // For admin to override default pricing

  // Loading states
  bool isLoadingServices = false;
  bool isLoadingPlans = false;
  bool isLoadingTimeSlots = false;
  bool isRescheduleloading = false;
  bool isCreatingBooking = false;

  fetchServies() async {
    isLoadingServices = true;
    update();
    try {
      final resposnse = await get(Uri.parse(baseUrl + "/services"));
      serviceList.clear();
      print(resposnse.body);
      if (resposnse.statusCode == 200) {
        var data = json.decode(resposnse.body);
        for (var data in data["data"]) {
          serviceList.add(UserServiceModel.fromJson(data));
        }

        if (serviceList.isNotEmpty) selectedService = serviceList.first;
        update();
      }
    } finally {
      isLoadingServices = false;
      update();
    }
  }

  fetchPlans() async {
    print("working");
    isLoadingPlans = true;
    update();
    try {
      final resposnse = await post(
          Uri.parse(
            baseUrl + "/services/price-estimate",
          ),
          headers: {
            'Content-Type': 'application/json',
            // 'Authorization': 'Bearer $a',
          },
          body: json.encode({
            "service_id": selectedService!.id,
            "no_of_rooms": numberOfBedrooms.toInt(),
            "no_of_bathrooms": numberOfBathrooms.toInt(),
            "square_feet": squareFeet.toInt(),
            "materialsProvidedByClient": materialProvide,
            "isEcoCleaning": ecoCleaning
          }));
      planList.clear();
      if (resposnse.statusCode == 200 || resposnse.statusCode == 201) {
        var data = json.decode(resposnse.body);

        for (var data in data["data"]["estimates"]) {
          planList.add(UserPlanModel.fromJson(data));
        }

        if (!planList.isEmpty) {
          selectedPlan = planList.first;
        }
      }
    } finally {
      isLoadingPlans = false;
      update();
    }
  }

  fetchAvalibility(String selectedDate,
      {String zipCode = "",
      String duration = "",
      String service_id = ""}) async {
    isLoadingTimeSlots = true;
    update();
    String endpoint = "";
    if (zipCode != "") {
      endpoint =
          "/scheduler/time-slots?durationMins=${duration}&date=${selectedDate}&planId=${service_id}&pincode=${zipCode}";
    } else {
      int dur = ((selectedService!.durationMinutes! * squareFeet.toInt()) / 500)
          .round();
      endpoint =
          "/scheduler/time-slots?durationMins=${dur}&date=${selectedDate}&planId=${selectedPlan!.recurringTypeId!}&pincode=${zipcode}";
    }
    print(endpoint);
    final resposnse = await get(Uri.parse(baseUrl + endpoint));
    timeSlots = [];
    selectedTimeSlot = null;
    print(resposnse.body);
    if (resposnse.statusCode == 200) {
      var data = json.decode(resposnse.body);
      for (var data in data["data"]) {
        timeSlots.add(UsertimeSlotModel.fromJson(data));
      }
    } else {
      var data = json.decode(resposnse.body);
      Get.back();
      Fluttertoast.showToast(
          msg: "${data["message"] ?? "Failed to get avalible time slot."}");
    }

    isLoadingTimeSlots = false;
    update();
  }

  rescheduleBooking(
      String bookingId, String zipcode, DateTime selectedDate) async {
    final url = "$baseUrl/scheduler/reschedule/$bookingId";
    isRescheduleloading = true;
    update();
    final body = {
      "newDate": DateFormat("yyyy-MM-dd").format(selectedDate),
      "time": selectedTimeSlot!.time ?? "",
    };

    final response = await patch(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $authToken',
      },
      body: jsonEncode(body),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      ScheduleDetailsController ctrl = Get.find();
      ctrl.fetchBookingDetails(bookingId);
      Get.back();
      Fluttertoast.showToast(msg: "Upcomming schedule has been successfully");
    } else {
      final decoded = jsonDecode(response.body);

      // return ONLY message field
      Fluttertoast.showToast(msg: "Failed to reschedule the booking");
    }
    isRescheduleloading = false;
    update();
  }

  createBoooking() async {
    if (selectedService == null ||
        selectedPlan == null ||
        selectedTimeSlot == null ||
        selectedDate == null) {
      Fluttertoast.showToast(msg: "Please complete all required fields");
      return;
    }

    isCreatingBooking = true;
    update();

    try {
      // Determine payment method for API
      String apiPaymentMethod = paymentMethod == 'card' ? 'online' : 'offline';

      // Prepare booking data based on admin status
      Map<String, dynamic> bookingData = {
        "serviceId": selectedService!.id,
        "type": selectedPlan!.title == "One Time" ? "one_time" : "recurring",
        "no_of_rooms": numberOfBedrooms,
        "no_of_bathrooms": numberOfBathrooms,
        "propertyType": propertyType,
        "materialProvided": materialProvide,
        "areaSize": squareFeet.toInt(),
        "isEco": ecoCleaning,
        "price": customPrice ?? selectedPlan!.finalPrice ?? 0,
        "paymentMethod": apiPaymentMethod,
        if (selectedPlan!.recurringTypeId != "notASubcriptionTypeId")
          "recurringTypeId": selectedPlan!.recurringTypeId,
        "address": {
          "street": address,
          "landmark": "",
          "addressLine1": address,
          "addressLine2": "",
          "city": city,
          "zip": zipcode,
          "specialInstructions": specialInstructions
        },
        "date": DateFormat("yyyy-MM-dd").format(selectedDate!),
        "time": selectedTimeSlot!.time,
      };

      print(bookingData);

      // Add customer details (admin provides these, regular users use their own account)
      //  if (isAdmin) {
      bookingData["name"] = "$customerFirstName $customerLastName".trim();
      bookingData["email"] = customerEmail;
      bookingData["phone"] = customerPhone;
      //  }

      final response = await post(
        Uri.parse('$baseUrl/bookings'),
        headers: {
          'Content-Type': 'application/json',
          if (!isAdmin) 'Authorization': 'Bearer $authToken',
        },
        body: jsonEncode(bookingData),
      );
      print(response.body);
      print(response.statusCode);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = json.decode(response.body);
        final bookingId = data['data']['booking']['id'];

        Fluttertoast.showToast(
            msg: data['message'] ?? "Booking successfully confirmed!");

        // Navigate to ScheduleDetailsScreen based on user type

        Get.back();
        Get.back();
        Get.back();
        Get.back();
        Get.back();

        if (isAdmin) {
          BookingsController bctrl = Get.put(BookingsController());
          bctrl.fetchBookings(bctrl.status, bctrl.selectedtype);
        }
        Get.to(() => ScheduleDetailsScreen(
              bookingID: bookingId,
              isAdmin: isAdmin,
              isUser: !isAdmin,
              isStaff: false,
            ));
      } else {
        final error = json.decode(response.body);
        Fluttertoast.showToast(
            msg: error['message'] ??
                "Failed to create booking. Please try again.");
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Error creating booking: ${e.toString()}");
      print("Booking error: $e");
    } finally {
      isCreatingBooking = false;
      update();
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchServies();
  }
}
