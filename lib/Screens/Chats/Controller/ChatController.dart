import 'dart:convert';
import 'dart:developer';
import 'package:cleanby_maria/Screens/Chats/ChatScreen.dart';
import 'package:cleanby_maria/Screens/Chats/Models/ChatModel.dart';
import 'package:cleanby_maria/Screens/Chats/Models/SessionModel.dart';
import 'package:cleanby_maria/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:socket_io_client/socket_io_client.dart';

class Chatcontroller extends GetxController with WidgetsBindingObserver {
  late Socket socket;

  // Plain int — GetBuilder + update() handles UI rebuild
  int unReadMessage = 0;

  String currentUser = "0";
  String currentUserName = "";

  // FIX: sessionID is String — sentinel is "0" not int 0
  String sessionID = "0";

  bool isDonar = false;

  ScrollController scrollController = ScrollController();
  TextEditingController messageText = TextEditingController();
  List<ChatMessage> messageList = [];
  List<ChatSession> chatSessionList = [];

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
    startWebsocketConnection();
    loadAllSessions();
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    try {
      socket.disconnect();
      socket.dispose();
    } catch (e) {
      log("Error closing socket: $e");
    }
    messageText.dispose();
    scrollController.dispose();
    super.onClose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    log('App Lifecycle State: $state', name: 'ChatController');
    if (state == AppLifecycleState.resumed) {
      messageList = [];

      _handleAppResumed();
    }
  }

  void _handleAppResumed() {
    if (socket.disconnected) {
      log('🔄 App resumed: Socket disconnected, attempting reconnect...',
          name: 'ChatController');
      socket.connect();
    } else {
      log('✅ App resumed: Socket is already connected.',
          name: 'ChatController');
    }

    loadAllSessions();

    // FIX: String "0" comparison — was: sessionID != 0 (int), always true
    if (sessionID != "0") {
      loadUserFullMessage(sID: sessionID);
    }
  }

  Future<void> startWebsocketConnection() async {
    socket = io(
      "wss://staging.cleanmaria.com/chat",
      OptionBuilder()
          .setTransports(['websocket', 'polling'])
          .setAuth({"Authorization": "Bearer $authToken"})
          .setExtraHeaders({"Authorization": "Bearer $authToken"})
          .enableAutoConnect()
          .setReconnectionDelay(1000)
          .setReconnectionAttempts(double.infinity)
          .build(),
    );

    socket.onConnect((_) {
      log('✅ Connected to chat socket', name: 'ChatController');
    });

    socket.onDisconnect((reason) {
      log('❌ Disconnected from chat socket: $reason', name: 'ChatController');
    });

    socket.onConnectError((data) {
      log('⚠️ Connect Error: $data', name: 'ChatController');
    });

    socket.onError((data) {
      log('⚠️ Socket error: $data', name: 'ChatController');
    });

    // ── messagesRead ──────────────────────────────────────────────────────────
    socket.on('messagesRead', (data) {
      final map = Map<String, dynamic>.from(data);
      if (map['messageIds'] != null) {
        // FIX: Parse IDs as String not int — String == int is always false in
        // Dart so updateReadStatus never found a match and badge never cleared
        final ids = List<String>.from(
          (map['messageIds'] as List).map((e) => e.toString()),
        );
        for (final id in ids) {
          updateReadStatus(id);
        }
      }
    });

    socket.on('messagesDelivered', (data) {
      // Handle delivered status if needed
    });

    // ── newMessageSent (own message confirmed by server) ──────────────────────
    socket.on('newMessageSent', (data) {
      log("new Message sent -- > $data");
      final message = ChatMessage.fromJson(Map<String, dynamic>.from(data));

      if (message.sessionId == sessionID) {
        // Guard against duplicates if message was optimistically added
        final exists = messageList.any((m) => m.id == message.id);
        if (!exists) {
          messageList.add(message);
        }
        _scrollToBottom();
      }

      if (data["session"] != null) {
        final session = ChatSession.fromJson(
          Map<String, dynamic>.from(data["session"]),
        );
        updateSessionLastMessages(session);
      }

      update();
    });

    // ── newMessage (incoming from other user) ─────────────────────────────────
    socket.on('newMessage', (data) {
      log("new Message get -- > $data");
      final message = ChatMessage.fromJson(Map<String, dynamic>.from(data));

      if (message.sessionId == sessionID) {
        messageList.add(message);

        if (message.senderId != userID) {
          // User is actively in this session — mark as read immediately
          socket.emit('markAsRead', {
            'messageIds': [message.id],
          });
          _scrollToBottom();
        }
      }

      // FIX: Only emit markAsDelivered for OTHER users' messages —
      // was firing for own messages too, causing incorrect delivery receipts
      if (message.senderId != userID) {
        socket.emit('markAsDelivered', {
          'messageIds': [message.id],
        });
      }

      if (data["session"] != null) {
        final session = ChatSession.fromJson(
          Map<String, dynamic>.from(data["session"]),
        );
        updateSessionLastMessages(session);
      }

      update();
    });
  }

  void _scrollToBottom() {
    if (scrollController.hasClients) {
      Future.delayed(const Duration(milliseconds: 100), () {
        scrollController.animateTo(
          0.0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    }
  }

  // ── Unread count ────────────────────────────────────────────────────────────

  void updateUnreadMessage() {
    int total = 0;
    for (final session in chatSessionList) {
      total += session.unreadCount;
    }
    unReadMessage = total;
    update(); // triggers GetBuilder to rebuild
  }

  // ── Session helpers ─────────────────────────────────────────────────────────

  void updateSessionLastMessages(ChatSession session) {
    final index = chatSessionList.indexWhere((s) => s.id == session.id);
    if (index != -1) {
      chatSessionList.removeAt(index);
    }
    chatSessionList.insert(0, session);
    updateUnreadMessage();
  }

  // ── Mark as read ────────────────────────────────────────────────────────────

  void markAllAsRead() {
    final List<String> messageIds = [];

    for (final msg in messageList) {
      if (!msg.isRead && msg.senderId != userID) {
        msg.isRead = true;
        messageIds.add(msg.id);
      }
    }

    // Zero out unread count for the active session
    final sessionIndex = chatSessionList.indexWhere((s) => s.id == sessionID);
    if (sessionIndex != -1) {
      chatSessionList[sessionIndex].unreadCount = 0;
    }

    updateUnreadMessage();

    if (messageIds.isNotEmpty) {
      socket.emit('markAsRead', {'messageIds': messageIds});
    } else {
      update();
    }
  }

  // FIX: Parameter is String not int
  // Was: void updateReadStatus(int id) — String == int always false in Dart
  // so the message was never found and the badge count never went down
  void updateReadStatus(String id) {
    // Mark the matching message as read
    for (final msg in messageList) {
      if (msg.id == id) {
        msg.isRead = true;
        break;
      }
    }

    // FIX: Recount from source of truth instead of decrementing by 1.
    // Decrement was wrong because:
    //   - Only triggered when lastMessage.id matched (rare edge case)
    //   - Bulk reads (e.g. 5 at once) only decremented count by 1
    //   - Could drift out of sync with actual unread messages in the list
    final sessionIndex = chatSessionList.indexWhere((s) => s.id == sessionID);
    if (sessionIndex != -1) {
      chatSessionList[sessionIndex].unreadCount =
          messageList.where((m) => !m.isRead && m.senderId != userID).length;
    }

    updateUnreadMessage();
  }

  // ── Send message ────────────────────────────────────────────────────────────

  void sentMessage(String message) {
    if (message.trim().isEmpty) return;
    log("send message function -> $currentUser");
    socket.emit('sendMessage', {
      'recipientId': currentUser,
      'content': message.trim(),
    });
    messageText.clear();
  }

  // ── Navigation ──────────────────────────────────────────────────────────────

  void openChatUser({
    required String userID,
    String session = "0",
    required bool isDonar,
    required String userName,
  }) {
    currentUser = userID;
    currentUserName = userName;
    this.isDonar = isDonar;

    Get.to(() => ChatScreen(), transition: Transition.rightToLeft);

    if (session != "0") {
      sessionID = session;
      loadUserFullMessage(sID: sessionID);
    } else {
      loadSessionData(userID);
    }
  }

  // ── API calls ───────────────────────────────────────────────────────────────

  void loadUserFullMessage({required String sID}) async {
    final response = await get(
      Uri.parse("$baseUrl/chat/sessions/$sID/messages"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $authToken',
      },
    );

    log("load full message — status: ${response.statusCode}");

    if (response.statusCode == 200 || response.statusCode == 201) {
      messageList.clear();
      sessionID = sID;
      final dataResponse = json.decode(response.body);

      for (final data in dataResponse["messages"]) {
        messageList.add(ChatMessage.fromJson(data));
      }

      update();
      markAllAsRead();
      _scrollToBottom();
    }
  }

  void loadAllSessions() async {
    final response = await get(
      Uri.parse("$baseUrl/chat/sessions?page=1&limit=100"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $authToken',
      },
    );

    log("load All Sessions — status: ${response.statusCode}");

    if (response.statusCode == 200 || response.statusCode == 201) {
      chatSessionList.clear();
      final dataResponse = json.decode(response.body);

      for (final data in dataResponse["sessions"]) {
        chatSessionList.add(ChatSession.fromJson(data));
      }

      updateUnreadMessage();
    }
  }

  void loadSessionData(String userID) async {
    final response = await get(
      Uri.parse("$baseUrl/chat/session/$userID"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $authToken',
      },
    );

    log("load session data — status: ${response.statusCode}");

    if (response.statusCode == 200) {
      final dataResponse = json.decode(response.body);
      final String sID = dataResponse["id"];
      loadUserFullMessage(sID: sID);
    }
  }

  // ── Utility ─────────────────────────────────────────────────────────────────

  String timeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final diff = now.difference(dateTime);

    if (diff.isNegative || diff.inSeconds < 60) return "just now";
    if (diff.inMinutes < 60) {
      final m = diff.inMinutes;
      return m == 1 ? "1 min ago" : "$m mins ago";
    }
    if (diff.inHours < 24) {
      final h = diff.inHours;
      return h == 1 ? "1 hr ago" : "$h hrs ago";
    }
    if (diff.inDays < 7) {
      final d = diff.inDays;
      return d == 1 ? "1 day ago" : "$d days ago";
    }
    if (diff.inDays < 30) {
      final weeks = (diff.inDays / 7).floor();
      return weeks == 1 ? "last week" : "$weeks weeks ago";
    }
    if (diff.inDays < 365) {
      final months = (diff.inDays / 30).floor();
      return months == 1 ? "last month" : "$months months ago";
    }
    final years = (diff.inDays / 365).floor();
    return years == 1 ? "last year" : "$years years ago";
  }
}
