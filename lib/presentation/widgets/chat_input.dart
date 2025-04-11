import 'package:flutter/material.dart';

class ChatInput extends StatelessWidget {
  final Function(String) onSend;

  const ChatInput({
    super.key,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha(50),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, -1),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(
                hintText: 'Type a message...',
                border: InputBorder.none,
              ),
              onSubmitted: (text) {
                if (text.trim().isNotEmpty) {
                  onSend(text);
                  controller.clear();
                }
              },
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () {
              final text = controller.text.trim();
              if (text.isNotEmpty) {
                onSend(text);
                controller.clear();
              }
            },
          ),
        ],
      ),
    );
  }
}
