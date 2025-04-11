import 'package:supabase_flutter/supabase_flutter.dart' as supabase;
import '../../core/exceptions/app_exception.dart';
import '../models/user.dart' as models;
import 'base_repository.dart';

class AuthRepository extends BaseRepository {
  AuthRepository({required super.apiService});

  Future<models.User> signUp({
    required String email,
    required String password,
    required String fullName,
    bool isInstructor = false,
  }) async {
    try {
      final response = await apiService.signUp(
        email: email,
        password: password,
        userMetadata: {
          'full_name': fullName,
          'is_instructor': isInstructor,
        },
      );

      if (response['user'] == null) {
        throw const AppException(
          message: 'Failed to create account',
          details: 'Please try again later',
        );
      }

      final user = models.User(
        id: response['user']['id'],
        email: email,
        fullName: fullName,
        isInstructor: isInstructor,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      return user;
    } catch (e) {
      throw AppException(
        message: 'Failed to create account',
        details: e.toString(),
      );
    }
  }

  Future<models.User> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await apiService.signIn(
        email: email,
        password: password,
      );

      if (response['user'] == null) {
        throw const AppException(
          message: 'Failed to sign in',
          details: 'Invalid email or password',
        );
      }

      return models.User.fromJson(response['user']);
    } catch (e) {
      throw AppException(
        message: 'Failed to sign in',
        details: e.toString(),
      );
    }
  }

  Future<void> signOut() async {
    try {
      await apiService.signOut();
    } catch (e) {
      throw AppException(
        message: 'Failed to sign out',
        details: e.toString(),
      );
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await apiService.resetPassword(email);
    } catch (e) {
      throw AppException(
        message: 'Failed to send reset password email',
        details: e.toString(),
      );
    }
  }

  Future<void> updatePassword(String newPassword) async {
    try {
      await supabaseClient.auth.updateUser(
        supabase.UserAttributes(
          password: newPassword,
        ),
      );
    } catch (e) {
      throw AppException(
        message: 'Failed to update password',
        details: e.toString(),
      );
    }
  }

  Future<models.User?> getCurrentUser() async {
    try {
      final currentUser = supabaseClient.auth.currentUser;
      if (currentUser == null) return null;

      return await apiService.getUserProfile(currentUser.id);
    } catch (e) {
      return null;
    }
  }

  Stream<supabase.AuthState> get authStateChanges =>
      supabaseClient.auth.onAuthStateChange;
}
