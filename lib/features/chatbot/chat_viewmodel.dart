import 'package:flutter/material.dart';
import 'chat_model.dart';
import 'chat_service.dart';

class ChatViewModel extends ChangeNotifier {
  final ChatService _service;

  ChatViewModel({ChatService? service})
      : _service = service ?? ChatService();

  final List<ChatModel> _messages = [];
  bool _isTyping = false;

  List<ChatModel> get messages => List.unmodifiable(_messages);
  bool get isTyping => _isTyping;

  Future<void> sendMessage(String text) async {
    final message = text.trim();
    if (message.isEmpty) return;

    _messages.add(
      ChatModel(
        message: message,
        isUser: true,
        time: DateTime.now(),
      ),
    );

    _setTyping(true);

    try {
      final reply = await _service.sendMessage(message);

      _messages.add(
        ChatModel(
          message: reply.isEmpty ? "No response from AI" : reply,
          isUser: false,
          time: DateTime.now(),
        ),
      );
    } catch (e) {
      _messages.add(
        ChatModel(
          message: "Error: ${e.toString()}",
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
    _isTyping = value;
    notifyListeners();
  }
}