import 'dart:convert';
import 'package:cleanby_maria/Screens/Admin/RegionScreen/Controllers/RegionController.dart';
import 'package:cleanby_maria/main.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class RegionDetailsController extends GetxController {
  final nameController = TextEditingController();
  final pincodeController = TextEditingController();

  String? selectedStaffId;
  String? selectedStaffName;
  List<dynamic> staffList = [];
  Map<String, dynamic> zoneDetails = {};
  String? currentZoneId;
  bool isLoading = false;
  bool isStaffLoading = false;
  bool isZoneLoading = false;

  @override
  void onInit() {
    super.onInit();
    fetchStaff();
  }

  // Update zone
  Future<bool> updateZone(String zoneId, String name, bool isActive) async {
    isLoading = true;
    update();

    try {
      final url = Uri.parse('$baseUrl/zones/$zoneId');

      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $authToken',
      };

      final body = jsonEncode({
        'name': name,
        'isActive': isActive,
      });

      print('[UPDATE ZONE] URL: $url');
      print('[UPDATE ZONE] Body: $body');

      final response = await http.patch(
        url,
        headers: headers,
        body: body,
      );

      print('[UPDATE ZONE] Status: ${response.statusCode}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        Fluttertoast.showToast(
          msg: 'Zone updated successfully',
          backgroundColor: Colors.green.shade400,
          textColor: Colors.white,
        );
        await fetchZoneDetails(zoneId);
        _refreshZoneList();
        return true;
      } else {
        final errorData = jsonDecode(response.body);
        Fluttertoast.showToast(
          msg: errorData['message'] ?? 'Failed to update zone',
          backgroundColor: Colors.red.shade400,
          textColor: Colors.white,
        );
        return false;
      }
    } catch (e) {
      print('[UPDATE ZONE] Error: $e');
      Fluttertoast.showToast(
        msg: 'Error: ${e.toString()}',
        backgroundColor: Colors.red.shade400,
        textColor: Colors.white,
      );
      return false;
    } finally {
      isLoading = false;
      update();
    }
  }

  // Assign staff to zone
  Future<bool> assignStaff(String zoneId, String staffId) async {
    isLoading = true;
    update();

    try {
      final url = Uri.parse('$baseUrl/zones/staff');

      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $authToken',
      };

      final body = jsonEncode({
        'staffId': staffId,
        'zoneId': zoneId,
      });

      print('[ASSIGN STAFF] URL: $url');
      print('[ASSIGN STAFF] Body: $body');

      final response = await http.post(
        url,
        headers: headers,
        body: body,
      );

      print('[ASSIGN STAFF] Status: ${response.statusCode}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        Fluttertoast.showToast(
          msg: 'Staff assigned successfully',
          backgroundColor: Colors.green.shade400,
          textColor: Colors.white,
        );
        selectedStaffId = null;
        selectedStaffName = null;
        pincodeController.clear();
        await fetchZoneDetails(zoneId);
        _refreshZoneList();
        return true;
      } else {
        final errorData = jsonDecode(response.body);
        Fluttertoast.showToast(
          msg: errorData['message'] ?? 'Failed to assign staff',
          backgroundColor: Colors.red.shade400,
          textColor: Colors.white,
        );
        return false;
      }
    } catch (e) {
      print('[ASSIGN STAFF] Error: $e');
      Fluttertoast.showToast(
        msg: 'Error: ${e.toString()}',
        backgroundColor: Colors.red.shade400,
        textColor: Colors.white,
      );
      return false;
    } finally {
      isLoading = false;
      update();
    }
  }

  // Assign pincode to zone
  Future<bool> assignPincode(String zoneId, String code, bool isActive) async {
    if (code.isEmpty) {
      Fluttertoast.showToast(
        msg: 'Please enter a pincode',
        backgroundColor: Colors.red.shade400,
        textColor: Colors.white,
      );
      return false;
    }

    isLoading = true;
    update();

    try {
      final url = Uri.parse('$baseUrl/zones/pincodes');

      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $authToken',
      };

      final body = jsonEncode({
        'code': code,
        'zoneId': zoneId,
        'isActive': isActive,
      });

      print('[ASSIGN PINCODE] URL: $url');
      print('[ASSIGN PINCODE] Body: $body');

      final response = await http.post(
        url,
        headers: headers,
        body: body,
      );

      print('[ASSIGN PINCODE] Status: ${response.statusCode}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        Fluttertoast.showToast(
          msg: 'Pincode assigned successfully',
          backgroundColor: Colors.green.shade400,
          textColor: Colors.white,
        );
        pincodeController.clear();
        await fetchZoneDetails(zoneId);
        _refreshZoneList();
        return true;
      } else {
        final errorData = jsonDecode(response.body);
        Fluttertoast.showToast(
          msg: errorData['message'] ?? 'Failed to assign pincode',
          backgroundColor: Colors.red.shade400,
          textColor: Colors.white,
        );
        return false;
      }
    } catch (e) {
      print('[ASSIGN PINCODE] Error: $e');
      Fluttertoast.showToast(
        msg: 'Error: ${e.toString()}',
        backgroundColor: Colors.red.shade400,
        textColor: Colors.white,
      );
      return false;
    } finally {
      isLoading = false;
      update();
    }
  }

  // Delete/disable zone
  Future<bool> deleteZone(String zoneId) async {
    isLoading = true;
    update();

    try {
      final url = Uri.parse('$baseUrl/zones/$zoneId');

      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $authToken',
      };

      print('[DELETE ZONE] URL: $url');

      final response = await http.delete(
        url,
        headers: headers,
      );

      print('[DELETE ZONE] Status: ${response.statusCode}');

      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 204) {
        Fluttertoast.showToast(
          msg: 'Zone deleted successfully',
          backgroundColor: Colors.green.shade400,
          textColor: Colors.white,
        );
        _refreshZoneList();
        Get.back();
        return true;
      } else {
        final errorData = jsonDecode(response.body);
        Fluttertoast.showToast(
          msg: errorData['message'] ?? 'Failed to delete zone',
          backgroundColor: Colors.red.shade400,
          textColor: Colors.white,
        );
        return false;
      }
    } catch (e) {
      print('[DELETE ZONE] Error: $e');
      Fluttertoast.showToast(
        msg: 'Error: ${e.toString()}',
        backgroundColor: Colors.red.shade400,
        textColor: Colors.white,
      );
      return false;
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> fetchStaff() async {
    isStaffLoading = true;
    update();

    try {
      final url = Uri.parse('$baseUrl/users/staff');

      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $authToken',
      };

      print('[FETCH STAFF] URL: $url');

      final response = await http.get(
        url,
        headers: headers,
      );

      print('[FETCH STAFF] Status: ${response.statusCode}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        final list = data['data'];

        if (list is List) {
          staffList = list;
        } else {
          staffList = [];
        }
      } else {
        final errorData = jsonDecode(response.body);
        Fluttertoast.showToast(
          msg: errorData['message'] ?? 'Failed to fetch staff',
          backgroundColor: Colors.red.shade400,
          textColor: Colors.white,
        );
      }
    } catch (e) {
      print('[FETCH STAFF] Error: $e');
      Fluttertoast.showToast(
        msg: 'Error: ${e.toString()}',
        backgroundColor: Colors.red.shade400,
        textColor: Colors.white,
      );
    } finally {
      isStaffLoading = false;
      update();
    }
  }

  Future<void> fetchZoneDetails(String zoneId) async {
    isZoneLoading = true;
    currentZoneId = zoneId;
    update();

    try {
      final url = Uri.parse('$baseUrl/zones/$zoneId');

      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $authToken',
      };

      print('[FETCH ZONE DETAILS] URL: $url');

      final response = await http.get(
        url,
        headers: headers,
      );

      print('[FETCH ZONE DETAILS] Status: ${response.statusCode}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        if (data is Map<String, dynamic>) {
          final details = data['data'];
          if (details is Map<String, dynamic>) {
            zoneDetails = details;
          } else {
            zoneDetails = data;
          }
        } else {
          zoneDetails = {};
        }
      } else {
        final errorData = jsonDecode(response.body);
        Fluttertoast.showToast(
          msg: errorData['message'] ?? 'Failed to fetch zone details',
          backgroundColor: Colors.red.shade400,
          textColor: Colors.white,
        );
      }
    } catch (e) {
      print('[FETCH ZONE DETAILS] Error: $e');
      Fluttertoast.showToast(
        msg: 'Error: ${e.toString()}',
        backgroundColor: Colors.red.shade400,
        textColor: Colors.white,
      );
    } finally {
      isZoneLoading = false;
      update();
    }
  }

  void _refreshZoneList() {
    if (Get.isRegistered<RegionController>()) {
      Get.find<RegionController>().fetchZones();
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    pincodeController.dispose();
    super.onClose();
  }
}
