import 'dart:convert';
import 'package:cleanby_maria/Screens/admin_cleabby_maria/Dashboard/StaffScreen/Models/StaffModel.dart';
import 'package:http/http.dart' as http;

class CreateStaffController {
  final String baseUrl;
  final String token;

  CreateStaffController({required this.baseUrl, required this.token});

  Future<void> createStaff({
    required String name,
    required String email,
    required String phone,
    required String password,
    required Function onSuccess,
    required Function(String errorMessage) onError,
  }) async {
    if (name.isEmpty || email.isEmpty || phone.isEmpty || password.isEmpty) {
      onError("Please fill all fields");
      return;
    }

    final url = '$baseUrl/auth/register';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'name': name,
          'email': email,
          'password': password,
          'role': 'staff',
        }),
      );

      if (response.statusCode == 201) {
        onSuccess();
      } else {
        onError('Failed to create staff: ${response.body}');
      }
    } catch (e) {
      onError('An error occurred: $e');
    }
  }
}




Future<void> fetchStaffData(String baseUrl, String token) async {
  final response = await http.get(
    Uri.parse('$baseUrl/users/staff'),
    headers: {'Authorization': 'Bearer $token'},
  );

 if (response.statusCode == 200) {
    final data = json.decode(response.body);
    List<Staff> staffList = (data['data'] as List)
        .map((staffJson) => Staff.fromJson(staffJson))
        .toList();

    // Use staffList in your widget
  } else {
    throw Exception('Failed to load staff data');
  }
}
