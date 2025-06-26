import 'package:chatbot/core/constants/app_constants.dart';
import 'package:chatbot/data/datasources/gemini_datasource.dart';
import 'package:chatbot/data/repositories/chat_repository_impl.dart';
import 'package:chatbot/domain/usecases/send_message_usecase.dart';
import 'package:chatbot/presentation/pages/chat_page.dart';
import 'package:chatbot/presentation/providers/chat_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (_) => GeminiDataSource(
            apiKey: AppConstants.apiKey,
            modelName: AppConstants.modelName,
          ),
        ),
        Provider(
          create: (context) => ChatRepositoryImpl(
            dataSource: context.read<GeminiDataSource>(),
          ),
        ),
        Provider(
          create: (context) => SendMessageUseCase(
            repository: context.read<ChatRepositoryImpl>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => ChatProvider(
            sendMessageUseCase: context.read<SendMessageUseCase>(),
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'AI Chatbot',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true,
        ),
        home: const ChatPage(),
      ),
    );
  }
}