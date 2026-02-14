import 'api_service.dart';

class AuthService {
  static Future login(String email, String password) async {
    return await ApiService.post("/login", {
      "email": email,
      "password": password,
    });
  }

  static Future generateOTP(String email) async {
    return await ApiService.post("/auth/otp/generate", {
      "email": email,
    });
  }

  static Future verifyOTP(String email, String otp) async {
    return await ApiService.post("/auth/otp/verify", {
      "email": email,
      "otp": otp,
    });
  }
}
