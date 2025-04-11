import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_demo/core/services/api_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'app/app.dart';
import 'core/config/env.dart';
import 'core/di/injection_container.dart';
import 'data/repositories/repository_provider.dart' as app_repo;

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

  // Initialize dependency injection
  await init();

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<app_repo.RepositoryProvider>(
          create: (context) => app_repo.RepositoryProvider(
            apiService: sl<ApiService>(),
          ),
        ),
      ],
      child: const App(),
    ),
  );
}
