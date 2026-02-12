import 'api_service.dart';

class BookingService {

  static Future getBookings() async {
    return await ApiService.get("/bookings");
  }

  static Future createBooking(Map body) async {
    return await ApiService.post("/bookings", body);
  }
}
