import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'chat_screen.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          /// 🔹 CUSTOM APP BAR (instead of Scaffold)
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "Messages",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Icon(Icons.chat_bubble_outline),
              ],
            ),
          ),

          /// 🔹 SEARCH
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search messages...",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: const Color(0xFFF3F3F3),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          const SizedBox(height: 12),

          /// 🔹 MESSAGE LIST
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _messageTile(
                  context,
                  name: "Sarah Jenkins",
                  message: "Got it. See you soon!",
                  time: "1:33 PM",
                  onTap: () {
                    Get.to(() => const ChatScreen());
                  },
                ),
                _messageTile(
                  context,
                  name: "CleanMaria Support",
                  message: "How can we help you today?",
                  time: "Yesterday",
                ),
                _messageTile(
                  context,
                  name: "Michael Ross",
                  message: "Thanks for the tip!",
                  time: "Oct 20",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _messageTile(
      BuildContext context, {
        required String name,
        required String message,
        required String time,
        VoidCallback? onTap,
      }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            CircleAvatar(child: Text(name[0])),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(message, style: const TextStyle(color: Colors.grey)),
                ],
              ),
            ),
            Text(time, style: const TextStyle(color: Colors.grey, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
