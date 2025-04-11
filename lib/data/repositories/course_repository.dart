import '../../core/exceptions/app_exception.dart';
import '../models/course.dart';
import '../datasources/course_datasource.dart';

class CourseRepository {
  final CourseDataSource _dataSource;

  CourseRepository({required CourseDataSource dataSource})
      : _dataSource = dataSource;

  Future<List<Course>> getCourses() async {
    try {
      final courses = await _dataSource.getCourses();
      return courses.map((course) => Course.fromJson(course)).toList();
    } catch (e) {
      throw Exception('Failed to load courses: $e');
    }
  }

  Future<List<Course>> searchCourses(String query) async {
    try {
      final courses = await _dataSource.searchCourses(query);
      return courses.map((course) => Course.fromJson(course)).toList();
    } catch (e) {
      throw Exception('Failed to search courses: $e');
    }
  }

  Future<Course> getCourseById(String courseId) async {
    try {
      final course = await _dataSource.getCourseById(courseId);
      return Course.fromJson(course);
    } catch (e) {
      throw Exception('Failed to load course details: $e');
    }
  }

  Future<void> enrollInCourse(String userId, String courseId) async {
    try {
      await _dataSource.enrollInCourse(userId, courseId);
    } catch (e) {
      throw Exception('Failed to enroll in course: $e');
    }
  }

  Future<List<Course>> getEnrolledCourses(String userId) async {
    try {
      final response = await _dataSource.getEnrolledCourses(userId);
      return response.map((json) => Course.fromJson(json['course'])).toList();
    } catch (e) {
      throw AppException(
        message: 'Failed to fetch enrolled courses',
        details: e.toString(),
      );
    }
  }

  Future<Course> createCourse(Course course) async {
    try {
      final response = await _dataSource.createCourse(course);
      return Course.fromJson(response);
    } catch (e) {
      throw AppException(
        message: 'Failed to create course',
        details: e.toString(),
      );
    }
  }

  Future<Course> updateCourse(Course course) async {
    try {
      final response = await _dataSource.updateCourse(course);
      return Course.fromJson(response);
    } catch (e) {
      throw AppException(
        message: 'Failed to update course',
        details: e.toString(),
      );
    }
  }

  Future<void> deleteCourse(String id) async {
    try {
      await _dataSource.deleteCourse(id);
    } catch (e) {
      throw AppException(
        message: 'Failed to delete course',
        details: e.toString(),
      );
    }
  }

  Future<void> unenrollFromCourse({
    required String userId,
    required String courseId,
  }) async {
    try {
      await _dataSource.unenrollFromCourse(userId, courseId);
    } catch (e) {
      throw AppException(
        message: 'Failed to unenroll from course',
        details: e.toString(),
      );
    }
  }

  Future<bool> isEnrolled({
    required String userId,
    required String courseId,
  }) async {
    try {
      final response = await _dataSource.isEnrolled(userId, courseId);
      return response != null;
    } catch (e) {
      return false;
    }
  }
}
