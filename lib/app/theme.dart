import 'package:flutter/material.dart';

class AppTheme {
  // Private constructor
  AppTheme._();

  // Colors
  static const Color primaryColor = Color(0xFF3F51B5);
  static const Color secondaryColor = Color(0xFF2196F3);
  static const Color accentColor = Color(0xFF4CAF50);
  static const Color errorColor = Color(0xFFE53935);
  static const Color successColor = Color(0xFF43A047);
  static const Color warningColor = Color(0xFFFFA000);
  static const Color infoColor = Color(0xFF1E88E5);

  // Light Theme Colors
  static const Color lightBackgroundColor = Color(0xFFF5F5F5);
  static const Color lightCardColor = Colors.white;
  static const Color lightDividerColor = Color(0xFFBDBDBD);
  static const Color lightTextPrimaryColor = Color(0xFF212121);
  static const Color lightTextSecondaryColor = Color(0xFF757575);

  // Dark Theme Colors
  static const Color darkBackgroundColor = Color(0xFF121212);
  static const Color darkCardColor = Color(0xFF1E1E1E);
  static const Color darkDividerColor = Color(0xFF424242);
  static const Color darkTextPrimaryColor = Color(0xFFEEEEEE);
  static const Color darkTextSecondaryColor = Color(0xFFB0B0B0);

  // Animation durations
  static const Duration shortAnimationDuration = Duration(milliseconds: 200);
  static const Duration mediumAnimationDuration = Duration(milliseconds: 300);
  static const Duration longAnimationDuration = Duration(milliseconds: 500);

  // Padding & Spacing
  static const double defaultPadding = 16.0;
  static const double smallPadding = 8.0;
  static const double largePadding = 24.0;
  static const double extraLargePadding = 32.0;

  // Border Radius
  static const double defaultBorderRadius = 8.0;
  static const double smallBorderRadius = 4.0;
  static const double largeBorderRadius = 12.0;
  static const double cardBorderRadius = 16.0;
  static const double circularBorderRadius = 100.0;

