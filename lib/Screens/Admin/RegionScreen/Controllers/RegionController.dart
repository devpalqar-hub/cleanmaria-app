import 'dart:convert';
import 'package:cleanby_maria/main.dart';
import 'package:cleanby_maria/Screens/Admin/RegionScreen/Models/ZoneModel.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class RegionController extends GetxController {
  final nameController = TextEditingController();
  final codeController = TextEditingController();

  List<ZoneModel> zones = [];
  bool isLoading = false;

  // Fetch all zones from API
  Future<void> fetchZones() async {
    isLoading = true;
    update();

    try {
      final url = Uri.parse('$baseUrl/zones?includeInactive=true');

      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $authToken',
      };

      print('[FETCH ZONES] URL: $url');
      print('[FETCH ZONES] Headers: $headers');

      final response = await http.get(url, headers: headers);

      print('[FETCH ZONES] Status Code: ${response.statusCode}');
      print('[FETCH ZONES] Response: ${response.body}');

      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body);
        zones = responseData
            .map((zone) => ZoneModel.fromJson(zone as Map<String, dynamic>))
            .toList();
        print('[FETCH ZONES] Loaded ${zones.length} zones');
      } else {
        print('[FETCH ZONES] Error: ${response.statusCode}');
        Fluttertoast.showToast(
          msg: 'Failed to load zones',
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.red.shade400,
          textColor: Colors.white,
        );
      }
    } catch (e) {
      print('[FETCH ZONES] Exception: $e');
      Fluttertoast.showToast(
        msg: 'Error loading zones: ${e.toString()}',
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.red.shade400,
        textColor: Colors.white,
      );
    } finally {
      isLoading = false;
      update();
    }
  }

  // Create new region
  Future<void> createRegion() async {
    if (nameController.text.isEmpty || codeController.text.isEmpty) {
      Fluttertoast.showToast(
        msg: 'Please fill all fields',
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.red.shade300,
      );
      return;
    }

    isLoading = true;
    update();

    try {
      final url = Uri.parse('$baseUrl/zones');

      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $authToken',
      };

      final body = jsonEncode({
        'name': nameController.text.trim(),
        'code': codeController.text.trim(),
        'isActive': true,
      });

      print('[CREATE REGION] URL: $url');
      print('[CREATE REGION] Headers: $headers');
      print('[CREATE REGION] Body: $body');

      void onInit() {
        super.onInit();
        fetchZones();
      }

      @override
      final response = await http.post(
        url,
        headers: headers,
        body: body,
      );

      print('[CREATE REGION] Status Code: ${response.statusCode}');
      print('[CREATE REGION] Response: ${response.body}');

      if (response.statusCode == 201 || response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        Fluttertoast.showToast(
          msg: 'Region created successfully',
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.green.shade400,
          textColor: Colors.white,
        );

        // Clear fields
        nameController.clear();
        codeController.clear();

        // Close bottom sheet
        Get.back(result: responseData['data']);
      } else {
        final errorData = jsonDecode(response.body);
        final errorMessage = errorData['message'] ?? 'Failed to create region';

        Fluttertoast.showToast(
          msg: errorMessage,
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.red.shade400,
          textColor: Colors.white,
        );
      }
    } catch (e) {
      print('[CREATE REGION] Error: $e');
      Fluttertoast.showToast(
        msg: 'Error: ${e.toString()}',
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.red.shade400,
        textColor: Colors.white,
      );
    } finally {
      isLoading = false;
      update();
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    codeController.dispose();
    super.onClose();
  }
}
