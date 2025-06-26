import 'package:chatbot/domain/repositories/chat_repository.dart';

class SendMessageUseCase {
  final ChatRepository repository;

  SendMessageUseCase({required this.repository});

  Future<String> call(String message) async {
    return await repository.sendMessage(message);
  }
}