import 'dart:convert';
import 'package:cleanby_maria/Screens/Admin/ServiceScreen/Model/Service Model.dart';
import 'package:cleanby_maria/main.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ServiceController extends GetxController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController durationController = TextEditingController();
  final TextEditingController basePriceController = TextEditingController();
  final TextEditingController bathroomRateController = TextEditingController();
  final TextEditingController roomRateController = TextEditingController();
  final TextEditingController squareFootPriceController = TextEditingController();

  Map<String, String> authHeader = {};
  List<ServiceModel> services = [];
  bool isLoading = false;

  @override
  void onInit() {
    super.onInit();
    loadUser();
  }

  Future<void> loadUser() async {
    print("loadUser(): Fetching token from SharedPreferences...");
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');
    print("Token loaded: $token");

    authHeader = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
    update();
    await fetchServices();
  }

  Future<void> fetchServices() async {
    print("fetchServices(): Starting API call...");
    services.clear();
    update();

    final url = Uri.parse('$baseUrl/services');
    print("GET $url");
    print("Headers: $authHeader");

    isLoading = true;
    update();

    try {
      final response = await http.get(url, headers: authHeader);
      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode == 200) {
        final decoded = json.decode(response.body);
        if (decoded['data'] is List) {
          for (var item in decoded['data']) {
            services.add(ServiceModel.fromJson(item));
          }
          print("Parsed ${services.length} services.");
        } else {
          print("fetchServices(): 'data' key is not a List!");
        }
      } else {
        Fluttertoast.showToast(
            msg: "Failed to fetch services (${response.statusCode})");
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Error fetching services: $e");
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> createService(BuildContext context) async {
    if ([
      nameController.text,
      durationController.text,
      basePriceController.text,
      bathroomRateController.text,
      roomRateController.text,
      squareFootPriceController.text
    ].any((field) => field.isEmpty)) {
      Fluttertoast.showToast(msg: "Please fill all required fields");
      return;
    }

    final payload = {
      "name": nameController.text.trim(),
      "durationMinutes": int.parse(durationController.text.trim()),
      "base_price": int.parse(basePriceController.text.trim()),
      "bathroom_rate": int.parse(bathroomRateController.text.trim()),
      "room_rate": int.parse(roomRateController.text.trim()),
      "square_foot_price": int.parse(squareFootPriceController.text.trim()),
    };

    print("createService(): Preparing to POST");
    print("URL: $baseUrl/services");
    print("Headers: $authHeader");
    print("Body: ${json.encode(payload)}");

    isLoading = true;
    update();

    try {
      final response = await http.post(
        Uri.parse("$baseUrl/services"),
        headers: authHeader,
        body: json.encode(payload),
      );

      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        Fluttertoast.showToast(msg: "Service created successfully");
        Navigator.of(context).pop();
        clearText();
        await fetchServices();
      } else {
        Fluttertoast.showToast(
            msg: "Error: Failed to create service (${response.statusCode})");
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Something went wrong: $e");
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> updateService(String serviceId, BuildContext context) async {
    if ([
      nameController.text,
      durationController.text,
      basePriceController.text,
      bathroomRateController.text,
      roomRateController.text,
      squareFootPriceController.text,
    ].any((f) => f.trim().isEmpty)) {
      Fluttertoast.showToast(msg: 'Please fill all required fields');
      return;
    }

    final body = {
      "name": nameController.text.trim(),
      "durationMinutes": double.parse(durationController.text.trim()),
      "base_price": int.parse(basePriceController.text.trim()),
      "bathroom_rate": int.parse(bathroomRateController.text.trim()),
      "room_rate": int.parse(roomRateController.text.trim()),
      "square_foot_price": int.parse(squareFootPriceController.text.trim()),
    };

    isLoading = true;
    update();

    try {
      final response = await http.patch(
        Uri.parse('$baseUrl/services/$serviceId'),
        headers: authHeader,
        body: jsonEncode(body),
      );

      debugPrint('PATCH ${response.request?.url} → ${response.statusCode}');
      debugPrint('Response: ${response.body}');

      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: 'Service updated successfully');
        Navigator.pop(context);
        await fetchServices();
      } else {
        print("Update failed: ${response.statusCode}");
        print("Response: ${response.body}");
        Fluttertoast.showToast(
          msg: "Failed to update service: ${response.statusCode}",
        );
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error updating service: $e');
    } finally {
      isLoading = false;
      update();
    }
  }

  void clearText() {
    nameController.clear();
    durationController.clear();
    basePriceController.clear();
    bathroomRateController.clear();
    roomRateController.clear();
    squareFootPriceController.clear();
    print("clearText(): Controllers cleared.");
    update();
  }
}
