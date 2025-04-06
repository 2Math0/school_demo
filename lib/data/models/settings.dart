import 'package:equatable/equatable.dart';

class Settings extends Equatable {
  final String id;
  final String userId;
  final String themeMode;
  final String languageCode;
  final bool emailNotifications;
  final bool pushNotifications;
  final Map<String, bool> notificationTypes;
  final bool highContrast;
  final bool largeText;
  final bool screenReader;
  final DateTime updatedAt;

  const Settings({
    required this.id,
    required this.userId,
    required this.themeMode,
    required this.languageCode,
    required this.emailNotifications,
    required this.pushNotifications,
    required this.notificationTypes,
    required this.highContrast,
    required this.largeText,
    required this.screenReader,
    required this.updatedAt,
  });

  factory Settings.fromJson(Map<String, dynamic> json) {
    return Settings(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      themeMode: json['theme_mode'] as String? ?? 'system',
      languageCode: json['language_code'] as String? ?? 'en',
      emailNotifications: json['email_notifications'] as bool? ?? true,
      pushNotifications: json['push_notifications'] as bool? ?? true,
      notificationTypes:
          Map<String, bool>.from(json['notification_types'] as Map? ?? {}),
      highContrast: json['high_contrast'] as bool? ?? false,
      largeText: json['large_text'] as bool? ?? false,
      screenReader: json['screen_reader'] as bool? ?? false,
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'theme_mode': themeMode,
      'language_code': languageCode,
      'email_notifications': emailNotifications,
      'push_notifications': pushNotifications,
      'notification_types': notificationTypes,
      'high_contrast': highContrast,
      'large_text': largeText,
      'screen_reader': screenReader,
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  Settings copyWith({
    String? id,
    String? userId,
    String? themeMode,
    String? languageCode,
    bool? emailNotifications,
    bool? pushNotifications,
    Map<String, bool>? notificationTypes,
    bool? highContrast,
    bool? largeText,
    bool? screenReader,
    DateTime? updatedAt,
  }) {
    return Settings(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      themeMode: themeMode ?? this.themeMode,
      languageCode: languageCode ?? this.languageCode,
      emailNotifications: emailNotifications ?? this.emailNotifications,
      pushNotifications: pushNotifications ?? this.pushNotifications,
      notificationTypes: notificationTypes ?? this.notificationTypes,
      highContrast: highContrast ?? this.highContrast,
      largeText: largeText ?? this.largeText,
      screenReader: screenReader ?? this.screenReader,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        userId,
        themeMode,
        languageCode,
        emailNotifications,
        pushNotifications,
        notificationTypes,
        highContrast,
        largeText,
        screenReader,
        updatedAt,
      ];
}
