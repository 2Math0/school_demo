import 'package:get_it/get_it.dart';
import '../../data/repositories/repository_provider.dart';
import 'api_service.dart';
import 'supabase_api_service.dart';

final GetIt getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  // Services
  getIt.registerLazySingleton<ApiService>(
    () => SupabaseApiService(),
  );

  // Repository Provider
  getIt.registerLazySingleton<RepositoryProvider>(
    () => RepositoryProvider(apiService: getIt<ApiService>()),
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
