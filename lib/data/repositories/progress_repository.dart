import '../../core/services/api_service.dart';
import '../../core/exceptions/app_exception.dart';
import '../models/progress.dart';

class ProgressRepository {
  final ApiService apiService;

  const ProgressRepository({required this.apiService});

  Future<Progress> getProgress({
    required String userId,
    required String courseId,
  }) async {
    try {
      final response = await apiService.getCourseProgress(courseId);
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
      // This method is not implemented in the API service yet
      throw UnimplementedError('getAllProgress is not implemented');
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
        'completed_lessons': completedLessons,
        'total_lessons': totalLessons,
        'progress': progress,
        'current_lesson': currentLesson,
      };

      await apiService.updateCourseProgress(courseId, data);
      final response = await apiService.getCourseProgress(courseId);
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
      // This method is not implemented in the API service yet
      throw UnimplementedError('deleteProgress is not implemented');
    } catch (e) {
      throw AppException(
        message: 'Failed to delete progress',
        details: e.toString(),
      );
    }
  }

  Future<double> calculateOverallProgress(String userId) async {
    try {
      // This method is not implemented in the API service yet
      throw UnimplementedError('calculateOverallProgress is not implemented');
    } catch (e) {
      throw AppException(
        message: 'Failed to calculate overall progress',
        details: e.toString(),
      );
    }
  }

  Future<Map<String, dynamic>> getProgressStats(String userId) async {
    try {
      // This method is not implemented in the API service yet
      throw UnimplementedError('getProgressStats is not implemented');
    } catch (e) {
      throw AppException(
        message: 'Failed to get progress statistics',
        details: e.toString(),
      );
    }
  }
}
