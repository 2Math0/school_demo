class AppConstants {
  // Private constructor to prevent instantiation
  AppConstants._();

  // App Info
  static const String appName = 'AI Education Platform';
  static const String appVersion = '1.0.0';
  static const String appDescription =
      'Personalized Education Platform Powered by AI';

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
  static const Duration pageTransitionDuration = Duration(milliseconds: 500);
  static const Duration snackBarDuration = Duration(seconds: 3);

  // Debounce Time
  static const Duration searchDebounceTime = Duration(milliseconds: 500);

  // Max Limits
  static const int maxQuizAttempts = 3;
  static const int chatHistoryLimit = 50;
  static const int maxFileUploadRetries = 3;

  // Layout Constants
  static const double defaultPadding = 16.0;
  static const double defaultBorderRadius = 12.0;
  static const double defaultIconSize = 24.0;
  static const double defaultButtonHeight = 48.0;
  static const double defaultAppBarHeight = 56.0;
  static const double defaultBottomNavigationBarHeight = 64.0;

  // Breakpoints for Responsive Design
  static const double mobileBreakpoint = 600;
  static const double tabletBreakpoint = 900;
  static const double desktopBreakpoint = 1200;

  // Cache Keys
  static const String cacheUserKey = 'user';
  static const String cacheTokenKey = 'token';
  static const String cacheThemeKey = 'theme';
  static const String cacheLanguageKey = 'language';

  // File Types
  static const List<String> allowedImageTypes = [
    'image/jpeg',
    'image/png',
    'image/gif',
  ];
  static const List<String> allowedDocumentTypes = [
    'application/pdf',
    'application/msword',
    'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
  ];
  static const List<String> allowedVideoTypes = [
    'video/mp4',
    'video/webm',
    'video/ogg',
  ];

  // Pagination
  static const int maxPageSize = 100;

  // Validation
  static const int minPasswordLength = 8;
  static const int maxPasswordLength = 32;
  static const int minUsernameLength = 3;
  static const int maxUsernameLength = 32;
  static const int minCourseTitleLength = 3;
  static const int maxCourseTitleLength = 100;
  static const int minCourseDescriptionLength = 10;
  static const int maxCourseDescriptionLength = 1000;

  // Error Messages
  static const String errorGeneric = 'Something went wrong. Please try again.';
  static const String errorNetwork =
      'No internet connection. Please check your network.';
  static const String errorUnauthorized =
      'You are not authorized to perform this action.';
  static const String errorNotFound = 'The requested resource was not found.';
  static const String errorServer = 'Server error. Please try again later.';
  static const String errorValidation =
      'Please check your input and try again.';
}
