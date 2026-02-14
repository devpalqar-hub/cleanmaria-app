import 'dart:convert';

import 'package:cleanby_maria/Screens/User/new_booking/Models/UserPlanModel.dart';
import 'package:cleanby_maria/Screens/User/new_booking/Models/UserServiceModel.dart';
import 'package:cleanby_maria/Screens/User/new_booking/Models/UserTimeSlotModel.dart';
import 'package:cleanby_maria/main.dart';
import 'package:get/state_manager.dart';
import 'package:http/http.dart';

class CreateBookingController extends GetxController {
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

  // Payment fields
  String paymentMethod = 'card'; // 'card' or 'cash'

  // Loading states
  bool isLoadingServices = false;
  bool isLoadingPlans = false;
  bool isLoadingTimeSlots = false;

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

  fetchAvalibility(
    String selectedDate,
  ) async {
    isLoadingTimeSlots = true;
    update();

    final resposnse = await get(Uri.parse(baseUrl +
        "/scheduler/time-slots?durationMins=${selectedService!.durationMinutes ?? 0 * squareFeet}&date=2026-02-12&planId=${selectedPlan!.recurringTypeId!}&pincode=${zipcode}"));
    timeSlots = [];
    selectedTimeSlot = null;
    print(resposnse.body);
    if (resposnse.statusCode == 200) {
      var data = json.decode(resposnse.body);
      for (var data in data["data"]) {
        timeSlots.add(UsertimeSlotModel.fromJson(data));
      }
    }

    isLoadingTimeSlots = false;
    update();
  }

  createBoooking() {}

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchServies();
  }
}
