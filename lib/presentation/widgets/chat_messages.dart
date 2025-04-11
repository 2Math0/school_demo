import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/chat_message.dart';
import '../cubit/auth/auth_cubit.dart';

class ChatMessages extends StatelessWidget {
  final List<ChatMessage> messages;

  const ChatMessages({
    super.key,
    required this.messages,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        final currentUserId = state is AuthAuthenticated ? state.user.id : null;

        return ListView.builder(
          reverse: true,
          itemCount: messages.length,
          itemBuilder: (context, index) {
            final message = messages[index];
            final isMe = message.senderId == currentUserId;

            return Align(
              alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color:
                      isMe ? Theme.of(context).primaryColor : Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  message.content,
                  style: TextStyle(
                    color: isMe ? Colors.white : Colors.black,
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
