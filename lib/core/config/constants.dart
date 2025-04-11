class AppConstants {
  // API Configuration
  static const bool useMockData = true;
  static const String mockDataPath = 'assets/mock_data/';

  // Supabase Configuration
  static const String supabaseUrl = 'YOUR_SUPABASE_URL';
  static const String supabaseAnonKey = 'YOUR_SUPABASE_ANON_KEY';

  // Table names
  static const String usersTable = 'users';
  static const String coursesTable = 'courses';
  static const String enrollmentsTable = 'enrollments';
  static const String progressTable = 'progress';
  static const String storageBucket = 'course-content';

  // API Endpoints
  static const String baseUrl = 'https://api.example.com';
  static const String coursesEndpoint = '$baseUrl/courses';
  static const String usersEndpoint = '$baseUrl/users';
  static const String authEndpoint = '$baseUrl/auth';

  // Storage Keys
  static const String authTokenKey = 'auth_token';
  static const String userIdKey = 'user_id';
  static const String themeModeKey = 'theme_mode';

  // Animation Durations
  static const Duration defaultAnimationDuration = Duration(milliseconds: 300);
  static const Duration shortAnimationDuration = Duration(milliseconds: 200);
  static const Duration longAnimationDuration = Duration(milliseconds: 500);

  // Pagination
  static const int defaultPageSize = 10;
  static const int maxPageSize = 50;

  // Validation
  static const int minPasswordLength = 8;
  static const int maxPasswordLength = 32;
  static const int minUsernameLength = 3;
  static const int maxUsernameLength = 20;

  // Error Messages
  static const String networkError = 'Network error occurred';
  static const String serverError = 'Server error occurred';
  static const String unknownError = 'An unknown error occurred';
  static const String invalidCredentials = 'Invalid email or password';
  static const String emailAlreadyInUse = 'Email is already in use';
  static const String weakPassword = 'Password is too weak';
  static const String invalidEmail = 'Invalid email format';

  // Success Messages
  static const String loginSuccess = 'Successfully logged in';
  static const String registerSuccess = 'Successfully registered';
  static const String passwordResetSuccess = 'Password reset email sent';
  static const String profileUpdateSuccess = 'Profile updated successfully';
  static const String courseEnrollSuccess = 'Successfully enrolled in course';
}
