import 'package:google_generative_ai/google_generative_ai.dart';
import 'dart:async';
// api is .env file
class ApiClient {
  final GenerativeModel _model;

  ApiClient({required String apiKey})
      : _model = GenerativeModel(
    model: 'gemini-1.5-flash',
    apiKey: apiKey,
  );

  Future<String> sendMessage(String message) async {
    if (message.trim().isEmpty) {
      return "Please enter a message";
    }

    try {
      final response = await _model
          .generateContent([Content.text(message)])
          .timeout(const Duration(seconds: 10));

      final text = response.text;

      if (text == null || text.trim().isEmpty) {
        return "No response received. Try again.";
      }

      return text.trim();
    } on TimeoutException {
      return "Request timed out. Check your internet.";
    } catch (e) {
      return "Something went wrong. Please try again.";
    }
  }
}