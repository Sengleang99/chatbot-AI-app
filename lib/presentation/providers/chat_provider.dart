import 'package:chatbot/core/constants/app_constants.dart';
import 'package:chatbot/data/models/chat_message.dart';
import 'package:chatbot/domain/usecases/send_message_usecase.dart';
import 'package:flutter/material.dart';

class ChatProvider extends ChangeNotifier {
  final SendMessageUseCase sendMessageUseCase;
  final List<ChatMessage> _messages = [];
  bool _isTyping = false;

  ChatProvider({required this.sendMessageUseCase});

  List<ChatMessage> get messages => _messages;
  bool get isTyping => _isTyping;

  void addWelcomeMessage() {
    _messages.add(ChatMessage(
      text: AppConstants.welcomeMessage,
      isUser: false,
      timestamp: DateTime.now(),
    ));
    notifyListeners();
  }

  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    _messages.add(ChatMessage(
      text: text,
      isUser: true,
      timestamp: DateTime.now(),
    ));
    _isTyping = true;
    notifyListeners();

    try {
      final response = await sendMessageUseCase(text);
      _messages.add(ChatMessage(
        text: response,
        isUser: false,
        timestamp: DateTime.now(),
      ));
    } catch (e) {
      _messages.add(ChatMessage(
        text: 'Error: ${e.toString()}',
        isUser: false,
        timestamp: DateTime.now(),
      ));
    } finally {
      _isTyping = false;
      notifyListeners();
    }
  }

  void clearChat() {
    _messages.clear();
    notifyListeners();
    addWelcomeMessage();
  }
}