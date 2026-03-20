// import 'dart:convert';
// import 'package:cleanby_maria/main.dart';
// import 'package:http/http.dart' as http;
// import 'package:intl/intl.dart';

// class AppController {
//   static final AppController _instance = AppController._internal();

//   factory AppController() => _instance;

//   AppController._internal();

//   Future<List<Map<String, dynamic>>> fetchServices() async {
//     final response = await http.get(Uri.parse('$baseUrl/services'));

//     print("fetchServices - Status Code: ${response.statusCode}");
//     print("fetchServices - Response Body: ${response.body}");

//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body);
//       return List<Map<String, dynamic>>.from(data['data']);
//     } else {
//       throw Exception('Failed to load services');
//     }
//   }

//   Future<Map<String, dynamic>> calculateEstimate({
//   required String serviceId,
//   required int noOfRooms,
//   required int noOfBathrooms,
//   required int squareFeet,
//   required bool isEcoCleaning,
//   required bool materialsProvidedByClient,
// }) async {
//   final requestBody = {
//     'service_id': serviceId,
//     'no_of_rooms': noOfRooms,
//     'no_of_bathrooms': noOfBathrooms,
//     'square_feet': squareFeet,
//     'isEcoCleaning': isEcoCleaning,
//     'materialsProvidedByClient': materialsProvidedByClient,
//   };

//   final uri = Uri.parse('$baseUrl/services/price-estimate');

//   print("📤 [Request] Calculating Estimate...");
//   print("🔗 URL: $uri");
//   print("📝 Body: ${jsonEncode(requestBody)}");

//   try {
//     final response = await http.post(
//       uri,
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode(requestBody),
//     );

//     print("📥 [Response] Status Code: ${response.statusCode}");
//     print("📥 [Response Body]: ${response.body}");

//     if (response.statusCode == 201) {
//       final data = jsonDecode(response.body);

//       final estimates = List<Map<String, dynamic>>.from(data['data']['estimates']);
//       final totalDuration =(data['data']['totalDuration']);

//       print("✅ Estimates: $estimates");
//       print("⏱️ Total Duration (mins): $totalDuration");

//       return {
//         'estimates': estimates,
//         'totalDuration': totalDuration,
//       };
//     } else {
//       throw Exception('❌ ${'failed_to_calculate_estimate'.tr}');
//     }
//   } catch (e) {
//     print("🔥 calculateEstimate - Error: $e");
//     rethrow;
//   }
// }

// Future<List<Map<String, dynamic>>> fetchTimeSlots({
//   required DateTime date,
//   required int totalDuration,
//   required String recurringTypeId,
// }) async {
//   final formattedDate = DateFormat('yyyy-MM-dd').format(date);
//   final uri = Uri.parse(
//     '$baseUrl/scheduler/time-slots?date=$formattedDate&planId=$recurringTypeId&durationMins=$totalDuration',
//   );

//   print("📤 [Request] Fetching time slots...");
//   print("🔗 Full URL: $uri");

//   try {
//     final response = await http.get(uri);

//     print("📥 [Response] Status Code: ${response.statusCode}");
//     print("📥 [Response Body]: ${response.body}");

//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body);

//       final allSlots = List<Map<String, dynamic>>.from(data['data']);

//       print("📊 All Time Slots:");
//       for (var slot in allSlots) {
//         print("⏰ ${slot['time']} — Available: ${slot['isAvailable']}");
//       }

//       final availableSlots = allSlots
//           .where((slot) => slot['isAvailable'] == true)
//           .toList();

//       print("✅ Filtered Available Slots:");
//       for (var slot in availableSlots) {
//         print("🟢 ${slot['time']}");
//       }

//       return availableSlots;
//     } else {
//       print("❌ Failed to fetch time slots - Status: ${response.statusCode}");
//       throw Exception("Failed to fetch time slots");
//     }
//   } catch (e) {
//     print("🔥 fetchTimeSlots - Error: $e");
//     rethrow;
//   }
// }

 
// }