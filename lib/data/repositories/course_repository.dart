import '../../core/services/supabase_service.dart';
import '../../core/exceptions/app_exception.dart';
import '../models/course.dart';
import 'base_repository.dart';

class CourseRepository extends BaseRepository {
  final SupabaseService _supabaseService;

  CourseRepository({required super.supabaseService})
      : _supabaseService = supabaseService;

  Future<List<Course>> getCourses({
    String? category,
    String? level,
    String? searchQuery,
  }) async {
    try {
      var query = _supabaseService.client.from('courses').select();

      if (category != null) {
        query = query.eq('category', category);
      }

      if (level != null) {
        query = query.eq('level', level);
      }

      if (searchQuery != null) {
        query = query.ilike('title', '%$searchQuery%');
      }

      final response = await query;
      return response.map((course) => Course.fromJson(course)).toList();
    } catch (e) {
      throw Exception('Failed to get courses: $e');
    }
  }

  Future<Course> getCourseDetails(String courseId) async {
    try {
      final response = await _supabaseService.client
          .from('courses')
          .select('*, instructor:profiles(*)')
          .eq('id', courseId)
          .single();

      return Course.fromJson(response);
    } catch (e) {
      throw Exception('Failed to get course details: $e');
    }
  }

  Future<List<Course>> getEnrolledCourses(String userId) async {
    try {
      final response = await _supabaseService.client
          .from('enrollments')
          .select('course:courses(*)')
          .eq('user_id', userId);

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
      final response = await _supabaseService.client
          .from('courses')
          .insert(course.toJson())
          .select()
          .single();

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
      final response = await _supabaseService.client
          .from('courses')
          .update(course.toJson())
          .eq('id', course.id)
          .select()
          .single();

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
      await supabaseService.client.from('courses').delete().eq('id', id);
    } catch (e) {
      throw AppException(
        message: 'Failed to delete course',
        details: e.toString(),
      );
    }
  }

  Future<void> enrollInCourse({
    required String userId,
    required String courseId,
  }) async {
    try {
      await supabaseService.client.from('enrollments').insert({
        'user_id': userId,
        'course_id': courseId,
        'enrolled_at': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      throw AppException(
        message: 'Failed to enroll in course',
        details: e.toString(),
      );
    }
  }

  Future<void> unenrollFromCourse({
    required String userId,
    required String courseId,
  }) async {
    try {
      await supabaseService.client
          .from('enrollments')
          .delete()
          .eq('user_id', userId)
          .eq('course_id', courseId);
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
      final response = await supabaseService.client
          .from('enrollments')
          .select()
          .eq('user_id', userId)
          .eq('course_id', courseId)
          .single();

      return response != null;
    } catch (e) {
      return false;
    }
  }
}
