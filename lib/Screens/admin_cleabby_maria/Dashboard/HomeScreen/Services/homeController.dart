import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:cleanby_maria/Screens/admin_cleabby_maria/Dashboard/HomeScreen/Model/homeModel';
import 'package:cleanby_maria/main.dart';

class HomeController extends GetxController {
  var isLoading = false.obs;
  var accessToken = ''.obs;
 late UserModel user;
 String userName = "";

  Future<void> login(String email, String password) async {
    try {
      isLoading(true);
      var url = Uri.parse('$baseUrl/auth/login'); 
      var response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 201) {
        var data = jsonDecode(response.body);
        accessToken.value = data['access_token'];
        userName =data["name"];
        user = UserModel.fromJson(data);
      } else {
        throw Exception("Login failed");
      }
    } catch (e) {
      print("Error: $e");
    } finally {
      isLoading(false);
    }
  }
}
