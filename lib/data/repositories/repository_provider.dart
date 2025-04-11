import '../../core/services/api_service.dart';
import 'auth_repository.dart';
import 'course_repository.dart';
import 'progress_repository.dart';
import 'chat_repository.dart';
import 'notification_repository.dart';
import 'settings_repository.dart';
import '../datasources/course_datasource.dart';

class RepositoryProvider {
  final ApiService apiService;
  late final AuthRepository authRepository;
  late final CourseRepository courseRepository;
  late final ProgressRepository progressRepository;
  late final ChatRepository chatRepository;
  late final NotificationRepository notificationRepository;
  late final SettingsRepository settingsRepository;

  RepositoryProvider({required this.apiService}) {
    final courseDataSource = CourseDataSource(apiService: apiService);
    authRepository = AuthRepository(apiService: apiService);
    courseRepository = CourseRepository(dataSource: courseDataSource);
    progressRepository = ProgressRepository(apiService: apiService);
    chatRepository = ChatRepository(apiService: apiService);
    notificationRepository = NotificationRepository(apiService: apiService);
    settingsRepository = SettingsRepository(apiService: apiService);
  }

  void dispose() {
    // Add any cleanup logic here if needed
  }
}
