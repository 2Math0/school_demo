import 'package:go_router/go_router.dart';
import '../presentation/screens/auth/login_screen.dart';
import '../presentation/screens/auth/signup_screen.dart';
import '../presentation/screens/home/home_screen.dart';
import '../presentation/screens/course/course_detail_screen.dart';
import '../presentation/screens/course/lesson_detail_screen.dart';
import '../presentation/screens/chat/chat_screen.dart';
import '../presentation/screens/profile/profile_screen.dart';
import '../presentation/screens/settings/settings_screen.dart';
import '../presentation/screens/notifications/notifications_screen.dart';
import '../presentation/screens/not_found/not_found_screen.dart';

// Route names as constants for easy reference
abstract class AppRoutes {
  static const login = '/login';
  static const signup = '/signup';
  static const home = '/';
  static const courseDetail = '/course/:id';
  static const lessonDetail = '/lesson/:courseId/:lessonId';
  static const chat = '/chat';
  static const profile = '/profile';
  static const settings = '/settings';
  static const notifications = '/notifications';
}

GoRouter createRouter({
  required bool isAuthenticated,
  required bool isAdmin,
}) {
  return GoRouter(
    initialLocation: isAuthenticated ? AppRoutes.home : AppRoutes.login,
    redirect: (context, state) {
      if (!isAuthenticated) {
        if (state.matchedLocation != AppRoutes.login &&
            state.matchedLocation != AppRoutes.signup) {
          return AppRoutes.login;
        }
      } else {
        if (state.matchedLocation == AppRoutes.login ||
            state.matchedLocation == AppRoutes.signup) {
          return AppRoutes.home;
        }
      }
      return null;
    },
    errorBuilder: (context, state) => const NotFoundScreen(),
    routes: [
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.signup,
        builder: (context, state) => const SignupScreen(),
      ),
      GoRoute(
        path: AppRoutes.courseDetail,
        builder: (context, state) => CourseDetailScreen(
          courseId: state.pathParameters['id']!,
        ),
      ),
      GoRoute(
        path: AppRoutes.lessonDetail,
        builder: (context, state) => LessonDetailScreen(
          // courseId: state.pathParameters['courseId']!,
          lessonId: state.pathParameters['lessonId']!,
          lessonTitle: state.uri.queryParameters['title'] ?? '',
        ),
      ),
      GoRoute(
        path: AppRoutes.chat,
        builder: (context, state) => ChatScreen(
          chatId: state.uri.queryParameters['chatId'] ?? '',
          recipientName: state.uri.queryParameters['recipientName'] ?? '',
        ),
      ),
      GoRoute(
        path: AppRoutes.profile,
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: AppRoutes.settings,
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        path: AppRoutes.notifications,
        builder: (context, state) => const NotificationsScreen(),
      ),
    ],
  );
}
