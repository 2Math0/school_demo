import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_demo/core/services/api_service.dart';
import 'package:school_demo/data/models/user.dart';
import 'package:equatable/equatable.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ApiService _apiService;
  String? _currentUserId;

  ProfileCubit(this._apiService) : super(ProfileInitial());

  Future<void> getProfile(String userId) async {
    try {
      emit(ProfileLoading());
      _currentUserId = userId;
      final user = await _apiService.getUserProfile(userId);
      emit(ProfileLoaded(user));
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  Future<void> updateProfile({
    String? fullName,
    String? bio,
    String? avatarUrl,
  }) async {
    try {
      if (_currentUserId == null) {
        throw Exception('No user ID available');
      }
      emit(ProfileLoading());
      final userMetadata = {
        if (fullName != null) 'fullName': fullName,
        if (bio != null) 'bio': bio,
        if (avatarUrl != null) 'avatarUrl': avatarUrl,
      };
      final user =
          await _apiService.updateUserProfile(_currentUserId!, userMetadata);
    
      emit(ProfileLoaded(user));
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  Future<void> changePassword(String email) async {
    try {
      emit(ProfileLoading());
      await _apiService.resetPassword(email);
      emit(ProfilePasswordChanged());
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }
}
