class ChatModel {
  final String message;
  final bool isUser;
  final DateTime time;

  const ChatModel({
    required this.message,
    required this.isUser,
    required this.time,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      message: json['message'] ?? '',
      isUser: json['isUser'] ?? false,
      time: DateTime.tryParse(json['time'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'isUser': isUser,
      'time': time.toIso8601String(),
    };
  }

  ChatModel copyWith({
    String? message,
    bool? isUser,
    DateTime? time,
  }) {
    return ChatModel(
      message: message ?? this.message,
      isUser: isUser ?? this.isUser,
      time: time ?? this.time,
    );
  }
}