  // Typography
  static const String fontFamily = 'Poppins';

  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.light(
      primary: primaryColor,
      secondary: secondaryColor,
      error: errorColor,
      background: lightBackgroundColor,
      surface: lightCardColor,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onBackground: lightTextPrimaryColor,
      onSurface: lightTextPrimaryColor,
      onError: Colors.white,
    ),
    scaffoldBackgroundColor: lightBackgroundColor,
    cardTheme: CardTheme(
      color: lightCardColor,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(cardBorderRadius),
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: TextStyle(
        fontFamily: fontFamily,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
    ),
    textTheme: TextTheme(
      displayLarge: TextStyle(
        fontFamily: fontFamily,
        color: lightTextPrimaryColor,
        fontWeight: FontWeight.bold,
      ),
      displayMedium: TextStyle(
        fontFamily: fontFamily,
        color: lightTextPrimaryColor,
        fontWeight: FontWeight.bold,
      ),
      displaySmall: TextStyle(
        fontFamily: fontFamily,
        color: lightTextPrimaryColor,
        fontWeight: FontWeight.bold,
      ),
      headlineMedium: TextStyle(
        fontFamily: fontFamily,
        color: lightTextPrimaryColor,
        fontWeight: FontWeight.w600,
      ),
      headlineSmall: TextStyle(
        fontFamily: fontFamily,
        color: lightTextPrimaryColor,
        fontWeight: FontWeight.w600,
      ),
      titleLarge: TextStyle(
        fontFamily: fontFamily,
        color: lightTextPrimaryColor,
        fontWeight: FontWeight.w600,
      ),
      titleMedium: TextStyle(
        fontFamily: fontFamily,
        color: lightTextPrimaryColor,
        fontWeight: FontWeight.w500,
      ),
      titleSmall: TextStyle(
        fontFamily: fontFamily,
        color: lightTextPrimaryColor,
        fontWeight: FontWeight.w500,
      ),
      bodyLarge: TextStyle(
        fontFamily: fontFamily,
        color: lightTextPrimaryColor,
      ),
      bodyMedium: TextStyle(
        fontFamily: fontFamily,
        color: lightTextPrimaryColor,
      ),
      bodySmall: TextStyle(
        fontFamily: fontFamily,
        color: lightTextSecondaryColor,
      ),
      labelLarge: TextStyle(
        fontFamily: fontFamily,
        color: primaryColor,
        fontWeight: FontWeight.w500,
      ),
    ),
    dividerTheme: DividerThemeData(
      color: lightDividerColor,
      thickness: 1,
      space: 1,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.all(defaultPadding),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(defaultBorderRadius),
        borderSide: BorderSide(color: lightDividerColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(defaultBorderRadius),
        borderSide: BorderSide(color: lightDividerColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(defaultBorderRadius),
        borderSide: BorderSide(color: primaryColor, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(defaultBorderRadius),
        borderSide: BorderSide(color: errorColor, width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(defaultBorderRadius),
        borderSide: BorderSide(color: errorColor, width: 2),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: primaryColor,
        padding: const EdgeInsets.symmetric(
          horizontal: defaultPadding,
          vertical: defaultPadding,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(defaultBorderRadius),
        ),
        textStyle: TextStyle(
          fontFamily: fontFamily,
          fontWeight: FontWeight.w600,
        ),
        elevation: 0,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: primaryColor,
        side: BorderSide(color: primaryColor),
        padding: const EdgeInsets.symmetric(
          horizontal: defaultPadding,
          vertical: defaultPadding,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(defaultBorderRadius),
        ),
        textStyle: TextStyle(
          fontFamily: fontFamily,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: primaryColor,
        padding: const EdgeInsets.symmetric(
          horizontal: defaultPadding,
          vertical: smallPadding,
        ),
        textStyle: TextStyle(
          fontFamily: fontFamily,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return lightDividerColor;
          }
          return primaryColor;
        },
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(smallBorderRadius),
      ),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return lightDividerColor;
          }
          if (states.contains(MaterialState.selected)) {
            return primaryColor;
          }
          return Colors.white;
        },
      ),
      trackColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return lightDividerColor.withOpacity(0.5);
          }
          if (states.contains(MaterialState.selected)) {
            return primaryColor.withOpacity(0.5);
          }
          return lightDividerColor;
        },
      ),
    ),
    tabBarTheme: TabBarTheme(
      labelColor: primaryColor,
      unselectedLabelColor: lightTextSecondaryColor,
      indicatorColor: primaryColor,
      labelStyle: TextStyle(
        fontFamily: fontFamily,
        fontWeight: FontWeight.w600,
      ),
      unselectedLabelStyle: TextStyle(
        fontFamily: fontFamily,
      ),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: lightCardColor,
      disabledColor: lightDividerColor.withOpacity(0.2),
      selectedColor: primaryColor,
      secondarySelectedColor: secondaryColor,
      padding: const EdgeInsets.symmetric(
        horizontal: defaultPadding,
        vertical: smallPadding,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(circularBorderRadius),
      ),
      labelStyle: TextStyle(
        fontFamily: fontFamily,
        color: lightTextPrimaryColor,
      ),
      secondaryLabelStyle: TextStyle(
        fontFamily: fontFamily,
        color: Colors.white,
      ),
      brightness: Brightness.light,
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: lightCardColor,
      contentTextStyle: TextStyle(
        fontFamily: fontFamily,
        color: lightTextPrimaryColor,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(defaultBorderRadius),
      ),
      behavior: SnackBarBehavior.floating,
    ),
    dialogTheme: DialogTheme(
      backgroundColor: lightCardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(largeBorderRadius),
      ),
      titleTextStyle: TextStyle(
        fontFamily: fontFamily,
        color: lightTextPrimaryColor,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
      contentTextStyle: TextStyle(
        fontFamily: fontFamily,
        color: lightTextPrimaryColor,
      ),
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: lightCardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(largeBorderRadius),
        ),
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: lightCardColor,
      selectedItemColor: primaryColor,
      unselectedItemColor: lightTextSecondaryColor,
      selectedLabelStyle: TextStyle(
        fontFamily: fontFamily,
        fontWeight: FontWeight.w500,
      ),
      unselectedLabelStyle: TextStyle(
        fontFamily: fontFamily,
      ),
      type: BottomNavigationBarType.fixed,
      elevation: 8,
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: primaryColor,
      circularTrackColor: lightDividerColor.withOpacity(0.2),
      linearTrackColor: lightDividerColor.withOpacity(0.2),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.dark(
  primary: primaryColor,
  secondary: secondaryColor,
  error: errorColor,
  background: darkBackgroundColor,
  surface: darkCardColor,
  onPrimary: Colors.white,
  onSecondary: Colors.white,
  onBackground: darkTextPrimaryColor,
  onSurface: darkTextPrimaryColor,
  onError: Colors.white,
  ),
  scaffoldBackgroundColor: darkBackgroundColor,
  cardTheme: CardTheme(
  color: darkCardColor,
  elevation: 4,
  shape: RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(cardBorderRadius),
  ),
  ),
  appBarTheme: AppBarTheme(
  backgroundColor: darkCardColor,
  foregroundColor: darkTextPrimaryColor,
  elevation: 0,
  centerTitle: false,
  titleTextStyle: TextStyle(
  fontFamily: fontFamily,
  fontWeight: FontWeight.bold,
  fontSize: 20,
  color: darkTextPrimaryColor,
  ),
  ),
  textTheme: TextTheme(
  displayLarge: TextStyle(
  fontFamily: fontFamily,
  color: darkTextPrimaryColor,
  fontWeight: FontWeight.bold,
  ),
  displayMedium: TextStyle(
  fontFamily: fontFamily,
  color: darkTextPrimaryColor,
  fontWeight: FontWeight.bold,
  ),
  displaySmall: TextStyle(
  fontFamily: fontFamily,
  color: darkTextPrimaryColor,
  fontWeight: FontWeight.bold,
  ),
  headlineMedium: TextStyle(
  fontFamily: fontFamily,
  color: darkTextPrimaryColor,
  fontWeight: FontWeight.w600,
  ),
  headlineSmall: TextStyle(
  fontFamily: fontFamily,
  color: darkTextPrimaryColor,
  fontWeight: FontWeight.w600,
  ),
  titleLarge: TextStyle(
  fontFamily: fontFamily,
  color: darkTextPrimaryColor,
  fontWeight: FontWeight.w600,
  ),
  titleMedium: TextStyle(
  fontFamily: fontFamily,
  color: darkTextPrimaryColor,
  fontWeight: FontWeight.w500,
  ),
  titleSmall: TextStyle(
  fontFamily: fontFamily,
  color: darkTextPrimaryColor,
  fontWeight: FontWeight.w500,
  ),
  bodyLarge: TextStyle(
  fontFamily: fontFamily,
  color: darkTextPrimaryColor,
  ),
  bodyMedium: TextStyle(
  fontFamily: fontFamily,
  color: darkTextPrimaryColor,
  ),
  bodySmall: TextStyle(
  fontFamily: fontFamily,
  color: darkTextSecondaryColor,
  ),
  labelLarge: TextStyle(
  fontFamily: fontFamily,
  color: primaryColor,
  fontWeight: FontWeight.w500,
  ),
  ),
  dividerTheme: DividerThemeData(
  color: darkDividerColor,
  thickness: 1,
  space: 1,
  ),
  inputDecorationTheme: InputDecorationTheme(
  filled: true,
  fillColor: darkCardColor,
  contentPadding: const EdgeInsets.all(defaultPadding),
  border: OutlineInputBorder(
  borderRadius: BorderRadius.circular(defaultBorderRadius),
  borderSide: BorderSide(color: darkDividerColor),
  ),
  enabledBorder: OutlineInputBorder(
  borderRadius: BorderRadius.circular(defaultBorderRadius),
  borderSide: BorderSide(color: darkDividerColor),
  ),
  focusedBorder: OutlineInputBorder(
  borderRadius: BorderRadius.circular(defaultBorderRadius),
  borderSide: BorderSide(color: primaryColor, width: 2),
  ),
  errorBorder: OutlineInputBorder(
  borderRadius: BorderRadius.circular(defaultBorderRadius),
  borderSide: BorderSide(color: errorColor, width: 1),
  ),
  focusedErrorBorder: OutlineInputBorder(
  borderRadius: BorderRadius.circular(defaultBorderRadius),
  borderSide: BorderSide(color: errorColor, width: 2),
  ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
  style: ElevatedButton.styleFrom(
  foregroundColor: Colors.white,
  backgroundColor: primaryColor,
  padding: const EdgeInsets.symmetric(
  horizontal: defaultPadding,
  vertical: defaultPadding,
  ),
  shape: RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(defaultBorderRadius),
  ),
  textStyle: TextStyle(
  fontFamily: fontFamily,
  fontWeight: FontWeight.w600,
  ),
  elevation: 0,
  ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
  style: OutlinedButton.styleFrom(
  foregroundColor: primaryColor,
  side: BorderSide(color: primaryColor),
  padding: const EdgeInsets.symmetric(
  horizontal: defaultPadding,
  vertical: defaultPadding,
  ),
  shape: RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(defaultBorderRadius),
  ),
  textStyle: TextStyle(
  fontFamily: fontFamily,
  fontWeight: FontWeight.w600,
  ),
  ),
  ),
  textButtonTheme: TextButtonThemeData(
  style: TextButton.styleFrom(
  foregroundColor: primaryColor,
  padding: const EdgeInsets.symmetric(
  horizontal: defaultPadding,
  vertical: smallPadding,
  ),
  textStyle: TextStyle(
  fontFamily: fontFamily,
  fontWeight: FontWeight.w600,
  ),
  ),
  ),
  checkboxTheme: CheckboxThemeData(
  fillColor: MaterialStateProperty.resolveWith<Color>(
  (Set<MaterialState> states) {
  if (states.contains(MaterialState.disabled)) {
  return darkDividerColor;
  }
  return primaryColor;
  },
  ),
  shape: RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(smallBorderRadius),
  ),
  ),
  switchTheme: SwitchThemeData(
  thumbColor: MaterialStateProperty.resolveWith<Color>(
  (Set<MaterialState> states) {
  if (states.contains(MaterialState.disabled)) {
  return darkDividerColor;
  }
  if (states.contains(MaterialState.selected)) {
  return primaryColor;
  }
  return darkTextPrimaryColor;
  },
  ),
  trackColor: MaterialStateProperty.resolveWith<Color>(
  (Set<MaterialState> states) {
  if (states.contains(MaterialState.disabled)) {
  return darkDividerColor.withOpacity(0.5);
  }
  if (states.contains(MaterialState.selected)) {
    return primaryColor.withOpacity(0.5);
  }
  return darkDividerColor;
  },
  ),
  ),
    tabBarTheme: TabBarTheme(
      labelColor: primaryColor,
      unselectedLabelColor: darkTextSecondaryColor,
      indicatorColor: primaryColor,
      labelStyle: TextStyle(
        fontFamily: fontFamily,
        fontWeight: FontWeight.w600,
      ),
      unselectedLabelStyle: TextStyle(
        fontFamily: fontFamily,
      ),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: darkCardColor,
      disabledColor: darkDividerColor.withOpacity(0.2),
      selectedColor: primaryColor,
      secondarySelectedColor: secondaryColor,
      padding: const EdgeInsets.symmetric(
        horizontal: defaultPadding,
        vertical: smallPadding,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(circularBorderRadius),
      ),
      labelStyle: TextStyle(
        fontFamily: fontFamily,
        color: darkTextPrimaryColor,
      ),
      secondaryLabelStyle: TextStyle(
        fontFamily: fontFamily,
        color: Colors.white,
      ),
      brightness: Brightness.dark,
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: darkCardColor,
      contentTextStyle: TextStyle(
        fontFamily: fontFamily,
        color: darkTextPrimaryColor,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(defaultBorderRadius),
      ),
      behavior: SnackBarBehavior.floating,
    ),
    dialogTheme: DialogTheme(
      backgroundColor: darkCardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(largeBorderRadius),
      ),
      titleTextStyle: TextStyle(
        fontFamily: fontFamily,
        color: darkTextPrimaryColor,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
      contentTextStyle: TextStyle(
        fontFamily: fontFamily,
        color: darkTextPrimaryColor,
      ),
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: darkCardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(largeBorderRadius),
        ),
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: darkCardColor,
      selectedItemColor: primaryColor,
      unselectedItemColor: darkTextSecondaryColor,
      selectedLabelStyle: TextStyle(
        fontFamily: fontFamily,
        fontWeight: FontWeight.w500,
      ),
      unselectedLabelStyle: TextStyle(
        fontFamily: fontFamily,
      ),
      type: BottomNavigationBarType.fixed,
      elevation: 8,
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: primaryColor,
      circularTrackColor: darkDividerColor.withOpacity(0.2),
      linearTrackColor: darkDividerColor.withOpacity(0.2),
    ),
  );
}