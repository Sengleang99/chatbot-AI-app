import 'package:chatbot/presentation/providers/chat_provider.dart';
import 'package:chatbot/presentation/widgets/chat_bubble.dart';
import 'package:chatbot/presentation/widgets/input_field.dart';
import 'package:chatbot/presentation/widgets/typing_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ChatProvider>().addWelcomeMessage();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('AI Assistant', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () => context.read<ChatProvider>().clearChat(),
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: Consumer<ChatProvider>(
                builder: (context, provider, _) {
                  return ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: provider.messages.length + (provider.isTyping ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index < provider.messages.length) {
                        return ChatBubble(message: provider.messages[index]);
                      } else {
                        return const TypingIndicator();
                      }
                    },
                  );
                },
              ),
            ),
            const InputField(),
          ],
        ),
      ),
    );
  }
}