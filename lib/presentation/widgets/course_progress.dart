import 'package:flutter/material.dart';
import '../../data/models/course.dart';

class CourseProgress extends StatelessWidget {
  final Course course;

  const CourseProgress({
    super.key,
    required this.course,
  });

  @override
  Widget build(BuildContext context) {
    final totalLessons = course.sections.fold<int>(
      0,
      (sum, section) => sum + section.lessons.length,
    );

    final completedLessons = course.sections.fold<int>(
      0,
      (sum, section) =>
          sum + section.lessons.where((lesson) => lesson.isPreview).length,
    );

    final progress = completedLessons / totalLessons;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Course Progress',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            LinearProgressIndicator(
              value: progress,
              backgroundColor:
                  Theme.of(context).colorScheme.surfaceContainerHighest,
              valueColor: AlwaysStoppedAnimation<Color>(
                Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${(progress * 100).toStringAsFixed(0)}% Complete',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  '$completedLessons of $totalLessons lessons',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
