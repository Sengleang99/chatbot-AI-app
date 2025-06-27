import 'package:chatbot/presentation/providers/chat_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InputField extends StatefulWidget {
  const InputField({super.key});

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  final _textController = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void dispose() {
    _textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    if (_textController.text.trim().isNotEmpty) {
      context.read<ChatProvider>().sendMessage(_textController.text.trim());
      _textController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              cursorColor: Colors.grey,
              controller: _textController,
              focusNode: _focusNode,
              minLines: 1,
              maxLines: 5, // Allows up to 5 lines
              keyboardType: TextInputType.multiline,
              textInputAction:
                  TextInputAction.newline, // For line breaks with Enter
              decoration: InputDecoration(
                hintText: 'message...',
                filled: true, // Makes background color visible
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: Colors.grey[200]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: Colors.grey[200]!),
                ),
              ),
              onSubmitted: (_) => _handleSubmit(),
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: _handleSubmit,
          ),
        ],
      ),
    );
  }
}
