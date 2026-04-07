import 'package:flutter/material.dart';
import 'chat_model.dart';
import 'chat_service.dart';

class ChatViewModel extends ChangeNotifier {
  final ChatService _service;

  ChatViewModel({ChatService? service}) : _service = service ?? ChatService();

  final List<ChatModel> _messages = [];
  bool _isTyping = false;

  List<ChatModel> get messages => List.unmodifiable(_messages);
  bool get isTyping => _isTyping;

  Future<void> sendMessage(String text) async {
    final message = text.trim();
    if (message.isEmpty) return;

    _messages.add(
      ChatModel(message: message, isUser: true, time: DateTime.now()),
    );

    notifyListeners();
    _setTyping(true);

    try {
      final reply = await _service.sendMessage(message);

      _messages.add(
        ChatModel(
          message: reply.trim().isEmpty ? "No response received" : reply.trim(),
          isUser: false,
          time: DateTime.now(),
        ),
      );
    } catch (_) {
      _messages.add(
        ChatModel(
          message: "Something went wrong. Please try again.",
          isUser: false,
          time: DateTime.now(),
        ),
      );
    }

    _setTyping(false);
  }

  void clearChat() {
    _messages.clear();
    notifyListeners();
  }

  void _setTyping(bool value) {
    if (_isTyping == value) return;
    _isTyping = value;
    notifyListeners();
  }
}
