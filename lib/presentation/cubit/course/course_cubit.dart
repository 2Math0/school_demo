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
  }) : super(const CourseInitial());

  Future<void> loadCourses({
    String? category,
    String? level,
    String? searchQuery,
  }) async {
    try {
      emit(const CourseLoading());
      final courses = await courseRepository.getCourses(
        category: category,
        level: level,
        searchQuery: searchQuery,
      );
      emit(CourseLoaded(courses: courses));
    } catch (e) {
      emit(CourseError(message: e.toString()));
    }
  }

  Future<void> loadCourseDetails(String courseId) async {
    try {
      emit(const CourseLoading());
      final course = await courseRepository.getCourseDetails(courseId);
      emit(CourseDetailsLoaded(course: course));
    } catch (e) {
      emit(CourseError(message: e.toString()));
    }
  }

  Future<void> enrollInCourse(String courseId) async {
    try {
      emit(const CourseLoading());
      await courseRepository.enrollInCourse(courseId: courseId, userId: userId);
      final course = await courseRepository.getCourseDetails(courseId);
      emit(CourseDetailsLoaded(course: course));
    } catch (e) {
      emit(CourseError(message: e.toString()));
    }
  }
}
