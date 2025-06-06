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
  final TextEditingController squareFootPriceController =
      TextEditingController();

  Map<String, String> authHeader = {};
  List<ServiceModel> services = [];
  bool isLoading = false;

  @override
  void onInit() {
    super.onInit();
    loadUser();
  }

  Future<void> loadUser() async {
    print(" loadUser(): Fetching token from SharedPreferences...");
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
    print(" Headers: $authHeader");

    isLoading = true;
    update();

    try {
      final response = await http.get(url, headers: authHeader);
      print(" Response status: ${response.statusCode}");
      print("Response body: ${response.body}");
      if (response.statusCode == 200) {
        final decoded = json.decode(response.body);
        if (decoded['data'] is List) {
          for (var item in decoded['data']) {
            services.add(ServiceModel.fromJson(item));
          }
          print(" Parsed ${services.length} services.");
        } else {
          print(" fetchServices(): 'data' key is not a List!");
        }
      } else {
        print(" fetchServices(): HTTP ${response.statusCode}");
        Fluttertoast.showToast(
            msg: "Failed to fetch services (${response.statusCode})");
      }
    } catch (e) {
      print("fetchServices(): Exception: $e");
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
    final name = nameController.text.trim();
    final durationMinutes = int.parse(durationController.text.trim());
    final basePrice = int.parse(basePriceController.text.trim());
    final bathroomRate = int.parse(bathroomRateController.text.trim());
    final roomRate = int.parse(roomRateController.text.trim());
    final squareFootPrice = int.parse(squareFootPriceController.text.trim());

    final payload = {
      "name": name,
      "durationMinutes": durationMinutes,
      "base_price": basePrice,
      "bathroom_rate": bathroomRate,
      "room_rate": roomRate,
      "square_foot_price": squareFootPrice,
    };

    print(" createService(): Preparing to POST");
    print(" URL: $baseUrl/services");
    print("Headers: $authHeader");
    print(" Body: ${json.encode(payload)}");

    isLoading = true;
    update();

    try {
      final response = await http.post(
        Uri.parse("$baseUrl/services"),
        headers: authHeader,
        body: json.encode(payload),
      );
      print(" Response status: ${response.statusCode}");
      print(" Response body: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        Fluttertoast.showToast(msg: "Service created successfully");
        Navigator.of(context).pop();
        clearText();
        await fetchServices();
      } else {
        print(" createService(): HTTP ${response.statusCode}");
        Fluttertoast.showToast(
            msg: "Error: Failed to create service (${response.statusCode})");
      }
    } catch (e) {
      print(" createService(): Exception: $e");
      Fluttertoast.showToast(msg: "Something went wrong: $e");
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> updateService(String serviceID, BuildContext context) async {
    isLoading = true;
    update();

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("access_token");

    final body = {
      "name": nameController.text,
      "durationMinutes": int.tryParse(durationController.text) ?? 0,
      "basePrice": double.tryParse(basePriceController.text) ?? 0.0,
      "bathroomRate": double.tryParse(bathroomRateController.text) ?? 0.0,
      "roomRate": double.tryParse(roomRateController.text) ?? 0.0,
      "squareFootPrice": double.tryParse(squareFootPriceController.text) ?? 0.0,
    };

    final response = await http.patch(
      Uri.parse('$baseUrl/services/$serviceID'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(body),
    );

    isLoading = false;
    update();

    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg: "Service updated successfully");
      Navigator.pop(context);
      fetchServices(); // refresh list
    } else {
      Fluttertoast.showToast(msg: "Failed to update service");
      debugPrint("Error: ${response.statusCode} - ${response.body}");
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
