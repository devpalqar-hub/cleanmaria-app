import 'package:cleanby_maria/Screens/Admin/ScheduleViewScreen/ScheduleDetailsScreen.dart';
import 'package:cleanby_maria/Screens/Chats/Controller/ChatController.dart';
import 'package:cleanby_maria/Screens/User/new_booking/service_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class MessageTypeCard extends StatelessWidget {
  MessageTypeCard({super.key});

  Chatcontroller ctrl = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10, left: 20, right: 12),
      child: Row(
        children: [
          //  FaIcon(FontAwesomeIcons.keyboard, color: Colors.black45),
          // SizedBox(width: 20),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: primaryGreen.withOpacity(.05),
                border: Border.all(
                  color: primaryGreen.withOpacity(.1),
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              constraints: BoxConstraints(maxHeight: 50, minHeight: 45),
              child: TextField(
                controller: ctrl.messageText,
                textAlign: TextAlign.start,
                textAlignVertical: TextAlignVertical.center,
                maxLines: null,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  isCollapsed: true,
                  hintStyle: TextStyle(fontSize: 13),
                  hintText: "Enter Message",
                  isDense: true,
                ),
              ),
            ),
          ),
          SizedBox(width: 10),

          InkWell(
            onTap: () {
              if (ctrl.messageText.text.isNotEmpty) {
                ctrl.sentMessage(ctrl.messageText.text);
                ctrl.messageText.text = "";
              }
            },
            child: Icon(Icons.send, color: AppColors.teal),
          ),
        ],
      ),
    );
  }
}
