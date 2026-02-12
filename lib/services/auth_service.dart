import 'api_service.dart';

class AuthService {

  static Future login(String email, String password) async {
    return await ApiService.post("/login", {
      "email": email,
      "password": password,
    });
  }

}
