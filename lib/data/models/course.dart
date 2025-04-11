import 'package:equatable/equatable.dart';

class Course extends Equatable {
  final String id;
  final String title;
  final String description;
  final String instructorId;
  final String instructorName;
  final String instructorAvatar;
  final String category;
  final String level;
  final double rating;
  final int reviews;
  final int students;
  final String thumbnail;
  final List<String> objectives;
  final List<String> requirements;
  final List<Section> sections;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Course({
    required this.id,
    required this.title,
    required this.description,
    required this.instructorId,
    required this.instructorName,
    required this.instructorAvatar,
    required this.category,
    required this.level,
    required this.rating,
    required this.reviews,
    required this.students,
    required this.thumbnail,
    required this.objectives,
    required this.requirements,
    required this.sections,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      instructorId: json['instructor_id'] as String,
      instructorName: json['instructor']['name'] as String,
      instructorAvatar: json['instructor']['avatar'] as String,
      category: json['category'] as String,
      level: json['level'] as String,
      rating: (json['rating'] as num).toDouble(),
      reviews: json['reviews'] as int,
      students: json['students'] as int,
      thumbnail: json['thumbnail'] as String,
      objectives: List<String>.from(json['objectives'] as List),
      requirements: List<String>.from(json['requirements'] as List),
      sections: (json['sections'] as List)
          .map((section) => Section.fromJson(section))
          .toList(),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'instructor_id': instructorId,
      'category': category,
      'level': level,
      'rating': rating,
      'reviews': reviews,
      'students': students,
      'thumbnail': thumbnail,
      'objectives': objectives,
      'requirements': requirements,
      'sections': sections.map((section) => section.toJson()).toList(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  @override
  List<Object> get props => [
        id,
        title,
        description,
        instructorId,
        instructorName,
        instructorAvatar,
        category,
        level,
        rating,
        reviews,
        students,
        thumbnail,
        objectives,
        requirements,
        sections,
        createdAt,
        updatedAt,
      ];
}

class Section extends Equatable {
  final String id;
  final String title;
  final String description;
  final int order;
  final List<Lesson> lessons;

  const Section({
    required this.id,
    required this.title,
    required this.description,
    required this.order,
    required this.lessons,
  });

  factory Section.fromJson(Map<String, dynamic> json) {
    return Section(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      order: json['order'] as int,
      lessons: (json['lessons'] as List)
          .map((lesson) => Lesson.fromJson(lesson))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'order': order,
      'lessons': lessons.map((lesson) => lesson.toJson()).toList(),
    };
  }

  @override
  List<Object> get props => [id, title, description, order, lessons];
}

class Lesson extends Equatable {
  final String id;
  final String title;
  final String description;
  final String content;
  final String videoUrl;
  final int duration;
  final int order;
  final bool isPreview;

  const Lesson({
    required this.id,
    required this.title,
    required this.description,
    required this.content,
    required this.videoUrl,
    required this.duration,
    required this.order,
    required this.isPreview,
  });

  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      content: json['content'] as String,
      videoUrl: json['video_url'] as String,
      duration: json['duration'] as int,
      order: json['order'] as int,
      isPreview: json['is_preview'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'content': content,
      'video_url': videoUrl,
      'duration': duration,
      'order': order,
      'is_preview': isPreview,
    };
  }

  @override
  List<Object> get props => [
        id,
        title,
        description,
        content,
        videoUrl,
        duration,
        order,
        isPreview,
      ];
}

class CourseContent extends Equatable {
  final String id;
  final String title;
  final String description;
  final ContentType type;
  final String contentUrl;
  final Duration duration;
  final List<QuizQuestion>? quizQuestions;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const CourseContent({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.contentUrl,
    required this.duration,
    this.quizQuestions,
    required this.createdAt,
    this.updatedAt,
  });

  factory CourseContent.fromJson(Map<String, dynamic> json) {
    return CourseContent(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      type: ContentType.values.firstWhere(
        (e) => e.toString() == 'ContentType.${json['type']}',
      ),
      contentUrl: json['content_url'] as String,
      duration: Duration(seconds: json['duration'] as int),
      quizQuestions: json['quiz_questions'] != null
          ? (json['quiz_questions'] as List)
              .map((question) =>
                  QuizQuestion.fromJson(question as Map<String, dynamic>))
              .toList()
          : null,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'type': type.toString().split('.').last,
      'content_url': contentUrl,
      'duration': duration.inSeconds,
      'quiz_questions': quizQuestions?.map((q) => q.toJson()).toList(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        type,
        contentUrl,
        duration,
        quizQuestions,
        createdAt,
        updatedAt,
      ];
}

class QuizQuestion extends Equatable {
  final String id;
  final String question;
  final List<String> options;
  final int correctAnswerIndex;
  final String? explanation;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const QuizQuestion({
    required this.id,
    required this.question,
    required this.options,
    required this.correctAnswerIndex,
    this.explanation,
    required this.createdAt,
    this.updatedAt,
  });

  factory QuizQuestion.fromJson(Map<String, dynamic> json) {
    return QuizQuestion(
      id: json['id'] as String,
      question: json['question'] as String,
      options: List<String>.from(json['options'] as List),
      correctAnswerIndex: json['correct_answer_index'] as int,
      explanation: json['explanation'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'question': question,
      'options': options,
      'correct_answer_index': correctAnswerIndex,
      'explanation': explanation,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  @override
  List<Object?> get props => [
        id,
        question,
        options,
        correctAnswerIndex,
        explanation,
        createdAt,
        updatedAt,
      ];
}

enum ContentType {
  video,
  quiz,
  document,
  assignment,
}
