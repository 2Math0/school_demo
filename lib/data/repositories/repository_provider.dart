import '../../core/services/supabase_service.dart';
import 'auth_repository.dart';
import 'course_repository.dart';
import 'progress_repository.dart';
import 'chat_repository.dart';
import 'notification_repository.dart';
import 'settings_repository.dart';

class RepositoryProvider {
  final SupabaseService supabaseService;
  late final AuthRepository authRepository;
  late final CourseRepository courseRepository;
  late final ProgressRepository progressRepository;
  late final ChatRepository chatRepository;
  late final NotificationRepository notificationRepository;
  late final SettingsRepository settingsRepository;

  RepositoryProvider({required this.supabaseService}) {
    authRepository = AuthRepository(supabaseService: supabaseService);
    courseRepository = CourseRepository(supabaseService: supabaseService);
    progressRepository = ProgressRepository(supabaseService: supabaseService);
    chatRepository = ChatRepository(supabaseService: supabaseService);
    notificationRepository =
        NotificationRepository(supabaseService: supabaseService);
    settingsRepository = SettingsRepository(supabaseService: supabaseService);
  }

  void dispose() {
    // Add any cleanup logic here if needed
  }
}
