import 'package:cleanby_maria/Screens/Admin/ScheduleViewScreen/ScheduleHistoryScreen.dart';
import 'package:cleanby_maria/Screens/Chats/Controller/ChatController.dart';
import 'package:cleanby_maria/Screens/Chats/messages_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart'; // ✅ Simplified GetX import for .tr
import '../home/home_screen.dart';
import '../bookings/booking_screen.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({super.key});

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    BookingScreen(),
    MessagesScreen(),
    ScheduleHistoryScreen(
      isUser: true,
    ),
  ];

  Chatcontroller cctrl = Get.put(Chatcontroller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF9FAFB),
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xffF9FAFB),
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF18B1C5),
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Image.asset(
                "assets/v2/home.png",
                height: 22,
                color: _currentIndex == 0
                    ? const Color(0xff17A5C6)
                    : const Color(0xff9DB2CE),
              ),
              label: "Home".tr), // ✅ Added .tr
          BottomNavigationBarItem(
              icon: Image.asset(
                "assets/v2/bookings.png",
                height: 22,
                color: _currentIndex == 1
                    ? const Color(0xff17A5C6)
                    : const Color(0xff9DB2CE),
              ),
              label: "Bookings".tr), // ✅ Added .tr
          BottomNavigationBarItem(
              icon: const Icon(
                Icons.chat_bubble_outline,
                size: 22,
              ),
              label: "Inbox".tr), // ✅ Added .tr
          BottomNavigationBarItem(
              icon: Image.asset(
                "assets/v2/schedules.png",
                height: 22,
                color: _currentIndex == 3
                    ? const Color(0xff17A5C6)
                    : const Color(0xff9DB2CE),
              ),
              label: "Subscription".tr), // ✅ Added .tr
        ],
      ),
    );
  }
}
