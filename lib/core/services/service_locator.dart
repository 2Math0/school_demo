import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../data/repositories/repository_provider.dart';
import 'supabase_service.dart';

final GetIt getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  // Services
  getIt.registerLazySingleton<SupabaseService>(
    () => SupabaseService(client: Supabase.instance.client),
  );

  // Repository Provider
  getIt.registerLazySingleton<RepositoryProvider>(
    () => RepositoryProvider(supabaseService: getIt<SupabaseService>()),
  );

  // Individual Repositories (accessed through RepositoryProvider)
  getIt.registerLazySingleton(
    () => getIt<RepositoryProvider>().authRepository,
  );
  getIt.registerLazySingleton(
    () => getIt<RepositoryProvider>().courseRepository,
  );
  getIt.registerLazySingleton(
    () => getIt<RepositoryProvider>().progressRepository,
  );
  getIt.registerLazySingleton(
    () => getIt<RepositoryProvider>().chatRepository,
  );
  getIt.registerLazySingleton(
    () => getIt<RepositoryProvider>().notificationRepository,
  );
  getIt.registerLazySingleton(
    () => getIt<RepositoryProvider>().settingsRepository,
  );
}

Future<void> resetServiceLocator() async {
  await getIt.reset();
  await setupServiceLocator();
}
