import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static const String baseUrl = "YOUR_BASE_URL"; // change this

  static Future get(String endpoint) async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token") ?? "";

    final response = await http.get(
      Uri.parse("$baseUrl$endpoint"),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
    );

    return jsonDecode(response.body);
  }

  static Future post(String endpoint, Map body) async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token") ?? "";

    final response = await http.post(
      Uri.parse("$baseUrl$endpoint"),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
      body: jsonEncode(body),
    );

    return jsonDecode(response.body);
  }
}
