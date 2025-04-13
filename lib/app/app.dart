import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import '../core/services/api_service.dart';
import '../core/services/supabase_api_service.dart';
import '../core/theme/app_theme.dart';
import '../presentation/cubit/auth/auth_cubit.dart';
import '../presentation/cubit/theme/theme_cubit.dart';
import '../presentation/cubit/course/course_cubit.dart';
import '../presentation/cubit/chat/chat_cubit.dart';
import '../presentation/cubit/notification/notification_cubit.dart';
import '../presentation/cubit/profile/profile_cubit.dart';
import '../presentation/cubit/settings/settings_cubit.dart';
import '../presentation/router/app_router.dart';
import '../data/repositories/course_repository.dart';
import '../data/repositories/chat_repository.dart';
import '../data/repositories/notification_repository.dart';
import '../data/repositories/settings_repository.dart';
import '../data/datasources/course_datasource.dart';
import '../presentation/widgets/auth_listener.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ApiService>(
          create: (_) => SupabaseApiService(),
        ),
        BlocProvider(
          create: (context) => AuthCubit(
            apiService: context.read<ApiService>(),
          ),
        ),
        BlocProvider(
          create: (context) => ThemeCubit(),
        ),
        BlocProvider(
          create: (context) => CourseCubit(
            courseRepository: CourseRepository(
              dataSource: CourseDataSource(
                apiService: context.read<ApiService>(),
              ),
            ),
            userId: '', // Will be updated when user is authenticated
          ),
        ),
        BlocProvider(
          create: (context) => ChatCubit(
            chatRepository: ChatRepository(
              apiService: context.read<ApiService>(),
            ),
            userId: '', // Will be updated when user is authenticated
          ),
        ),
        BlocProvider(
          create: (context) => NotificationCubit(
            notificationRepository: NotificationRepository(
              apiService: context.read<ApiService>(),
            ),
            userId: '', // Will be updated when user is authenticated
          ),
        ),
        BlocProvider(
          create: (context) => ProfileCubit(
            context.read<ApiService>(),
          ),
        ),
        BlocProvider(
          create: (context) => SettingsCubit(
            settingsRepository: SettingsRepository(
              apiService: context.read<ApiService>(),
            ),
            userId: '', // Will be updated when user is authenticated
          ),
        ),
      ],
      child: AuthListener(
        child: BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, state) {
            return MaterialApp.router(
              title: 'School Demo',
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: state.themeMode,
              routerConfig: createRouter(),
              debugShowCheckedModeBanner: false,
            );
          },
        ),
      ),
    );
  }
}
