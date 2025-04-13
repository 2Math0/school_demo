import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../data/models/chat_message.dart';
import '../../../data/repositories/chat_repository.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final ChatRepository chatRepository;
  String userId;

  ChatCubit({
    required this.chatRepository,
    required this.userId,
  }) : super(const ChatInitial());

  void updateUserId(String newUserId) {
    userId = newUserId;
  }

  Future<void> loadMessages(String recipientId) async {
    try {
      emit(const ChatLoading());
      final messages = await chatRepository.getMessages(
        userId: userId,
        recipientId: recipientId,
      );
      emit(ChatMessagesLoaded(messages: messages));
    } catch (e) {
      emit(ChatError(message: e.toString()));
    }
  }

  Future<void> sendMessage({
    required String recipientId,
    required String content,
  }) async {
    try {
      emit(const ChatLoading());
      await chatRepository.sendMessage(
        senderId: userId,
        recipientId: recipientId,
        content: content,
      );
      final messages = await chatRepository.getMessages(
        userId: userId,
        recipientId: recipientId,
      );
      emit(ChatMessagesLoaded(messages: messages));
    } catch (e) {
      emit(ChatError(message: e.toString()));
    }
  }

  Future<void> markAsRead(String messageId) async {
    try {
      emit(const ChatLoading());
      await chatRepository.markAsRead(
        userId: userId,
        messageId: messageId,
      );
      final messages = await chatRepository.getMessages(
        userId: userId,
        recipientId: messageId,
      );
      emit(ChatMessagesLoaded(messages: messages));
    } catch (e) {
      emit(ChatError(message: e.toString()));
    }
  }
}
