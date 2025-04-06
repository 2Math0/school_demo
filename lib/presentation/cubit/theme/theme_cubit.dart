import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(const ThemeInitial()) {
    _loadThemeMode();
  }

  static const String _themeKey = 'theme_mode';

  Future<void> _loadThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final themeModeIndex = prefs.getInt(_themeKey) ?? ThemeMode.system.index;
    emit(ThemeLoaded(ThemeMode.values[themeModeIndex]));
  }

  Future<void> toggleTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final currentMode = state.themeMode;
    final newMode = currentMode == ThemeMode.light
        ? ThemeMode.dark
        : currentMode == ThemeMode.dark
            ? ThemeMode.system
            : ThemeMode.light;

    await prefs.setInt(_themeKey, newMode.index);
    emit(ThemeLoaded(newMode));
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_themeKey, mode.index);
    emit(ThemeLoaded(mode));
  }
}
