import 'package:cleanby_maria/Screens/Chats/ChatScreen.dart';
import 'package:cleanby_maria/Screens/Chats/Controller/ChatController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MessagesScreen extends StatelessWidget {
  MessagesScreen({super.key});

  Chatcontroller ctrl = Get.put(Chatcontroller());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Messages",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
        ),
      ),
      body: SafeArea(
        child: GetBuilder<Chatcontroller>(builder: (__) {
          return Column(
            children: [
              /// 🔹 SEARCH
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 16),
              //   child: TextField(
              //     decoration: InputDecoration(
              //       hintText: "Search messages...",
              //       prefixIcon: const Icon(Icons.search),
              //       filled: true,
              //       fillColor: const Color(0xFFF3F3F3),
              //       border: OutlineInputBorder(
              //         borderRadius: BorderRadius.circular(12),
              //         borderSide: BorderSide.none,
              //       ),
              //     ),
              //   ),
              // ),

              //   const SizedBox(height: 12),

              /// 🔹 MESSAGE LIST
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    for (var data in ctrl.chatSessionList)
                      _messageTile(
                        context,
                        name: data.otherUser!.name!,
                        message: (data.lastMessage != null)
                            ? data.lastMessage!.content ?? ""
                            : "",
                        time: data.lastMessageAt == null
                            ? ""
                            : ctrl.timeAgo(data.lastMessageAt!.toLocal()),
                        onTap: () {
                          ctrl.openChatUser(
                              session: data.id,
                              userID: data.otherUser!.id!,
                              isDonar: false,
                              userName: data.otherUser!.name);
                        },
                      ),
                  ],
                ),
              ),
            ],
          );
        }),
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
                  Text(name,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(message, style: const TextStyle(color: Colors.grey)),
                ],
              ),
            ),
            Text(time,
                style: const TextStyle(color: Colors.grey, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
