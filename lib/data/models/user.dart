import 'package:equatable/equatable.dart';
import 'base_model.dart';

class User extends BaseModel {
  final String email;
  final String fullName;
  final String? avatar;
  final String? bio;
  final bool isInstructor;
  final List<EnrolledCourse>? enrolledCourses;

  const User({
    required super.id,
    required this.email,
    required this.fullName,
    this.avatar,
    this.bio,
    this.isInstructor = false,
    this.enrolledCourses,
    required super.createdAt,
    required super.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      email: json['email'] as String,
      fullName: json['fullName'] as String,
      avatar: json['avatar'] as String?,
      bio: json['bio'] as String?,
      isInstructor: json['isInstructor'] as bool? ?? false,
      enrolledCourses: json['enrolledCourses'] != null
          ? (json['enrolledCourses'] as List)
              .map((e) => EnrolledCourse.fromJson(e))
              .toList()
          : null,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'fullName': fullName,
      'avatar': avatar,
      'bio': bio,
      'isInstructor': isInstructor,
      'enrolledCourses': enrolledCourses?.map((e) => e.toJson()).toList(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  User copyWith({
    String? id,
    String? email,
    String? fullName,
    String? avatar,
    String? bio,
    bool? isInstructor,
    List<EnrolledCourse>? enrolledCourses,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      avatar: avatar ?? this.avatar,
      bio: bio ?? this.bio,
      isInstructor: isInstructor ?? this.isInstructor,
      enrolledCourses: enrolledCourses ?? this.enrolledCourses,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class EnrolledCourse extends Equatable {
  final String id;
  final String title;
  final double progress;
  final DateTime lastAccessed;

  const EnrolledCourse({
    required this.id,
    required this.title,
    required this.progress,
    required this.lastAccessed,
  });

  factory EnrolledCourse.fromJson(Map<String, dynamic> json) {
    return EnrolledCourse(
      id: json['id'] as String,
      title: json['title'] as String,
      progress: (json['progress'] as num).toDouble(),
      lastAccessed: DateTime.parse(json['lastAccessed'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'progress': progress,
      'lastAccessed': lastAccessed.toIso8601String(),
    };
  }

  @override
  List<Object?> get props => [id, title, progress, lastAccessed];
}
