import 'dart:convert';
import 'package:flutter/services.dart';
import '../config/constants.dart';
import '../../data/models/course.dart';
import '../../data/models/user.dart';

class MockDataProvider {
  static Future<List<Course>> getMockCourses() async {
    if (!AppConstants.useMockData) {
      throw Exception('Mock data is disabled');
    }

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
          description: 'Learn the basics of Flutter development',
          instructorId: '1',
          instructorName: 'John Doe',
          instructorAvatar: 'https://example.com/john.jpg',
          category: 'Mobile Development',
          level: 'Beginner',
          rating: 4.5,
          reviews: 100,
          students: 1000,
          thumbnail: 'https://example.com/flutter.jpg',
          objectives: const [
            'Understand Flutter basics',
            'Build your first Flutter app',
            'Learn about widgets and layouts',
          ],
          requirements: const [
            'Basic programming knowledge',
            'Dart programming language',
          ],
          sections: const [],
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
        Course(
          id: '2',
          title: 'Advanced Flutter',
          description: 'Master advanced Flutter concepts',
          instructorId: '2',
          instructorName: 'Jane Smith',
          instructorAvatar: 'https://example.com/jane.jpg',
          category: 'Mobile Development',
          level: 'Advanced',
          rating: 4.8,
          reviews: 50,
          students: 500,
          thumbnail: 'https://example.com/advanced-flutter.jpg',
          objectives: const [
            'Master state management',
            'Learn advanced animations',
            'Build complex UIs',
          ],
          requirements: const [
            'Intermediate Flutter knowledge',
            'Understanding of state management',
          ],
          sections: const [],
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      ];
    }
  }

  static Future<User> getMockUser() async {
    if (!AppConstants.useMockData) {
      throw Exception('Mock data is disabled');
    }

    try {
      final String jsonString = await rootBundle.loadString(
        '${AppConstants.mockDataPath}user.json',
      );
      final Map<String, dynamic> json = jsonDecode(jsonString);
      return User.fromJson(json);
    } catch (e) {
      // Return hardcoded mock data if file loading fails
      return User(
        id: '1',
        email: 'test@example.com',
        fullName: 'Test User',
        avatar: 'https://example.com/avatar.jpg',
        bio: 'A test user for development purposes',
        isInstructor: false,
        enrolledCourses: null,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
    }
  }

  static Future<List<Course>> searchCourses(String query) async {
    final courses = await getMockCourses();
    return courses.where((course) {
      return course.title.toLowerCase().contains(query.toLowerCase()) ||
          course.description.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }

  static Future<List<Course>> getCoursesByCategory(String category) async {
    final courses = await getMockCourses();
    return courses
        .where(
            (course) => course.category.toLowerCase() == category.toLowerCase())
        .toList();
  }

  static Future<List<Course>> getCoursesByLevel(String level) async {
    final courses = await getMockCourses();
    return courses
        .where((course) => course.level.toLowerCase() == level.toLowerCase())
        .toList();
  }

  static Future<Course> getCourseDetails(String courseId) async {
    final courses = await getMockCourses();
    return courses.firstWhere(
      (course) => course.id == courseId,
      orElse: () => throw Exception('Course not found'),
    );
  }
}
