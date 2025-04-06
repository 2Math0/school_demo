class ApiConstants {
  // Table names
  static const String usersTable = 'users';
  static const String coursesTable = 'courses';
  static const String lessonsTable = 'lessons';
  static const String progressTable = 'progress';
  static const String chatMessagesTable = 'chat_messages';
  static const String notificationsTable = 'notifications';
  static const String userSettingsTable = 'user_settings';

  // Storage buckets
  static const String profileImagesBucket = 'profile_images';
  static const String courseImagesBucket = 'course_images';
  static const String lessonAttachmentsBucket = 'lesson_attachments';
  static const String chatAttachmentsBucket = 'chat_attachments';

  // API endpoints
  static const String baseUrl = '/api/v1';
  static const String authEndpoint = '$baseUrl/auth';
  static const String usersEndpoint = '$baseUrl/users';
  static const String coursesEndpoint = '$baseUrl/courses';
  static const String lessonsEndpoint = '$baseUrl/lessons';
  static const String progressEndpoint = '$baseUrl/progress';
  static const String chatEndpoint = '$baseUrl/chat';
  static const String notificationsEndpoint = '$baseUrl/notifications';
  static const String settingsEndpoint = '$baseUrl/settings';

  // Query parameters
  static const String limitParam = 'limit';
  static const String offsetParam = 'offset';
  static const String orderByParam = 'order_by';
  static const String filterParam = 'filter';
  static const String searchParam = 'search';
  static const String includeParam = 'include';

  // Default values
  static const int defaultLimit = 10;
  static const int defaultOffset = 0;
  static const String defaultOrderBy = 'created_at';
  static const String defaultOrder = 'desc';

  // Error messages
  static const String networkError = 'Network error occurred';
  static const String serverError = 'Server error occurred';
  static const String authError = 'Authentication error occurred';
  static const String validationError = 'Validation error occurred';
  static const String notFoundError = 'Resource not found';
  static const String unknownError = 'Unknown error occurred';

  // Cache keys
  static const String userCacheKey = 'user';
  static const String tokenCacheKey = 'token';
  static const String settingsCacheKey = 'settings';
  static const String themeCacheKey = 'theme';
  static const String languageCacheKey = 'language';

  // Timeouts (in milliseconds)
  static const int connectionTimeout = 30000;
  static const int receiveTimeout = 30000;
  static const int sendTimeout = 30000;

  // Rate limiting
  static const int maxRequestsPerMinute = 60;
  static const int maxRequestsPerHour = 1000;

  // File upload limits
  static const int maxFileSize = 10 * 1024 * 1024; // 10MB
  static const List<String> allowedImageTypes = ['jpg', 'jpeg', 'png', 'gif'];
  static const List<String> allowedDocumentTypes = ['pdf', 'doc', 'docx'];

  // WebSocket events
  static const String messageEvent = 'message';
  static const String notificationEvent = 'notification';
  static const String presenceEvent = 'presence';
  static const String typingEvent = 'typing';
  static const String readEvent = 'read';

  // Notification types
  static const String courseNotification = 'course';
  static const String lessonNotification = 'lesson';
  static const String messageNotification = 'message';
  static const String systemNotification = 'system';
}
