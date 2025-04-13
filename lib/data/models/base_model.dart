import 'package:equatable/equatable.dart';

abstract class BaseModel extends Equatable {
  final String id;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const BaseModel({
    required this.id,
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [id, createdAt, updatedAt];

  Map<String, dynamic> toJson();
}
