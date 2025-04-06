import 'package:supabase_flutter/supabase_flutter.dart';
import '../../core/services/supabase_service.dart';
import '../../core/exceptions/app_exception.dart';
import '../models/notification.dart';

class NotificationRepository {
  final SupabaseService supabaseService;

  const NotificationRepository({required this.supabaseService});

  Future<List<Notification>> getNotifications({
    required String userId,
    bool? unreadOnly,
    int? limit,
    int? offset,
  }) async {
    try {
      PostgrestTransformBuilder<PostgrestList> query = supabaseService.client
          .from('notifications')
          .select()
          .eq('user_id', userId)
          .order('created_at', ascending: false);

      if (unreadOnly == true) {
        // query = query.appendSearchParams('read_at', ''));
      }
      if (limit != null) {
        query = query.limit(limit);
      }
      if (offset != null) {
        query = query.range(offset, offset + (limit ?? 10) - 1);
      }

      final response = await query;
      return response.map((json) => Notification.fromJson(json)).toList();
    } catch (e) {
      throw AppException(
        message: 'Failed to fetch notifications',
        details: e.toString(),
      );
    }
  }

  Future<void> markAsRead({
    required String userId,
    required String notificationId,
  }) async {
    try {
      await supabaseService.client
          .from('notifications')
          .update({'read_at': DateTime.now().toIso8601String()})
          .eq('id', notificationId)
          .eq('user_id', userId);
    } catch (e) {
      throw AppException(
        message: 'Failed to mark notification as read',
        details: e.toString(),
      );
    }
  }

  Future<void> markAllAsRead(String userId) async {
    try {
      await supabaseService.client
          .from('notifications')
          .update({'read_at': DateTime.now().toIso8601String()})
          .eq('user_id', userId)
          .eq('read_at', '');
    } catch (e) {
      throw AppException(
        message: 'Failed to mark all notifications as read',
        details: e.toString(),
      );
    }
  }

  Future<void> deleteNotification({
    required String userId,
    required String notificationId,
  }) async {
    try {
      await supabaseService.client
          .from('notifications')
          .delete()
          .eq('id', notificationId)
          .eq('user_id', userId);
    } catch (e) {
      throw AppException(
        message: 'Failed to delete notification',
        details: e.toString(),
      );
    }
  }

  Future<void> deleteAllNotifications(String userId) async {
    try {
      await supabaseService.client
          .from('notifications')
          .delete()
          .eq('user_id', userId);
    } catch (e) {
      throw AppException(
        message: 'Failed to delete all notifications',
        details: e.toString(),
      );
    }
  }

  Future<int> getUnreadCount(String userId) async {
    try {
      final response = await supabaseService.client
          .from('notifications')
          .select()
          .eq('user_id', userId)
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

  Future<Notification> createNotification({
    required String userId,
    required String title,
    required String message,
    required String type,
    String? actionUrl,
    Map<String, dynamic>? metadata,
  }) async {
    try {
      final data = {
        'user_id': userId,
        'title': title,
        'message': message,
        'type': type,
        'action_url': actionUrl,
        'metadata': metadata,
        'created_at': DateTime.now().toIso8601String(),
      };

      final response = await supabaseService.client
          .from('notifications')
          .insert(data)
          .select()
          .single();

      return Notification.fromJson(response);
    } catch (e) {
      throw AppException(
        message: 'Failed to create notification',
        details: e.toString(),
      );
    }
  }

  Stream<Notification> subscribeToNotifications(String userId) {
    try {
      return supabaseService.client
          .from('notifications')
          .stream(primaryKey: ['id'])
          .eq('user_id', userId)
          .map((event) => Notification.fromJson(event.first));
    } catch (e) {
      throw AppException(
        message: 'Failed to subscribe to notifications',
        details: e.toString(),
      );
    }
  }
}
