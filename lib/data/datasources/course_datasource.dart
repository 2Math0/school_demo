import 'package:school_demo/data/models/course.dart';
import '../../core/services/api_service.dart';

class CourseDataSource {
  final ApiService _apiService;

  CourseDataSource({required ApiService apiService}) : _apiService = apiService;

  Future<List<Map<String, dynamic>>> getCourses() async {
    final courses = await _apiService.getCourses();
    return courses.map((course) => course.toJson()).toList();
  }

  Future<List<Map<String, dynamic>>> searchCourses(String query) async {
    final courses = await _apiService.getCourses(search: query);
    return courses.map((course) => course.toJson()).toList();
  }

  Future<Map<String, dynamic>> getCourseById(String courseId) async {
    final course = await _apiService.getCourseDetails(courseId);
    return course.toJson();
  }

  Future<void> enrollInCourse(String userId, String courseId) async {
    await _apiService.enrollInCourse(courseId);
  }

  Future<List<Map<String, dynamic>>> getEnrolledCourses(String userId) async {
    final user = await _apiService.getUserProfile(userId);
    if (user.enrolledCourses == null) return [];
    return user.enrolledCourses!.map((course) => course.toJson()).toList();
  }

  Future<Map<String, dynamic>> createCourse(Course course) async {
    // This method is not implemented in the API service yet
    throw UnimplementedError('createCourse is not implemented');
  }

  Future<Map<String, dynamic>> updateCourse(Course course) async {
    // This method is not implemented in the API service yet
    throw UnimplementedError('updateCourse is not implemented');
  }

  Future<void> deleteCourse(String id) async {
    // This method is not implemented in the API service yet
    throw UnimplementedError('deleteCourse is not implemented');
  }

  Future<void> unenrollFromCourse(String userId, String courseId) async {
    // This method is not implemented in the API service yet
    throw UnimplementedError('unenrollFromCourse is not implemented');
  }

  Future<Map<String, dynamic>?> isEnrolled(
      String userId, String courseId) async {
    final user = await _apiService.getUserProfile(userId);
    if (user.enrolledCourses == null) return null;
    final course = user.enrolledCourses!.firstWhere(
      (course) => course.id == courseId,
      orElse: () => throw Exception('Course not found'),
    );
    return course.toJson();
  }
}
