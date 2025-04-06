import '../../core/services/supabase_service.dart';
import '../../core/exceptions/app_exception.dart';
import '../models/progress.dart';

class ProgressRepository {
  final SupabaseService supabaseService;

  const ProgressRepository({required this.supabaseService});

  Future<Progress> getProgress({
    required String userId,
    required String courseId,
  }) async {
    try {
      final response = await supabaseService.client
          .from('progress')
          .select()
          .eq('user_id', userId)
          .eq('course_id', courseId)
          .single();

      return Progress.fromJson(response);
    } catch (e) {
      throw AppException(
        message: 'Failed to fetch progress',
        details: e.toString(),
      );
    }
  }

  Future<List<Progress>> getAllProgress(String userId) async {
    try {
      final response = await supabaseService.client
          .from('progress')
          .select()
          .eq('user_id', userId);

      return response.map((json) => Progress.fromJson(json)).toList();
    } catch (e) {
      throw AppException(
        message: 'Failed to fetch all progress',
        details: e.toString(),
      );
    }
  }

  Future<Progress> updateProgress({
    required String userId,
    required String courseId,
    required List<String> completedLessons,
    required int totalLessons,
    required double progress,
    String? currentLesson,
  }) async {
    try {
      final data = {
        'user_id': userId,
        'course_id': courseId,
        'completed_lessons': completedLessons,
        'total_lessons': totalLessons,
        'progress': progress,
        'current_lesson': currentLesson,
        'last_accessed': DateTime.now().toIso8601String(),
      };

      final response = await supabaseService.client
          .from('progress')
          .upsert(data)
          .select()
          .single();

      return Progress.fromJson(response);
    } catch (e) {
      throw AppException(
        message: 'Failed to update progress',
        details: e.toString(),
      );
    }
  }

  Future<void> deleteProgress({
    required String userId,
    required String courseId,
  }) async {
    try {
      await supabaseService.client
          .from('progress')
          .delete()
          .eq('user_id', userId)
          .eq('course_id', courseId);
    } catch (e) {
      throw AppException(
        message: 'Failed to delete progress',
        details: e.toString(),
      );
    }
  }

  Future<double> calculateOverallProgress(String userId) async {
    try {
      final allProgress = await getAllProgress(userId);
      if (allProgress.isEmpty) return 0.0;

      double totalProgress = 0.0;
      for (var progress in allProgress) {
        totalProgress += progress.progress;
      }

      return totalProgress / allProgress.length;
    } catch (e) {
      throw AppException(
        message: 'Failed to calculate overall progress',
        details: e.toString(),
      );
    }
  }

  Future<Map<String, dynamic>> getProgressStats(String userId) async {
    try {
      final allProgress = await getAllProgress(userId);

      int totalCompletedLessons = 0;
      int totalLessons = 0;
      double totalScore = 0.0;
      int completedCourses = 0;

      for (var progress in allProgress) {
        totalCompletedLessons += progress.completedLessons.length;
        totalLessons += progress.totalLessons;
        totalScore += progress.progress;

        if (progress.completedLessons.length == progress.totalLessons) {
          completedCourses++;
        }
      }

      return {
        'total_completed_lessons': totalCompletedLessons,
        'total_lessons': totalLessons,
        'average_score':
            allProgress.isEmpty ? 0.0 : totalScore / allProgress.length,
        'completed_courses': completedCourses,
        'in_progress_courses': allProgress.length - completedCourses,
        'overall_progress': await calculateOverallProgress(userId),
      };
    } catch (e) {
      throw AppException(
        message: 'Failed to get progress statistics',
        details: e.toString(),
      );
    }
  }
}
