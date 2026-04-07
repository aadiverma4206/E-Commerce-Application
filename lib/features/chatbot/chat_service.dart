import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../core/api/api_client.dart';

class ChatService {
  final ApiClient _api;

  ChatService({ApiClient? apiClient})
      : _api = apiClient ??
      ApiClient(
        apiKey: dotenv.env['API_KEY'] ?? '',
      );

  Future<String> sendMessage(String message) async {
    final trimmedMessage = message.trim();

    if (trimmedMessage.isEmpty) {
      return "Please enter a message";
    }

    try {
      final response = await _api.sendMessage(trimmedMessage);

      if (response.trim().isEmpty) {
        return "No response received. Try again.";
      }

      return response;
    } catch (_) {
      return "Something went wrong. Please try again.";
    }
  }
}