import 'package:chatbot/data/datasources/gemini_datasource.dart';
import 'package:chatbot/domain/repositories/chat_repository.dart';

class ChatRepositoryImpl implements ChatRepository {
  final GeminiDataSource dataSource;

  ChatRepositoryImpl({required this.dataSource});

  @override
  Future<String> sendMessage(String message) async {
    return await dataSource.sendMessage(message);
  }
}