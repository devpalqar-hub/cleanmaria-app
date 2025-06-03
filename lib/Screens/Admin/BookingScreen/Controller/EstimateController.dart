import 'dart:convert';
import 'package:cleanby_maria/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AppController {
  static final AppController _instance = AppController._internal();

  factory AppController() {
    return _instance;
  }

  AppController._internal();

  Future<List<Map<String, dynamic>>> fetchServices() async {
    final response = await http.get(Uri.parse('$baseUrl/services'));

    print("fetchServices - Status Code: ${response.statusCode}");
    print("fetchServices - Response Body: ${response.body}");

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return List<Map<String, dynamic>>.from(data['data']);
    } else {
      throw Exception('Failed to load services');
    }
  }
  

  
  Future<List<Map<String, dynamic>>> calculateEstimate({
    required String serviceId,
    required int noOfRooms,
    required int noOfBathrooms,
    required int squareFeet,
  }) async {
    final requestBody = {
      'service_id': serviceId,
      'no_of_rooms': noOfRooms,
      'no_of_bathrooms': noOfBathrooms,
      'square_feet': squareFeet,
    };

    print("calculateEstimate - Request Body: ${jsonEncode(requestBody)}");

    final response = await http.post(
      Uri.parse('$baseUrl/services/price-estimate'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(requestBody),
    );

    print("calculateEstimate - Status Code: ${response.statusCode}");
    print("calculateEstimate - Response Body: ${response.body}");

    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      return List<Map<String, dynamic>>.from(data['data']['estimates']);
    } else {
      throw Exception('Failed to calculate estimate');
    }
  }


  
}
