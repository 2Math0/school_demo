import 'base_model.dart';

class Lesson extends BaseModel {
  final String title;
  final String? description;
  final String content;
  final int order;
  final bool isCompleted;
  final String sectionId;
  final String courseId;

  const Lesson({
    required super.id,
    required this.title,
    this.description,
    required this.content,
    required this.order,
    required this.isCompleted,
    required this.sectionId,
    required this.courseId,
    required super.createdAt,
    required super.updatedAt,
  });

  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      content: json['content'] as String,
      order: json['order'] as int,
      isCompleted: json['isCompleted'] as bool,
      sectionId: json['sectionId'] as String,
      courseId: json['courseId'] as String,
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
      'content': content,
      'order': order,
      'isCompleted': isCompleted,
      'sectionId': sectionId,
      'courseId': courseId,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  Lesson copyWith({
    String? id,
    String? title,
    String? description,
    String? content,
    int? order,
    bool? isCompleted,
    String? sectionId,
    String? courseId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Lesson(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      content: content ?? this.content,
      order: order ?? this.order,
      isCompleted: isCompleted ?? this.isCompleted,
      sectionId: sectionId ?? this.sectionId,
      courseId: courseId ?? this.courseId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
