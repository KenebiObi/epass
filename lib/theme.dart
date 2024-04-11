import 'package:flutter/material.dart';

enum ThemeModeType {
  light,
  dark,
  system,
}

class ThemeManager with ChangeNotifier {
  ThemeModeType _themeMode = ThemeModeType.system;

  ThemeModeType get themeMode => _themeMode;

  // Method to toggle between light and dark mode
  void toggleTheme() {
    switch (_themeMode) {
      case ThemeModeType.light:
        _themeMode = ThemeModeType.dark;
        break;
      case ThemeModeType.dark:
        _themeMode = ThemeModeType.light;
        break;
      case ThemeModeType.system:
        _themeMode = ThemeModeType.light;
        break;
    }
    notifyListeners();
  }

  // Method to update theme mode based on user preference
  void updateThemeMode(ThemeModeType mode) {
    _themeMode = mode;
    notifyListeners();
  }

  ThemeData lightThemes = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      primary: const Color.fromRGBO(7, 106, 154, 1.000),
      secondary: Colors.blue[100]!,
      tertiary: Colors.grey[700],
      background: Colors.white,
    ),
    fontFamily: "Karla",
    useMaterial3: true,
  );
  final darkThemes = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      primary: const Color.fromRGBO(7, 106, 154, 1.000),
      secondary: const Color.fromRGBO(192, 230, 255, 1),
      tertiary: Colors.grey[700],
      background: Colors.grey[900]!,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        // backgroundColor: Colors.white,
        shadowColor: Colors.grey[600],
        elevation: 10.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        // foregroundColor: const Color.fromRGBO(7, 106, 154, 1.000),
        // minimumSize: const Size(double.infinity, 70.0)
      ),
    ),
    fontFamily: "Karla",
    useMaterial3: true,
  );
}
