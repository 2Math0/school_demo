part of 'course_cubit.dart';

abstract class CourseState extends Equatable {
  const CourseState();

  @override
  List<Object?> get props => [];
}

class CourseInitial extends CourseState {
  const CourseInitial();
}

class CourseLoading extends CourseState {
  const CourseLoading();
}

class CourseLoaded extends CourseState {
  final List<Course> courses;

  const CourseLoaded({required this.courses});

  @override
  List<Object?> get props => [courses];
}

class CourseDetailsLoaded extends CourseState {
  final Course course;

  const CourseDetailsLoaded({required this.course});

  @override
  List<Object?> get props => [course];
}

class CourseError extends CourseState {
  final String message;

  const CourseError({required this.message});

  @override
  List<Object?> get props => [message];
}
