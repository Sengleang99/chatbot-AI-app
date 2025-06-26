import 'package:flutter/material.dart';

class TypingIndicator extends StatelessWidget {
  const TypingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: const Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.indigo,
            child: Icon(Icons.auto_awesome, color: Colors.white),
          ),
          SizedBox(width: 8),
          Text('...'),
        ],
      ),
    );
  }
}