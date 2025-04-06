class ApiConstants {
  // Private constructor to prevent instantiation
  ApiConstants._();

  // Base URLs
  static const String supabaseUrl = 'https://your-supabase-project.supabase.co';
  static const String supabaseAnonKey = 'your-supabase-anon-key';

  // API Endpoints
  static const String apiBaseUrl = 'https://your-backend-api.com';

  // Supabase Tables
  static const String usersTable = 'users';
  static const String coursesTable = 'courses';
  static const String lessonsTable = 'lessons';
  static const String videosTable = 'videos';
  static const String quizzesTable = 'quizzes';
  static const String questionsTable = 'questions';
  static const String progressTable = 'progress';
  static const String chatMessagesTable = 'chat_messages';

  // Supabase Storage Buckets
  static const String courseImagesBucket = 'course_images';
  static const String videosBucket = 'videos';
  static const String documentsBucket = 'documents';
  static const String profileImagesBucket = 'profile_images';

  // API Timeouts
  static const int connectionTimeout = 30000; // 30 seconds
  static const int receiveTimeout = 30000; // 30 seconds
}