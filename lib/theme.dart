import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum ThemeModeType {
  light,
  dark,
  system,
}

class ThemeManager with ChangeNotifier {
  ThemeModeType _themeMode = ThemeModeType.light;
  final String _themeModeKey = 'themeMode';

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
    _saveThemeMode();
    notifyListeners();
  }

  // Method to update theme mode based on user preference
  void updateThemeMode(ThemeModeType mode) {
    _themeMode = mode;
    _saveThemeMode();
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
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: const Color.fromRGBO(7, 106, 154, 1.000),
        shadowColor: Colors.grey[600],
        surfaceTintColor: Colors.white,
        elevation: 10.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        minimumSize: const Size(double.infinity, 60.0),
      ),
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
        foregroundColor: const Color.fromRGBO(192, 230, 255, 1),
        shadowColor: Colors.grey[600],
        surfaceTintColor: Colors.black,
        elevation: 10.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: const Color.fromRGBO(192, 230, 255, 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
    ),
    fontFamily: "Karla",
    useMaterial3: true,
  );

  Future<void> _saveThemeMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_themeModeKey, _themeMode.index);
  }

  Future<void> _loadThemeMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? savedThemeMode = prefs.getInt(_themeModeKey);
    if (savedThemeMode != null) {
      _themeMode = ThemeModeType.values[savedThemeMode];
      notifyListeners();
    }
  }

  // Constructor to load the theme mode when the class is initialized
  ThemeManager() {
    _loadThemeMode();
  }
}
