import 'package:flutter/services.dart';
import 'dart:convert';
import '../config/constants.dart';
import 'api_service.dart';
import '../../data/models/course.dart';
import '../../data/models/user.dart';

class MockApiService implements ApiService {
  @override
  Future<Map<String, dynamic>> signUp({
    required String email,
    required String password,
    required Map<String, dynamic> userMetadata,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    return {
      'user': {
        'id': 'mock-user-id',
        'email': email,
        'user_metadata': userMetadata,
        'created_at': DateTime.now().toIso8601String(),
        'updated_at': DateTime.now().toIso8601String(),
      },
      'session': {
        'access_token': 'mock-access-token',
        'refresh_token': 'mock-refresh-token',
      },
    };
  }

  @override
  Future<Map<String, dynamic>> signIn({
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    return {
      'user': {
        'id': 'mock-user-id',
        'email': email,
        'user_metadata': {
          'fullName': 'Mock User',
          'isInstructor': false,
          'avatar': 'https://example.com/avatar.jpg',
          'bio': 'Mock user bio',
        },
      },
      'session': {
        'access_token': 'mock-access-token',
        'refresh_token': 'mock-refresh-token',
      },
    };
  }

  @override
  Future<void> signOut() async {
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Future<void> resetPassword(String email) async {
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Future<User> getUserProfile(String userId) async {
    await Future.delayed(const Duration(seconds: 1));
    return User(
      id: userId,
      email: 'mock@example.com',
      fullName: 'Mock User',
      avatar: 'https://example.com/avatar.jpg',
      bio: 'Mock user bio',
      isInstructor: false,
      enrolledCourses: null,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  @override
  Future<User> updateUserProfile(
      String userId, Map<String, dynamic> userMetadata) async {
    await Future.delayed(const Duration(seconds: 1));
    return User(
      id: userId,
      email: 'mock@example.com',
      fullName: userMetadata['fullName'] ?? 'Mock User',
      avatar: userMetadata['avatar'] ?? 'https://example.com/avatar.jpg',
      bio: userMetadata['bio'] ?? 'Mock user bio',
      isInstructor: userMetadata['isInstructor'] ?? false,
      enrolledCourses: null,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  @override
  Future<List<Course>> getCourses({
    String? category,
    String? level,
    String? search,
    bool? isFeatured,
    bool? isPopular,
    int? limit,
    int? offset,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    try {
      final String jsonString = await rootBundle.loadString(
        '${AppConstants.mockDataPath}courses.json',
      );
      final List<dynamic> jsonList = json.decode(jsonString);
      return jsonList.map((json) => Course.fromJson(json)).toList();
    } catch (e) {
      return [
        Course(
          id: '1',
          title: 'Introduction to Flutter',
          description: 'Learn Flutter from scratch',
          instructorId: '1',
          instructorName: 'John Doe',
          instructorAvatar: 'https://example.com/john.jpg',
          category: 'Mobile Development',
          level: 'Beginner',
          rating: 4.5,
          reviews: 100,
          students: 1000,
          thumbnail: 'https://example.com/flutter.jpg',
          objectives: const ['Learn Flutter basics', 'Build your first app'],
          requirements: const ['Basic programming knowledge'],
          sections: const [],
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      ];
    }
  }

  @override
  Future<Course> getCourseDetails(String courseId) async {
    await Future.delayed(const Duration(seconds: 1));
    final courses = await getCourses();
    return courses.firstWhere(
      (course) => course.id == courseId,
      orElse: () => throw Exception('Course not found'),
    );
  }

  @override
  Future<void> enrollInCourse(String courseId) async {
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Future<Map<String, dynamic>> getCourseProgress(String courseId) async {
    await Future.delayed(const Duration(seconds: 1));
    return {
      'id': 'mock-progress-id',
      'course_id': courseId,
      'user_id': 'mock-user-id',
      'completed_lessons': [],
      'current_lesson': null,
      'progress': 0,
      'last_accessed': DateTime.now().toIso8601String(),
      'created_at': DateTime.now().toIso8601String(),
      'updated_at': DateTime.now().toIso8601String(),
    };
  }

  @override
  Future<void> updateCourseProgress(
      String courseId, Map<String, dynamic> progress) async {
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Future<String> uploadCourseThumbnail(String filePath) async {
    await Future.delayed(const Duration(seconds: 1));
    return 'https://example.com/thumbnail.jpg';
  }

  @override
  Future<String> uploadLessonVideo(String filePath) async {
    await Future.delayed(const Duration(seconds: 1));
    return 'https://example.com/video.mp4';
  }
}
