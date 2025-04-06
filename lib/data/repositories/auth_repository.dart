import 'package:supabase_flutter/supabase_flutter.dart' as supabase;
import '../../core/services/supabase_service.dart';
import '../../core/exceptions/app_exception.dart';
import '../models/user.dart' as models;
import 'base_repository.dart';

class AuthRepository extends BaseRepository {
  final SupabaseService _supabaseService;

  AuthRepository({required SupabaseService supabaseService})
      : _supabaseService = supabaseService,
        super(supabaseService: supabaseService);

  Future<models.User> signUp({
    required String email,
    required String password,
    required String fullName,
    bool isInstructor = false,
  }) async {
    try {
      final response = await supabaseService.client.auth.signUp(
        email: email,
        password: password,
        data: {
          'full_name': fullName,
          'is_instructor': isInstructor,
        },
      );

      if (response.user == null) {
        throw const AppException(
          message: 'Failed to create account',
          details: 'Please try again later',
        );
      }

      final user = models.User(
        id: response.user!.id,
        email: email,
        fullName: fullName,
        isInstructor: isInstructor,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      // Create user profile in the database
      await supabaseService.client.from('profiles').insert(user.toJson());

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
      final response = await supabaseService.client.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.user == null) {
        throw const AppException(
          message: 'Failed to sign in',
          details: 'Invalid email or password',
        );
      }

      final userData = await supabaseService.client
          .from('profiles')
          .select()
          .eq('id', response.user!.id)
          .single();

      return models.User.fromJson(userData);
    } catch (e) {
      throw AppException(
        message: 'Failed to sign in',
        details: e.toString(),
      );
    }
  }

  Future<void> signOut() async {
    try {
      await supabaseService.client.auth.signOut();
    } catch (e) {
      throw AppException(
        message: 'Failed to sign out',
        details: e.toString(),
      );
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await supabaseService.client.auth.resetPasswordForEmail(email);
    } catch (e) {
      throw AppException(
        message: 'Failed to send reset password email',
        details: e.toString(),
      );
    }
  }

  Future<void> updatePassword(String newPassword) async {
    try {
      await supabaseService.client.auth.updateUser(
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
      final currentUser = supabaseService.client.auth.currentUser;
      if (currentUser == null) return null;

      final userData = await supabaseService.client
          .from('profiles')
          .select()
          .eq('id', currentUser.id)
          .single();

      return models.User.fromJson(userData);
    } catch (e) {
      return null;
    }
  }

  Stream<supabase.AuthState> get authStateChanges =>
      supabaseService.client.auth.onAuthStateChange;
}
