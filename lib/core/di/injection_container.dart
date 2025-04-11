import 'package:get_it/get_it.dart';
import '../services/api_service.dart';
import '../services/api_service_factory.dart';

final GetIt sl = GetIt.instance;

Future<void> init() async {
  // Services
  sl.registerLazySingleton<ApiService>(() => ApiServiceFactory.create());
}
