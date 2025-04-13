import 'package:equatable/equatable.dart';
import 'base_model.dart';

class Progress extends BaseModel {
  final String courseId;
  final String userId;
  final List<String> completedLessons;
  final String? currentLesson;
  final double progress;
  final DateTime lastAccessed;
  final List<String> allLessons;
  final int totalLessons;

  const Progress({
    required super.id,
    required this.courseId,
    required this.userId,
    required this.completedLessons,
    required this.totalLessons,
    this.currentLesson,
    required this.progress,
    required this.lastAccessed,
    required super.createdAt,
    required super.updatedAt,
    required this.allLessons,
  });

  factory Progress.fromJson(Map<String, dynamic> json) {
    return Progress(
      id: json['id'] as String,
      courseId: json['courseId'] as String,
      userId: json['userId'] as String,
      completedLessons: (json['completedLessons'] as List).cast<String>(),
      allLessons: (json['allLessons'] as List).cast<String>(),
      currentLesson: json['currentLesson'] as String?,
      progress: (json['progress'] as num).toDouble(),
      lastAccessed: DateTime.parse(json['lastAccessed'] as String),
      totalLessons: json['totalLessons'] as int,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'courseId': courseId,
      'userId': userId,
      'completedLessons': completedLessons,
      'currentLesson': currentLesson,
      'progress': progress,
      'lastAccessed': lastAccessed.toIso8601String(),
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'totalLessons': totalLessons,
    };
  }

  Progress copyWith({
    String? id,
    String? courseId,
    String? userId,
    List<String>? completedLessons,
    String? currentLesson,
    double? progress,
    DateTime? lastAccessed,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<String>? allLessons,
    int? totalLessons,
  }) {
    return Progress(
      id: id ?? this.id,
      courseId: courseId ?? this.courseId,
      userId: userId ?? this.userId,
      completedLessons: completedLessons ?? this.completedLessons,
      currentLesson: currentLesson ?? this.currentLesson,
      progress: progress ?? this.progress,
      lastAccessed: lastAccessed ?? this.lastAccessed,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      allLessons: allLessons ?? this.allLessons,
      totalLessons: totalLessons ?? this.totalLessons,
    );
  }

  @override
  List<Object?> get props => [
        id,
        userId,
        courseId,
        completedLessons,
        totalLessons,
        progress,
        currentLesson,
        lastAccessed,
      ];
}

class QuizResult extends Equatable {
  final String questionId;
  final int selectedAnswerIndex;
  final bool isCorrect;
  final DateTime answeredAt;

  const QuizResult({
    required this.questionId,
    required this.selectedAnswerIndex,
    required this.isCorrect,
    required this.answeredAt,
  });

  factory QuizResult.fromJson(Map<String, dynamic> json) {
    return QuizResult(
      questionId: json['question_id'] as String,
      selectedAnswerIndex: json['selected_answer_index'] as int,
      isCorrect: json['is_correct'] as bool,
      answeredAt: DateTime.parse(json['answered_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'question_id': questionId,
      'selected_answer_index': selectedAnswerIndex,
      'is_correct': isCorrect,
      'answered_at': answeredAt.toIso8601String(),
    };
  }

  @override
  List<Object?> get props => [
        questionId,
        selectedAnswerIndex,
        isCorrect,
        answeredAt,
      ];
}
