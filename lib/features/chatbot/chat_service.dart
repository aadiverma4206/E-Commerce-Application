import '../../core/api/api_client.dart';

class ChatService {
  final ApiClient _api;

  ChatService({ApiClient? apiClient}) : _api = apiClient ?? ApiClient();

  Future<String> sendMessage(String message) async {
    if (message.trim().isEmpty) {
      return "Message cannot be empty";
    }

    try {
      final response = await _api.sendMessage(message);
      if (response.isEmpty) {
        return "No response from AI";
      }
      return response;
    } catch (e) {
      return "Error: ${e.toString()}";
    }
  }
}