import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../data/models/course.dart';
import '../../../data/repositories/course_repository.dart';

part 'course_state.dart';

class CourseCubit extends Cubit<CourseState> {
  final CourseRepository courseRepository;
  final String userId;

  CourseCubit({
    required this.courseRepository,
    required this.userId,
  }) : super(CourseInitial());

  Future<void> loadCourses({
    String? category,
    String? level,
    String? searchQuery,
  }) async {
    try {
      emit(CourseLoading());
      final courses = await courseRepository.getCourses();
      emit(CourseLoaded(courses));
    } catch (e) {
      emit(CourseError(e.toString()));
    }
  }

  Future<void> loadCourseDetails(String courseId) async {
    try {
      emit(CourseLoading());
      final course = await courseRepository.getCourseById(courseId);
      emit(CourseDetailsLoaded(course));
    } catch (e) {
      emit(CourseError(e.toString()));
    }
  }

  Future<void> enrollInCourse(String courseId) async {
    try {
      emit(CourseLoading());
      await courseRepository.enrollInCourse(courseId, userId);
      final course = await courseRepository.getCourseById(courseId);
      emit(CourseDetailsLoaded(course));
    } catch (e) {
      emit(CourseError(e.toString()));
    }
  }
}
