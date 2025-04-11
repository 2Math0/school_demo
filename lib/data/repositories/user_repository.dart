import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/user.dart' as app_user;
import '../../core/services/api_service.dart';

class UserRepository {
  final ApiService _apiService;

  UserRepository({required ApiService apiService}) : _apiService = apiService;

  Future<app_user.User> getUserProfile() async {
    try {
      final userId = Supabase.instance.client.auth.currentUser?.id;
      if (userId == null) {
        throw Exception('User not authenticated');
      }
      return await _apiService.getUserProfile(userId);
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
      final userId = Supabase.instance.client.auth.currentUser?.id;
      if (userId == null) {
        throw Exception('User not authenticated');
      }

      final updates = {
        if (fullName != null) 'full_name': fullName,
        if (bio != null) 'bio': bio,
        if (avatar != null) 'avatar': avatar,
        'updated_at': DateTime.now().toIso8601String(),
      };

      return await _apiService.updateUserProfile(userId, updates);
    } catch (e) {
      throw Exception('Failed to update user profile: $e');
    }
  }

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      await Supabase.instance.client.auth.updateUser(
        UserAttributes(
          password: newPassword,
        ),
      );
    } catch (e) {
      throw Exception('Failed to change password: $e');
    }
  }
}
