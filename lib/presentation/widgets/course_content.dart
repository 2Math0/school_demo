import 'package:flutter/material.dart';
import '../../data/models/course.dart';

class CourseContent extends StatelessWidget {
  final List<Section> sections;

  const CourseContent({super.key, required this.sections});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: sections.length,
      itemBuilder: (context, index) {
        final section = sections[index];
        return _SectionCard(section: section);
      },
    );
  }
}

class _SectionCard extends StatelessWidget {
  final Section section;

  const _SectionCard({required this.section});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: ExpansionTile(
        title: Text(
          section.title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        subtitle: Text(
          section.description,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        children: section.lessons.map((lesson) {
          return _LessonTile(lesson: lesson);
        }).toList(),
      ),
    );
  }
}

class _LessonTile extends StatelessWidget {
  final Lesson lesson;

  const _LessonTile({required this.lesson});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        lesson.isPreview ? Icons.lock_open : Icons.lock,
        color: lesson.isPreview ? Colors.green : Colors.grey,
      ),
      title: Text(
        lesson.title,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      subtitle: Text(
        '${lesson.duration} minutes',
        style: Theme.of(context).textTheme.bodySmall,
      ),
      trailing: const Icon(Icons.play_circle_outline),
      onTap: () {
        // TODO: Navigate to lesson player
      },
    );
  }
}
