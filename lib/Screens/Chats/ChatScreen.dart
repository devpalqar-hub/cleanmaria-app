import 'package:cleanby_maria/Screens/Chats/Controller/ChatController.dart';
import 'package:cleanby_maria/Screens/Chats/Widget/MessageCard.dart';
import 'package:cleanby_maria/Screens/Chats/Widget/MessageTitleCard.dart';
import 'package:cleanby_maria/Screens/Chats/Widget/MessageTypeCard.dart';
import 'package:cleanby_maria/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/list_notifier.dart';
import 'package:get/state_manager.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  Chatcontroller ctrl = Get.find();

  @override
  void dispose() {
    // Clean up controller state when leaving chat screen
    ctrl.currentUser = "-1";
    ctrl.currentUserName = "";
    ctrl.sessionID = "-1";
    ctrl.messageList = [];
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: GetBuilder<Chatcontroller>(
          builder: (__) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MessageTitleCard(),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: SingleChildScrollView(
                      reverse: true,
                      controller: __.scrollController,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        spacing: 20,
                        children: [
                          SizedBox(height: 20),
                          for (var data in __.messageList)
                            MessageCard(
                              isRead: data.isRead,
                              isSented: data.senderId == userID,
                              message: data.content,
                              messageTime: data.createdAt.toLocal().toString(),
                            ),
                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
                MessageTypeCard(),
              ],
            );
          },
        ),
      ),
    );
  }
}
