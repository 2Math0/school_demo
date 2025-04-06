import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../presentation/screens/auth/login_screen.dart';
import '../presentation/screens/auth/signup_screen.dart';
import '../presentation/screens/admin/admin_dashboard.dart';
import '../presentation/screens/admin/manage_courses_screen.dart';
import '../presentation/screens/admin/manage_users_screen.dart';
import '../presentation/screens/admin/course_upload_screen.dart';
import '../presentation/screens/student/student_dashboard.dart';
import '../presentation/screens/student/course_list_screen.dart';
import '../presentation/screens/student/course_detail_screen.dart';
import '../presentation/screens/student/video_player_screen.dart';
import '../presentation/screens/student/quiz_screen.dart';
import '../presentation/screens/student/progress_screen.dart';
import '../presentation/screens/shared/chatbot_screen.dart';
import '../presentation/screens/shared/profile_screen.dart';
import '../presentation/screens/shared/not_found_screen.dart';

// Route names as constants for easy reference
abstract class AppRoutes {
  static const login = '/login';
  static const signup = '/signup';
  static const studentDashboard = '/student';
  static const adminDashboard = '/admin';
  static const courseList = '/courses';
  static const courseDetail = '/courses/:courseId';
  static const videoPlayer = '/courses/:courseId/video/:videoId';
  static const quiz = '/courses/:courseId/quiz/:quizId';
  static const progress = '/progress';
  static const chatbot = '/chatbot';
  static const profile = '/profile';
  static const manageCourses = '/admin/courses';
  static const manageUsers = '/admin/users';
  static const courseUpload = '/admin/courses/upload';
}

GoRouter createRouter({
  required bool isAuthenticated,
  required bool isAdmin,
}) {
  return GoRouter(
    initialLocation: isAuthenticated
        ? (isAdmin ? AppRoutes.adminDashboard : AppRoutes.studentDashboard)
        : AppRoutes.login,
    redirect: (context, state) {
      // Check if the user is trying to access an admin route
      final isAdminRoute = state.matchedLocation.startsWith('/admin');

      // Handle authentication redirects
      if (!isAuthenticated) {
        // If not authenticated, redirect to login unless already on login or signup
        if (state.matchedLocation != AppRoutes.login &&
            state.matchedLocation != AppRoutes.signup) {
          return AppRoutes.login;
        }
      } else {
        // If authenticated but on login or signup, redirect to dashboard
        if (state.matchedLocation == AppRoutes.login ||
            state.matchedLocation == AppRoutes.signup) {
          return isAdmin ? AppRoutes.adminDashboard : AppRoutes.studentDashboard;
        }

        // If not admin but trying to access admin routes, redirect to student dashboard
        if (!isAdmin && isAdminRoute) {
          return AppRoutes.studentDashboard;
        }
      }

      // No redirect needed
      return null;
    },
    errorBuilder: (context, state) => const NotFoundScreen(),
    routes: [
      // Auth routes
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.signup,
        builder: (context, state) => const SignupScreen(),
      ),

      // Student routes
      GoRoute(
        path: AppRoutes.studentDashboard,
        builder: (context, state) => const StudentDashboard(),
      ),
      GoRoute(
        path: AppRoutes.courseList,
        builder: (context, state) => const CourseListScreen(),
      ),
      GoRoute(
        path: AppRoutes.courseDetail,
        builder: (context, state) {
          final courseId = state.pathParameters['courseId'] ?? '';
          return CourseDetailScreen(courseId: courseId);
        },
      ),
      GoRoute(
        path: AppRoutes.videoPlayer,
        builder: (context, state) {
          final courseId = state.pathParameters['courseId'] ?? '';
          final videoId = state.pathParameters['videoId'] ?? '';
          return VideoPlayerScreen(courseId: courseId, videoId: videoId);
        },
      ),
      GoRoute(
        path: AppRoutes.quiz,
        builder: (context, state) {
          final courseId = state.pathParameters['courseId'] ?? '';
          final quizId = state.pathParameters['quizId'] ?? '';
          return QuizScreen(courseId: courseId, quizId: quizId);
        },
      ),
      GoRoute(
        path: AppRoutes.progress,
        builder: (context, state) => const ProgressScreen(),
      ),

      // Admin routes
      GoRoute(
        path: AppRoutes.adminDashboard,
        builder: (context, state) => const AdminDashboard(),
      ),
      GoRoute(
        path: AppRoutes.manageCourses,
        builder: (context, state) => const ManageCoursesScreen(),
      ),
      GoRoute(
        path: AppRoutes.manageUsers,
        builder: (context, state) => const ManageUsersScreen(),
      ),
      GoRoute(
        path: AppRoutes.courseUpload,
        builder: (context, state) => const CourseUploadScreen(),
      ),

      // Shared routes
      GoRoute(
        path: AppRoutes.chatbot,
        builder: (context, state) => const ChatbotScreen(),
      ),
      GoRoute(
        path: AppRoutes.profile,
        builder: (context, state) => const ProfileScreen(),
      ),
    ],
  );
}