// controllers/estimation_controller.dart

import 'dart:convert';
import 'package:cleanby_maria/main.dart';
import 'package:http/http.dart' as http;

class EstimationController {
  
  // Fetch the list of services
  Future<List<Map<String, dynamic>>> fetchServices() async {
    final response = await http.get(Uri.parse('$baseUrl/services'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return List<Map<String, dynamic>>.from(data['data']);
    } else {
      throw Exception('Failed to load services');
    }
  }

  // Calculate price estimate
  Future<List<Map<String, dynamic>>> calculateEstimate({
    required String serviceId,
    required int noOfRooms,
    required int noOfBathrooms,
    required int squareFeet,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/services/price-estimate'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'service_id': serviceId,
        'no_of_rooms': noOfRooms,
        'no_of_bathrooms': noOfBathrooms,
        'square_feet': squareFeet,
      }),
    );

    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      return List<Map<String, dynamic>>.from(data['data']['estimates']);
    } else {
      throw Exception('Failed to calculate estimate');
    }
  }
}
