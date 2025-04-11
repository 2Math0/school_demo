import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/services/api_service.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final ApiService _apiService;

  AuthCubit({required ApiService apiService})
      : _apiService = apiService,
        super(AuthInitial()) {
    Supabase.instance.client.auth.onAuthStateChange.listen((event) {
      if (event.session != null) {
        emit(AuthAuthenticated(user: event.session!.user));
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
        email: email,
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
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> signOut() async {
    try {
      emit(AuthLoading());
      await _apiService.signOut();
      emit(AuthUnauthenticated());
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      emit(AuthLoading());
      await _apiService.resetPassword(email);
      emit(AuthUnauthenticated());
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }
}
