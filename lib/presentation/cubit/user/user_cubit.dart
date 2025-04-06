import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../data/models/user.dart';
import '../../../data/repositories/user_repository.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UserRepository userRepository;

  UserCubit({required this.userRepository}) : super(const UserInitial());

  Future<void> loadUserProfile() async {
    try {
      emit(const UserLoading());
      final user = await userRepository.getUserProfile();
      emit(UserProfileLoaded(user: user));
    } catch (e) {
      emit(UserError(message: e.toString()));
    }
  }

  Future<void> updateUserProfile({
    String? fullName,
    String? bio,
    String? avatar,
  }) async {
    try {
      emit(const UserLoading());
      final user = await userRepository.updateUserProfile(
        fullName: fullName,
        bio: bio,
        avatar: avatar,
      );
      emit(UserProfileLoaded(user: user));
    } catch (e) {
      emit(UserError(message: e.toString()));
    }
  }

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      emit(const UserLoading());
      await userRepository.changePassword(
        currentPassword: currentPassword,
        newPassword: newPassword,
      );
      emit(const PasswordChanged());
    } catch (e) {
      emit(UserError(message: e.toString()));
    }
  }
}
