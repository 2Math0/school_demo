import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/auth/auth_cubit.dart';
import '../cubit/course/course_cubit.dart';
import '../cubit/chat/chat_cubit.dart';
import '../cubit/notification/notification_cubit.dart';
import '../cubit/settings/settings_cubit.dart';

class AuthListener extends StatelessWidget {
  final Widget child;

  const AuthListener({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        final userId = state is AuthAuthenticated ? state.user.id : '';
        context.read<CourseCubit>().updateUserId(userId);
        context.read<ChatCubit>().updateUserId(userId);
        context.read<NotificationCubit>().updateUserId(userId);
        context.read<SettingsCubit>().updateUserId(userId);
      },
      child: child,
    );
  }
}
