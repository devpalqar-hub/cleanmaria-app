import 'dart:convert';

import 'package:cleanby_maria/Screens/Admin/ScheduleViewScreen/Models/ScheduleItemModel.dart';
import 'package:cleanby_maria/Screens/AuthenticationScreen/AutheticationScreen.dart';
import 'package:cleanby_maria/Screens/User/home/Models/UserProfileModel.dart';
import 'package:cleanby_maria/main.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserHomeController extends GetxController {
  List<ScheduleItemModel> upcommingSchedules = [];
  bool isLoading = false;
  UserProfileModel? user;
  bool isPageLoading = false;

  fetchNextUpCommingSchedules() async {
    upcommingSchedules = [];
    isLoading = true;
    update();

    var response = await get(
      Uri.parse(baseUrl + "/bookings/next-upcoming-schedules"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $authToken',
      },
    );
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      for (var schedule in data["data"]["data"]) {
        upcommingSchedules.add(ScheduleItemModel.fromJson(schedule));
      }
    }
    isLoading = false;
    update();
  }

  fetchUserProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userID = prefs.getString("user_id") ?? "";
    isPageLoading = true;
    update();
    final response = await get(
      Uri.parse(
        baseUrl + "/users/$userID",
      ),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $authToken',
      },
    );
    print(response.body);
    if (response.statusCode == 200) {
      try {
        user = UserProfileModel.fromJson(json.decode(response.body)["data"]);
      } finally {
        update();
      }
    } else {
      await prefs.clear();
      Get.offAll(() => AuthenticationScreen());
    }
    isPageLoading = false;
    update();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    //  fetchNextUpCommingSchedules();
    fetchUserProfile();
  }
}
