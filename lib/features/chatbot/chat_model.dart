class ChatModel {
  final String message;
  final bool isUser;
  final DateTime time;

  const ChatModel({
    required this.message,
    required this.isUser,
    required this.time,
  });

  /// 🔹 JSON → Model
  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      message: (json['message'] as String?)?.trim() ?? '',
      isUser: json['isUser'] as bool? ?? false,
      time: _parseDate(json['time']),
    );
  }

  /// 🔹 Model → JSON
  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'isUser': isUser,
      'time': time.toIso8601String(),
    };
  }

  /// 🔹 Safe Date Parser
  static DateTime _parseDate(dynamic value) {
    if (value is String) {
      return DateTime.tryParse(value) ?? DateTime.now();
    }
    return DateTime.now();
  }

  /// 🔹 CopyWith (immutable update)
  ChatModel copyWith({String? message, bool? isUser, DateTime? time}) {
    return ChatModel(
      message: message ?? this.message,
      isUser: isUser ?? this.isUser,
      time: time ?? this.time,
    );
  }

  /// 🔹 Equality (important for lists, state management)
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ChatModel &&
        other.message == message &&
        other.isUser == isUser &&
        other.time == time;
  }

  @override
  int get hashCode => message.hashCode ^ isUser.hashCode ^ time.hashCode;

  /// 🔹 Debug Friendly
  @override
  String toString() {
    return 'ChatModel(message: $message, isUser: $isUser, time: $time)';
  }
}
