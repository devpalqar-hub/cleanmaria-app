class ChatMessage {
  final String id;
  final String content;
  final String senderId;
  final String sessionId;

  bool isRead;
  final DateTime? readAt;
  final bool isDelivered;
  final DateTime? deliveredAt;
  final DateTime? sentAt;

  final DateTime createdAt;
  // final DateTime updatedAt;

  ChatMessage({
    required this.id,
    required this.content,
    required this.senderId,
    required this.sessionId,
    required this.isRead,
    required this.readAt,
    required this.isDelivered,
    required this.deliveredAt,
    required this.sentAt,
    required this.createdAt,
    //    required this.updatedAt,
  });

  /// JSON → Dart
  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    DateTime? _parseDate(dynamic value) {
      if (value == null) return null;
      return DateTime.parse(value as String);
    }

    return ChatMessage(
      id: json['id'] as String,
      content: json['content'] as String,
      senderId: json['senderId'] as String,
      sessionId: json['sessionId'] as String,
      isRead: json['isRead'] as bool,
      readAt: _parseDate(json['readAt']),
      isDelivered: json['isDelivered'] as bool,
      deliveredAt: _parseDate(json['deliveredAt']),
      sentAt: _parseDate(json['sentAt']),
      createdAt: DateTime.parse(json['createdAt'] as String),
      //updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  /// Dart → JSON
  Map<String, dynamic> toJson() {
    String? _formatDate(DateTime? date) => date?.toIso8601String();

    return {
      'id': id,
      'content': content,
      'senderId': senderId,
      'sessionId': sessionId,
      'isRead': isRead,
      'readAt': _formatDate(readAt),
      'isDelivered': isDelivered,
      'deliveredAt': _formatDate(deliveredAt),
      'sentAt': _formatDate(sentAt),
      'createdAt': createdAt.toIso8601String(),
      //'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
