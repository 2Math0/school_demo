import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'app/app.dart';
import 'core/constants/api_constants.dart';
import 'data/repositories/auth_repository.dart';
import 'data/repositories/course_repository.dart';
import 'data/repositories/user_repository.dart';
import 'data/repositories/chat_repository.dart';
import 'core/services/supabase_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Supabase
  await Supabase.initialize(
    url: ApiConstants.supabaseUrl,
    anonKey: ApiConstants.supabaseAnonKey,
  );

  // Initialize services
  final supabaseService = SupabaseService();
  await supabaseService.initialize();

  // Initialize repositories
  final authRepository = AuthRepository(supabaseService);
  final courseRepository = CourseRepository(supabaseService);
  final userRepository = UserRepository(supabaseService);
  final chatRepository = ChatRepository(supabaseService);

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(
          create: (context) => authRepository,
        ),
        RepositoryProvider<CourseRepository>(
          create: (context) => courseRepository,
        ),
        RepositoryProvider<UserRepository>(
          create: (context) => userRepository,
        ),
        RepositoryProvider<ChatRepository>(
          create: (context) => chatRepository,
        ),
      ],
      child: const AdaptiveLearningApp(),
    ),
  );
}