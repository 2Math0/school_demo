import '../../core/services/supabase_service.dart';
import '../../core/exceptions/app_exception.dart';
import '../models/settings.dart';

class SettingsRepository {
  final SupabaseService supabaseService;

  const SettingsRepository({required this.supabaseService});

  Future<Settings> getSettings(String userId) async {
    try {
      final response = await supabaseService.client
          .from('settings')
          .select()
          .eq('user_id', userId)
          .single();

      return Settings.fromJson(response);
    } catch (e) {
      throw AppException(
        message: 'Failed to fetch settings',
        details: e.toString(),
      );
    }
  }

  Future<void> updateSettings({
    required String userId,
    required Settings settings,
  }) async {
    try {
      await supabaseService.client
          .from('settings')
          .update(settings.toJson())
          .eq('user_id', userId);
    } catch (e) {
      throw AppException(
        message: 'Failed to update settings',
        details: e.toString(),
      );
    }
  }

  Future<void> resetSettings(String userId) async {
    try {
      await supabaseService.client
          .from('settings')
          .delete()
          .eq('user_id', userId);
    } catch (e) {
      throw AppException(
        message: 'Failed to reset settings',
        details: e.toString(),
      );
    }
  }

  Future<Settings> setThemeMode({
    required String userId,
    required String themeMode,
  }) async {
    try {
      final response = await supabaseService.client
          .from('user_settings')
          .upsert({
            'user_id': userId,
            'theme_mode': themeMode,
            'updated_at': DateTime.now().toIso8601String(),
          })
          .select()
          .single();

      return Settings.fromJson(response);
    } catch (e) {
      throw AppException(
        message: 'Failed to set theme mode',
        details: e.toString(),
      );
    }
  }

  Future<Settings> setNotificationPreferences({
    required String userId,
    required bool emailNotifications,
    required bool pushNotifications,
    required Map<String, bool> notificationTypes,
  }) async {
    try {
      final response = await supabaseService.client
          .from('user_settings')
          .upsert({
            'user_id': userId,
            'email_notifications': emailNotifications,
            'push_notifications': pushNotifications,
            'notification_types': notificationTypes,
            'updated_at': DateTime.now().toIso8601String(),
          })
          .select()
          .single();

      return Settings.fromJson(response);
    } catch (e) {
      throw AppException(
        message: 'Failed to set notification preferences',
        details: e.toString(),
      );
    }
  }

  Future<Settings> setLanguage({
    required String userId,
    required String languageCode,
  }) async {
    try {
      final response = await supabaseService.client
          .from('user_settings')
          .upsert({
            'user_id': userId,
            'language_code': languageCode,
            'updated_at': DateTime.now().toIso8601String(),
          })
          .select()
          .single();

      return Settings.fromJson(response);
    } catch (e) {
      throw AppException(
        message: 'Failed to set language',
        details: e.toString(),
      );
    }
  }

  Future<Settings> setAccessibilitySettings({
    required String userId,
    required bool highContrast,
    required bool largeText,
    required bool screenReader,
  }) async {
    try {
      final response = await supabaseService.client
          .from('user_settings')
          .upsert({
            'user_id': userId,
            'high_contrast': highContrast,
            'large_text': largeText,
            'screen_reader': screenReader,
            'updated_at': DateTime.now().toIso8601String(),
          })
          .select()
          .single();

      return Settings.fromJson(response);
    } catch (e) {
      throw AppException(
        message: 'Failed to set accessibility settings',
        details: e.toString(),
      );
    }
  }
}
