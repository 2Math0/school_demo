import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/course/course_cubit.dart';
import '../../widgets/course_content.dart';
import '../../widgets/course_progress.dart';

class CourseDetailsScreen extends StatefulWidget {
  final String courseId;

  const CourseDetailsScreen({
    super.key,
    required this.courseId,
  });

  @override
  State<CourseDetailsScreen> createState() => _CourseDetailsScreenState();
}

class _CourseDetailsScreenState extends State<CourseDetailsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CourseCubit>().loadCourseDetails(widget.courseId);
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 1200;
    final isTablet = MediaQuery.of(context).size.width > 600;

    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<CourseCubit, CourseState>(
          builder: (context, state) {
            if (state is CourseDetailsLoaded) {
              return Text(state.course.title);
            }
            return const Text('Course Details');
          },
        ),
      ),
      body: BlocBuilder<CourseCubit, CourseState>(
        builder: (context, state) {
          if (state is CourseLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is CourseError) {
            return Center(child: Text(state.message));
          }

          if (state is CourseDetailsLoaded) {
            final course = state.course;
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isDesktop
                      ? 32
                      : isTablet
                          ? 24
                          : 16,
                  vertical: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AspectRatio(
                      aspectRatio: 16 / 9,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          course.thumbnail,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      course.title,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 16,
                          backgroundImage:
                              NetworkImage(course.instructorAvatar),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          course.instructorName,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          course.rating.toStringAsFixed(1),
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '(${course.reviews} reviews)',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(width: 16),
                        const Icon(
                          Icons.people,
                          color: Colors.grey,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${course.students} students',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        _buildTag(context, course.level),
                        const SizedBox(width: 8),
                        _buildTag(context, course.category),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'About this course',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      course.description,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'What you will learn',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    ...course.objectives.map((objective) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.check_circle,
                              color: Colors.green,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                objective,
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                    const SizedBox(height: 24),
                    Text(
                      'Requirements',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    ...course.requirements.map((requirement) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.circle,
                              size: 8,
                              color: Colors.grey,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                requirement,
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                    const SizedBox(height: 24),
                    Text(
                      'Course Content',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    CourseContent(sections: course.sections),
                    const SizedBox(height: 24),
                    CourseProgress(course: course),
                  ],
                ),
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: BlocBuilder<CourseCubit, CourseState>(
        builder: (context, state) {
          if (state is CourseDetailsLoaded) {
            return FilledButton(
              onPressed: () {
                context.read<CourseCubit>().enrollInCourse(state.course.id);
              },
              child: const Text('Enroll Now'),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildTag(BuildContext context, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.onSecondaryContainer,
            ),
      ),
    );
  }
}
