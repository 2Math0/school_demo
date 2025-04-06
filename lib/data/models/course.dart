import 'package:equatable/equatable.dart';
import 'base_model.dart';
import 'user.dart';

class Course extends BaseModel {
  final String title;
  final String description;
  final User instructor;
  final String thumbnail;
  final String category;
  final String level;
  final int duration;
  final double rating;
  final int totalStudents;
  final double price;
  final List<String> requirements;
  final List<String> whatYouWillLearn;
  final List<Section> sections;

  const Course({
    required String id,
    required this.title,
    required this.description,
    required this.instructor,
    required this.thumbnail,
    required this.category,
    required this.level,
    required this.duration,
    required this.rating,
    required this.totalStudents,
    required this.price,
    required this.requirements,
    required this.whatYouWillLearn,
    required this.sections,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super(
          id: id,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      instructor: User.fromJson(json['instructor'] as Map<String, dynamic>),
      thumbnail: json['thumbnail'] as String,
      category: json['category'] as String,
      level: json['level'] as String,
      duration: json['duration'] as int,
      rating: (json['rating'] as num).toDouble(),
      totalStudents: json['totalStudents'] as int,
      price: (json['price'] as num).toDouble(),
      requirements: (json['requirements'] as List).cast<String>(),
      whatYouWillLearn: (json['whatYouWillLearn'] as List).cast<String>(),
      sections: (json['sections'] as List)
          .map((e) => Section.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'instructor': instructor.toJson(),
      'thumbnail': thumbnail,
      'category': category,
      'level': level,
      'duration': duration,
      'rating': rating,
      'totalStudents': totalStudents,
      'price': price,
      'requirements': requirements,
      'whatYouWillLearn': whatYouWillLearn,
      'sections': sections.map((e) => e.toJson()).toList(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  Course copyWith({
    String? id,
    String? title,
    String? description,
    User? instructor,
    String? thumbnail,
    String? category,
    String? level,
    int? duration,
    double? rating,
    int? totalStudents,
    double? price,
    List<String>? requirements,
    List<String>? whatYouWillLearn,
    List<Section>? sections,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Course(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      instructor: instructor ?? this.instructor,
      thumbnail: thumbnail ?? this.thumbnail,
      category: category ?? this.category,
      level: level ?? this.level,
      duration: duration ?? this.duration,
      rating: rating ?? this.rating,
      totalStudents: totalStudents ?? this.totalStudents,
      price: price ?? this.price,
      requirements: requirements ?? this.requirements,
      whatYouWillLearn: whatYouWillLearn ?? this.whatYouWillLearn,
      sections: sections ?? this.sections,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class Section extends Equatable {
  final String id;
  final String title;
  final List<Lesson> lessons;

  const Section({
    required this.id,
    required this.title,
    required this.lessons,
  });

  factory Section.fromJson(Map<String, dynamic> json) {
    return Section(
      id: json['id'] as String,
      title: json['title'] as String,
      lessons: (json['lessons'] as List)
          .map((e) => Lesson.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'lessons': lessons.map((e) => e.toJson()).toList(),
    };
  }

  @override
  List<Object?> get props => [id, title, lessons];
}

class Lesson extends Equatable {
  final String id;
  final String title;
  final String type;
  final int duration;
  final bool preview;

  const Lesson({
    required this.id,
    required this.title,
    required this.type,
    required this.duration,
    this.preview = false,
  });

  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(
      id: json['id'] as String,
      title: json['title'] as String,
      type: json['type'] as String,
      duration: json['duration'] as int,
      preview: json['preview'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'type': type,
      'duration': duration,
      'preview': preview,
    };
  }

  @override
  List<Object?> get props => [id, title, type, duration, preview];
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
