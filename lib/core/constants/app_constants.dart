class AppConstants {
  // Private constructor to prevent instantiation
  AppConstants._();

  // App Info
  static const String appName = 'Adaptive Learning Platform';
  static const String appVersion = '1.0.0';

  // User Roles
  static const String roleAdmin = 'admin';
  static const String roleStudent = 'student';

  // Storage Keys
  static const String authTokenKey = 'auth_token';
  static const String userIdKey = 'user_id';
  static const String userRoleKey = 'user_role';
  static const String darkModeKey = 'dark_mode';

  // Default Values
  static const int defaultPageSize = 10;
  static const Duration sessionTimeout = Duration(hours: 24);

  // Content Types
  static const String typeVideo = 'video';
  static const String typeQuiz = 'quiz';
  static const String typeDocument = 'document';

  // File Size Limits
  static const int maxProfileImageSize = 5 * 1024 * 1024; // 5MB
  static const int maxCourseImageSize = 10 * 1024 * 1024; // 10MB
  static const int maxVideoSize = 500 * 1024 * 1024; // 500MB
  static const int maxDocumentSize = 50 * 1024 * 1024; // 50MB

  // Pagination
  static const int itemsPerPage = 10;

  // Animation Durations
  static const Duration animationDuration = Duration(milliseconds: 300);
  static const Duration splashDuration = Duration(seconds: 2);

  // Debounce Time
  static const Duration searchDebounceTime = Duration(milliseconds: 500);

  // Max Limits
  static const int maxQuizAttempts = 3;
  static const int chatHistoryLimit = 50;
  static const int maxFileUploadRetries = 3;
}