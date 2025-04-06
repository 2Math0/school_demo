import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../data/models/progress.dart';
import '../../../data/repositories/progress_repository.dart';

part 'progress_state.dart';

class ProgressCubit extends Cubit<ProgressState> {
  final ProgressRepository progressRepository;
  final String userId;

  ProgressCubit({
    required this.progressRepository,
    required this.userId,
  }) : super(const ProgressInitial());

  Future<void> loadProgress(String courseId) async {
    try {
      emit(const ProgressLoading());
      final progress = await progressRepository.getProgress(
        userId: userId,
        courseId: courseId,
      );
      emit(ProgressLoaded(progress: progress));
    } catch (e) {
      emit(ProgressError(message: e.toString()));
    }
  }

  Future<void> updateProgress({
    required String courseId,
    required List<String> completedLessons,
    required int totalLessons,
    required double progress,
    String? currentLesson,
  }) async {
    try {
      emit(const ProgressLoading());
      await progressRepository.updateProgress(
        userId: userId,
        courseId: courseId,
        completedLessons: completedLessons,
        totalLessons: totalLessons,
        progress: progress,
        currentLesson: currentLesson,
      );
      final updatedProgress = await progressRepository.getProgress(
        userId: userId,
        courseId: courseId,
      );
      emit(ProgressLoaded(progress: updatedProgress));
    } catch (e) {
      emit(ProgressError(message: e.toString()));
    }
  }

  Future<void> loadOverallProgress() async {
    try {
      emit(const ProgressLoading());
      final stats = await progressRepository.getProgressStats(userId);
      emit(OverallProgressLoaded(stats: stats));
    } catch (e) {
      emit(ProgressError(message: e.toString()));
    }
  }
}
