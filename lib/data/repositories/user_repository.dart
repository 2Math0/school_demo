import 'package:school_demo/core/services/supabase_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/user.dart' as app_user;
import 'base_repository.dart';

class UserRepository extends BaseRepository {
  final SupabaseService _supabaseService;

  UserRepository({required super.supabaseService})
      : _supabaseService = supabaseService;

  Future<app_user.User> getUserProfile() async {
    try {
      final userId = _supabaseService.client.auth.currentUser?.id;
      if (userId == null) {
        throw Exception('User not authenticated');
      }

      final response = await _supabaseService.client
          .from('profiles')
          .select()
          .eq('id', userId)
          .single();
      return app_user.User.fromJson(response);
    } catch (e) {
      throw Exception('Failed to get user profile: $e');
    }
  }

  Future<app_user.User> updateUserProfile({
    String? fullName,
    String? bio,
    String? avatar,
  }) async {
    try {
      final userId = _supabaseService.client.auth.currentUser?.id;
      if (userId == null) {
        throw Exception('User not authenticated');
      }

      final updates = {
        if (fullName != null) 'full_name': fullName,
        if (bio != null) 'bio': bio,
        if (avatar != null) 'avatar': avatar,
        'updated_at': DateTime.now().toIso8601String(),
      };

      final response = await _supabaseService.client
          .from('profiles')
          .update(updates)
          .eq('id', userId)
          .select()
          .single();

      return app_user.User.fromJson(response);
    } catch (e) {
      throw Exception('Failed to update user profile: $e');
    }
  }

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      await _supabaseService.client.auth.updateUser(
        UserAttributes(
          password: newPassword,
        ),
      );
    } catch (e) {
      throw Exception('Failed to change password: $e');
    }
  }
}
