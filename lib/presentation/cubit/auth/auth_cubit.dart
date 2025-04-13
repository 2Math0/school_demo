import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/services/api_service.dart';
import '../course/course_cubit.dart';
import '../chat/chat_cubit.dart';
import '../notification/notification_cubit.dart';
import '../settings/settings_cubit.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final ApiService _apiService;

  AuthCubit({required ApiService apiService})
      : _apiService = apiService,
        super(AuthInitial()) {
    Supabase.instance.client.auth.onAuthStateChange.listen((event) {
      if (event.session != null) {
        final user = event.session!.user;
        emit(AuthAuthenticated(user: user));
      } else {
        emit(AuthUnauthenticated());
      }
    });
  }

  Future<void> signUp({
    required String email,
    required String password,
    required Map<String, dynamic> userData,
  }) async {
    try {
      emit(AuthLoading());
      final response = await _apiService.signUp(
        email: email.trim(),
        password: password,
        userMetadata: userData,
      );
      if (response['session'] != null) {
        final user = User.fromJson(response['user']);
        if (user != null) {
          emit(AuthAuthenticated(user: user));
        } else {
          emit(AuthUnauthenticated());
        }
      } else {
        emit(AuthUnauthenticated());
      }
    } catch (e) {
      Logger().e(e.toString());
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    try {
      emit(AuthLoading());
      final response = await _apiService.signIn(
        email: email,
        password: password,
      );
      final user = User.fromJson(response['user']);
      if (user != null) {
        emit(AuthAuthenticated(user: user));
      } else {
        emit(AuthUnauthenticated());
      }
    } catch (e) {
      Logger().e(e.toString());
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> signOut() async {
    try {
      emit(AuthLoading());
      await _apiService.signOut();
      emit(AuthUnauthenticated());
    } catch (e) {
      Logger().e(e.toString());
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      emit(AuthLoading());
      await _apiService.resetPassword(email);
      emit(AuthUnauthenticated());
    } catch (e) {
      Logger().e(e.toString());
      emit(AuthError(message: e.toString()));
    }
  }
}
