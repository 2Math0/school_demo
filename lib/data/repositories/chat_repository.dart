import 'dart:io';
import '../../core/services/supabase_service.dart';
import '../../core/exceptions/app_exception.dart';
import '../models/chat_message.dart';

class ChatRepository {
  final SupabaseService supabaseService;

  const ChatRepository({required this.supabaseService});

  Future<List<ChatMessage>> getMessages({
    required String userId,
    required String recipientId,
    int? limit,
    int? offset,
  }) async {
    try {
      var query = supabaseService.client
          .from('messages')
          .select()
          .or('sender_id.eq.$userId,recipient_id.eq.$userId')
          .or('sender_id.eq.$recipientId,recipient_id.eq.$recipientId')
          .order('created_at', ascending: false);

      if (limit != null) {
        query = query.limit(limit);
      }

      if (offset != null) {
        query = query.range(offset, offset + (limit ?? 10) - 1);
      }

      final response = await query;
      return response.map((json) => ChatMessage.fromJson(json)).toList();
    } catch (e) {
      throw AppException(
        message: 'Failed to fetch messages',
        details: e.toString(),
      );
    }
  }

  Future<List<ChatMessage>> getRecentChats(String userId) async {
    try {
      final response = await supabaseService.client
          .from('messages')
          .select()
          .or('sender_id.eq.$userId,recipient_id.eq.$userId')
          .order('created_at', ascending: false)
          .limit(20);

      return response.map((json) => ChatMessage.fromJson(json)).toList();
    } catch (e) {
      throw AppException(
        message: 'Failed to fetch recent chats',
        details: e.toString(),
      );
    }
  }

  Future<ChatMessage> sendMessage({
    required String senderId,
    required String recipientId,
    required String content,
    String? attachmentUrl,
  }) async {
    try {
      final data = {
        'sender_id': senderId,
        'recipient_id': recipientId,
        'content': content,
        'attachment_url': attachmentUrl,
        'created_at': DateTime.now().toIso8601String(),
      };

      final response = await supabaseService.client
          .from('messages')
          .insert(data)
          .select()
          .single();

      return ChatMessage.fromJson(response);
    } catch (e) {
      throw AppException(
        message: 'Failed to send message',
        details: e.toString(),
      );
    }
  }

  Future<void> markAsRead({
    required String userId,
    required String messageId,
  }) async {
    try {
      await supabaseService.client
          .from('messages')
          .update({'read_at': DateTime.now().toIso8601String()})
          .eq('id', messageId)
          .eq('recipient_id', userId);
    } catch (e) {
      throw AppException(
        message: 'Failed to mark message as read',
        details: e.toString(),
      );
    }
  }

  Future<void> deleteMessage(String messageId) async {
    try {
      await supabaseService.client
          .from('messages')
          .delete()
          .eq('id', messageId);
    } catch (e) {
      throw AppException(
        message: 'Failed to delete message',
        details: e.toString(),
      );
    }
  }

  Stream<ChatMessage> subscribeToMessages(String userId) {
    try {
      return supabaseService.client
          .from('messages')
          .stream(primaryKey: ['id'])
          .eq('recipient_id', userId)
          .map((event) => ChatMessage.fromJson(event.first));
    } catch (e) {
      throw AppException(
        message: 'Failed to subscribe to messages',
        details: e.toString(),
      );
    }
  }

  Future<int> getUnreadCount(String userId) async {
    try {
      final response = await supabaseService.client
          .from('messages')
          .select()
          .eq('recipient_id', userId)
          .eq('read_at', '')
          .count();

      return response.count ?? 0;
    } catch (e) {
      throw AppException(
        message: 'Failed to get unread count',
        details: e.toString(),
      );
    }
  }

  Future<String?> uploadAttachment(String filePath) async {
    try {
      final file = File(filePath);
      final fileName = filePath.split('/').last;
      final path = 'chat_attachments/$fileName';

      await supabaseService.client.storage
          .from('attachments')
          .upload(path, file);

      final response =
          supabaseService.client.storage.from('attachments').getPublicUrl(path);
      return response;
    } catch (e) {
      throw AppException(
        message: 'Failed to upload attachment',
        details: e.toString(),
      );
    }
  }
}
