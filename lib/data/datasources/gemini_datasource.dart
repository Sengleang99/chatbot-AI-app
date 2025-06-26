import 'package:chatbot/core/constants/app_constants.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiDataSource {
  final GenerativeModel _model;

  GeminiDataSource({required String apiKey, required String modelName})
      : _model = GenerativeModel(model: modelName, apiKey: apiKey);

  Future<String> sendMessage(String message) async {
    try {
      final chat = _model.startChat();
      final response = await chat.sendMessage(Content.text(message));
      return response.text ?? AppConstants.errorMessage;
    } catch (e) {
      throw Exception('Failed to send message: $e');
    }
  }
}