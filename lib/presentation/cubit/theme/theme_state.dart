part of 'theme_cubit.dart';

abstract class ThemeState {
  final ThemeMode themeMode;

  const ThemeState({required this.themeMode});
}

class ThemeInitial extends ThemeState {
  const ThemeInitial() : super(themeMode: ThemeMode.system);
}

class ThemeLoaded extends ThemeState {
  const ThemeLoaded(ThemeMode mode) : super(themeMode: mode);
}
