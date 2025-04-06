import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../presentation/cubit/auth/auth_cubit.dart';
import '../presentation/cubit/course/course_cubit.dart';
import '../presentation/cubit/chatbot/chatbot_cubit.dart';
import '../presentation/cubit/user/user_cubit.dart';
import '../presentation/cubit/progress/progress_cubit.dart';
import '../data/repositories/auth_repository.dart';
import '../data/repositories/course_repository.dart';
import '../data/repositories/user_repository.dart';
import '../data/repositories/chat_repository.dart';
import 'routes.dart';
import 'theme.dart';

class AdaptiveLearningApp extends StatelessWidget {
  const AdaptiveLearningApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(
            authRepository: context.read<AuthRepository>(),
          )..checkAuthState(),
        ),
        BlocProvider<CourseCubit>(
          create: (context) => CourseCubit(
            courseRepository: context.read<CourseRepository>(),
          ),
        ),
        BlocProvider<ChatbotCubit>(
          create: (context) => ChatbotCubit(
            chatRepository: context.read<ChatRepository>(),
          ),
        ),
        BlocProvider<UserCubit>(
          create: (context) => UserCubit(
            userRepository: context.read<UserRepository>(),
          ),
        ),
        BlocProvider<ProgressCubit>(
          create: (context) => ProgressCubit(
            courseRepository: context.read<CourseRepository>(),
          ),
        ),
      ],
      child: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          final router = createRouter(
            isAuthenticated: state is AuthAuthenticated,
            isAdmin: state is AuthAuthenticated ? state.user.isAdmin : false,
          );

          return MaterialApp.router(
            title: 'Adaptive Learning Platform',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: ThemeMode.system,
            routerConfig: router,
          );
        },
      ),
    );
  }
}