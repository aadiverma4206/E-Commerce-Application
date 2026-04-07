import 'package:google_generative_ai/google_generative_ai.dart';

class ApiClient {
  static const String apiKey = "AIzaSyDoJl0sZ9cg8gIwSgtLVKaSmMMrSSyajVQ";

  late final GenerativeModel _model;

  ApiClient() {
    _model = GenerativeModel(
      model: 'gemini-1.5-flash',
      apiKey: apiKey,
    );
  }

  Future<String> sendMessage(String message) async {
    if (message.trim().isEmpty) {
      return "Message cannot be empty";
    }

    try {
      final response = await _model.generateContent(
        [Content.text(message)],
      );

      final text = response.text;

      if (text == null || text.isEmpty) {
        return "No response from AI";
      }

      return text;
    } catch (e) {
      return "Error: ${e.toString()}";
    }
  }
}