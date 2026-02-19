import 'package:cleanby_maria/Screens/Admin/ScheduleViewScreen/ScheduleHistoryScreen.dart';
import 'package:cleanby_maria/Screens/Chats/Controller/ChatController.dart';
import 'package:cleanby_maria/Screens/Chats/messages_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
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
      backgroundColor: Color(0xffF9FAFB),
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xffF9FAFB),
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Color(0xFF18B1C5),
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
              label: "Home"),
          BottomNavigationBarItem(
              icon: Image.asset(
                "assets/v2/bookings.png",
                height: 22,
                color: _currentIndex == 1
                    ? const Color(0xff17A5C6)
                    : const Color(0xff9DB2CE),
              ),
              label: "Bookings"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.chat_bubble_outline,
                size: 22,
              ),
              label: "Inbox"),
          BottomNavigationBarItem(
              icon: Image.asset(
                "assets/v2/schedules.png",
                height: 22,
                color: _currentIndex == 3
                    ? const Color(0xff17A5C6)
                    : const Color(0xff9DB2CE),
              ),
              label: "Subscription"),
        ],
      ),
    );
  }
}
