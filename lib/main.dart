import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'app/app.dart';
import 'core/config/env.dart';
import 'core/services/service_locator.dart';
import 'data/repositories/auth_repository.dart';
import 'data/repositories/course_repository.dart';
import 'data/repositories/progress_repository.dart';
import 'data/repositories/chat_repository.dart';
import 'data/repositories/notification_repository.dart';
import 'data/repositories/settings_repository.dart';
import 'core/theme/app_theme.dart';
import 'presentation/router/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize environment variables
  await Env.initialize();
  Env.validate();

  // Initialize Supabase
  await Supabase.initialize(
    url: Env.supabaseUrl,
    anonKey: Env.supabaseAnonKey,
  );

  // Initialize service locator
  await setupServiceLocator();

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(
          create: (context) => getIt<AuthRepository>(),
        ),
        RepositoryProvider<CourseRepository>(
          create: (context) => getIt<CourseRepository>(),
        ),
        RepositoryProvider<ProgressRepository>(
          create: (context) => getIt<ProgressRepository>(),
        ),
        RepositoryProvider<ChatRepository>(
          create: (context) => getIt<ChatRepository>(),
        ),
        RepositoryProvider<NotificationRepository>(
          create: (context) => getIt<NotificationRepository>(),
        ),
        RepositoryProvider<SettingsRepository>(
          create: (context) => getIt<SettingsRepository>(),
        ),
      ],
      child: const App(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'School Demo',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: AppRouter.router,
      debugShowCheckedModeBanner: false,
    );
  }
}
