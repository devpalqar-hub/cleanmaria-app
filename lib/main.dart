import 'package:cleanby_maria/Screens/User/UserHomeScreen/UserHomeScreen.dart';
import 'package:cleanby_maria/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'Screens/AuthenticationScreen/AutheticationScreen.dart';
import 'Screens/Admin/HomeScreen/HomeScreen.dart';
import 'Screens/staff/DashBoardScreen.dart';

String baseUrl = (true)
    ? "https://app.cleanmaria.com/api"
    : "https://staging.cleanmaria.com/api";

String login = "";
String? userType = "";
String authToken = "";
String userID = "";

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  await messaging.requestPermission(
    alert: true,
    announcement: true,
    badge: true,
    carPlay: true,
    criticalAlert: true,
    provisional: true,
    sound: true,
  );

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(const CleanbyMaria());
}

class CleanbyMaria extends StatelessWidget {
  const CleanbyMaria({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 850),
      builder: (context, child) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Inter',
        ),
        home: SplashScreen(),
        //const SplashScreen(),
      ),
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  Future<Widget> _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String loginStatus = prefs.getString("LOGIN") ?? "";
    String userType = prefs.getString("role") ?? "";
    authToken = prefs.getString("access_token") ?? "";
    userID = prefs.getString("user_id") ?? "";

    if (loginStatus == "IN") {
      return userType == "staff"
          ? DashBoardScreen()
          : (userType == "customer")
              ? UserHomeScreen()
              : Homescreen();
    } else {
      return AuthenticationScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Widget>(
      future: _checkLoginStatus(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else {
          return snapshot.data!;
        }
      },
    );
  }
}
