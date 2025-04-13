import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repositories/settings_repository.dart';
import '../../../data/models/settings.dart';
import 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final SettingsRepository settingsRepository;
  String userId;

  SettingsCubit({
    required this.settingsRepository,
    required this.userId,
  }) : super(const SettingsInitial());

  void updateUserId(String newUserId) {
    userId = newUserId;
  }

  Future<void> loadSettings() async {
    try {
      emit(const SettingsLoading());
      final settings = await settingsRepository.getSettings(userId);
      emit(SettingsLoaded(settings: settings));
    } catch (e) {
      emit(SettingsError(message: e.toString()));
    }
  }

  Future<void> updateSettings(Settings settings) async {
    try {
      emit(const SettingsLoading());
      await settingsRepository.updateSettings(
        userId: userId,
        settings: settings,
      );
      final updatedSettings = await settingsRepository.getSettings(userId);
      emit(SettingsLoaded(settings: updatedSettings));
    } catch (e) {
      emit(SettingsError(message: e.toString()));
    }
  }

  Future<void> resetSettings() async {
    try {
      emit(const SettingsLoading());
      await settingsRepository.resetSettings(userId);
      final defaultSettings = await settingsRepository.getSettings(userId);
      emit(SettingsLoaded(settings: defaultSettings));
    } catch (e) {
      emit(SettingsError(message: e.toString()));
    }
  }
}
